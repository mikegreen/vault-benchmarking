-- Script that lists secrets from k/v engine in Vault
-- If you want to print the secrets found for each list, add "-- true" after the URL

json = require "json"

local counter = 1
local threads = {}

function setup(thread)
   thread:set("id", counter)
   table.insert(threads, thread)
   counter = counter + 1
end

function init(args)
   require("check_envvars")
   check_envvars()

   if args[1] == nil then
      print_secrets = "false"
   else
      print_secrets = args[1]
   end
   print_secrets = args[1]
   requests  = 0
   lists = 0
   responses = 0
   method = "GET"
   path = "/v1/secret/list-test?list=true"
   body = ""
   local msg = "thread %d created with print_secrets set to %s"
   print(msg:format(id, print_secrets))
end

function request()
   lists = lists + 1
   requests = requests + 1
   return wrk.format(method, path, nil, body)
end

function response(status, headers, body)
   responses = responses + 1
   if print_secrets == "true" then
      body_object = json.decode(body)
      for k,v in pairs(body_object) do 
         if k == "data" then
            local count = 0
            for k1,v1 in pairs(v) do
               for _, v2 in pairs(v1) do
                  count = count + 1
                  local msg = "response %d found secret: %s"
                  print(msg:format(responses,v2)) 
               end
               local msg = "Found %d secrets in list"
               print(msg:format(count))
            end
         end
      end
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
