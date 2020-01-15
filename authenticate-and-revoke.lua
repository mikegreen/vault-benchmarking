-- Script that authenticates a user against Vault's userpass system 
-- and then revokes the lease many times

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

   requests  = 0
   authentications = 0
   revocations = 0
   responses = 0
   local msg = "thread %d created"
   print(msg:format(id))
end

function request()
   requests = requests + 1
   if requests > 3 and requests % 2 == 0 then
      -- Authenticate
      authentications = authentications + 1
      method = "POST"
      path = "/v1/auth/userpass/login/loadtester"
      body = '{"password" : "benchmark" }'
      -- print("Authenticating")
   else
      -- Revoke lease
      revocations = revocations + 1
      method = "PUT"
      path = "/v1/sys/leases/revoke-prefix/auth/userpass/login/loadtester"
      body = ''
      -- print("Revoking")
   end
   return wrk.format(method, path, nil, body)
end

function delay()
   return 0
end

function response(status, headers, body)
   if status == 200  or status == 204 then
      responses = responses + 1
   end
   -- print("Status: " .. status)
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
