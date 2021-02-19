-- from 
-- https://github.com/jdfriedma/Vault-Transit-Load-Testing/blob/master/postbatch320.lua
-- example HTTP POST script which demonstrates setting the
-- HTTP method, body, and adding a header
-- example usage:
-- wrk -t1 -c1 -d10s -H "X-Vault-Token: $VAULT_TOKEN" -s transit_post320.lua $VAULT_ADDR/v1/transitTest/encrypt/test  -- 500000
-- If you're using HCP Vault, you'll need to add a namespace (or your custom one)
-- wrk -t1 -c1 -d10s -H "X-Vault-Token: $VAULT_TOKEN" -H "X-Vault-Namespace: admin" -s transit_post320.lua $VAULT_ADDR/v1/transitTest/encrypt/test  -- 500000


wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"

local counter = 1
local threads = {}
local transitPayloadLength = 4096

function setup(thread)
   thread:set("id", counter)
   table.insert(threads, thread)
   counter = counter + 1
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

-- char map for enc to base64 function
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- encode base64 function
function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end


function init(args)
  -- Go check for vault token/address
	require("check_envvars")
	check_envvars()

  -- check if number of encrypts was passed as argument 1 
  fieldName, encrypts = args[1]:match("([^,]+)=([^,]+)")
  -- if we can't figure out argument 1 is in encrypts=5000 format, assume it might just be a number 
  if fieldName == nil then
    print(args[1])
    encrypts = tonumber(args[1])
  elseif not string.match(fieldName, "encrypts") then
    print("encrypts value should be provided as 2nd to last argument (last argument is debug=true/false)")
  end

  -- if no arguments passed at end, just run for 1000 
  if args[1] == nil then
    num_secrets = 1000
  else
    num_secrets = tonumber(encrypts)
  end
  -- below will print for each thread 
  print("Number of transit requests to encrypt is: " .. num_secrets)
  print("Transit payload size is: " .. transitPayloadLength .. " characters")

  -- check if debug is enabled, if passed as argument 2
  -- print lots of info, this can slow down due to the verbosity of traffic
  if args[2] == nil then
      print("Debug is disabled. To enable, after encrypts argument, add debug=true")
      printDebug = false
    elseif string.match(args[2],"debug=true") then
      print("Debug is enabled")
      printDebug = true 
    else
      print("Debug is disabled")
      printDebug = false
    end

   requests  = 0
   responses = 0
   method = "POST"
   path = "/v1/transitTest/encrypt/test"
   body = ""
   local msg = "thread %d created"
   print(msg:format(id))	
end

function request()
	-- print("starting request " .. requests)
	body = '{"plaintext":"' .. enc(RandomVariable(transitPayloadLength)) .. '" }'
	requests = requests + 1
	while num_secrets > responses do
    if printDebug then
      print(path)
      print(wrk.headers)
      print(body)
    end
		return wrk.format(method, path, wrk.headers, body)
	end
end

function response(status, headers, body)
	responses = responses + 1
	if printDebug then
    print("Thread " .. id .. " - starting response " .. responses)
  end
	-- if non-200 returned, print for debugging
	if status ~= 200 then
		print(headers)
		print(body)
		print(status)
	end
	if printDebug then
  	print(body)
  end
	if responses == num_secrets then
		print("done, now summarize results")
		-- wrk.thread:stop()
		-- os.exit()
	end
end

done = function(summary, latency, requests)
	require("check_audit")
	audit_enabled = check_audit()

	io.write("\nJSON Output:\n")
   io.write("{\n")
   io.write(string.format("\t\"requests\": %d,\n", summary.requests))
   io.write(string.format("\t\"duration_in_microseconds\": %0.2f,\n", summary.duration))
   io.write(string.format("\t\"bytes\": %d,\n", summary.bytes))
   io.write(string.format("\t\"requests_per_sec\": %0.2f,\n", (summary.requests/summary.duration)*1e6))
   io.write(string.format("\t\"bytes_transfer_per_sec\": %0.2f,\n", (summary.bytes/summary.duration)*1e6))

   io.write("\t\"latency_distribution\": [\n")
   for _, p in pairs({ 50, 75, 90, 99, 99.9, 99.99, 99.999, 100 }) do
      io.write("\t\t{\n")
      n = latency:percentile(p)
      io.write(string.format("\t\t\t\"percentile\": %g,\n\t\t\t\"latency_in_microseconds\": %d\n", p, n))
      if p == 100 then 
          io.write("\t\t}\n")
      else 
          io.write("\t\t},\n")
      end
   end
   io.write("\t]\n}\n")
end

