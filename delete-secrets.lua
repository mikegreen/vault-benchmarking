-- Script that deletes secrets from k/v engine in Vault
-- Pass the path from which you want to delete secrets
-- by adding "-- <path>" after the URL
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
      path_prefix = "secret/test"
   else
      path_prefix = args[1]
   end
   requests  = 0
   deletes = 0
   responses = 0
   method = "DELETE"
   path = "/v1/" .. path_prefix .. "/secret-0"
   body = ''
   local msg = "thread %d created"
   print(msg:format(id))
end

function request()
   -- First request is not actually invoked
   -- So, don't process it in order to delete secret-1
   if requests > 0 then
      deletes = deletes + 1
      -- Set the path to the desired path with secrets you want to delete
      path = "/v1/" .. path_prefix .. "/secret-" .. deletes
      body = ''
   end
   requests = requests + 1
   return wrk.format(method, path, nil, body)
end

function response(status, headers, body)
   responses = responses + 1
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
