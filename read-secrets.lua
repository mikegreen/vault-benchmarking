-- Script that reads secrets from k/v engine in Vault
-- To indicate the number of secrets you want to read, add "-- <N>" after the URL
-- If you want to print secrets read, add "-- <N> true" after the URL

json = require "json"

local counter = 1
local threads = {}

function setup(thread)
   thread:set("id", counter)
   table.insert(threads, thread)
   counter = counter + 1
end

function init(args)
   -- check if $VAULT_TOKEN exists, if not exit
   if isempty(os.getenv("VAULT_TOKEN")) then
      print("VAULT_TOKEN not found, cannot continue..")
      os.exit()
   else
      print("VAULT_TOKEN found")
   end
   -- check if $VAULT_ADDR exists, if not exit
   if isempty(os.getenv("VAULT_ADDR")) then
      print("VAULT_ADDR not found, cannot continue..")
      os.exit()
   else
      print("VAULT_ADDR found")
   end

   if args[1] == nil then
      num_secrets = 1000
   else
      num_secrets = tonumber(args[1])
   end
   print("Number of secrets is: " .. num_secrets)
   if args[2] == nil then
      print_secrets = "false"
   else
      print_secrets = args[2]
   end
   requests  = 0
   reads = 0
   responses = 0
   method = "GET"
   body = ''
   -- give each thread different random seed
   math.randomseed(os.time() + id*1000)
   local msg = "thread %d created with print_secrets set to %s"
   print(msg:format(id, print_secrets))
end

function request()
   reads = reads + 1
   -- randomize path to secret
   -- if num_secrets is not provided, it defaults above to 1000 which
   -- will result in 404's if you do not have at least 1000 secrets
   -- loaded at the secret/read-test/ path
   path = "/v1/secret/read-test/secret-" .. math.random(num_secrets)
   requests = requests + 1
   return wrk.format(method, path, nil, body)
end

function response(status, headers, body)
   responses = responses + 1
   if print_secrets == "true" then
      body_object = json.decode(body)
      for k,v in pairs(body_object) do 
         if k == "data" then
            print("Secret path: " .. path)
            for k1,v1 in pairs(v) do
               local msg = "read secrets: %s : %s"
               print(msg:format(k1, v1)) 
            end
         end
      end
   end 
end

done = function(summary, latency, requests)
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
