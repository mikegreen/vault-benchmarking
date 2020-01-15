-- Script that writes and then deletes secrets in k/v engine in Vault
-- This should use be used with -t1 -c1
-- Additionally, add "-- <identifier>" after URL to pass ID so that multiple instances
-- of the script can be run in parallel
-- <identifier> should ideally be integers 1, 2, 3, ... with different identifier for each
-- script run in parallel
-- Also, to specify the number of distinct secrets to write and delete for each instance, add a second argument.
-- Together, you would add "-- <identifier> <num_secrets>
-- Note that the script might not delete final secret written if the last method invoked
-- is a write
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
      identifier = 1
   else
      identifier = args[1]
   end
   if args[2] == nil then
      num_secrets = 100
   else
      num_secrets = tonumber(args[2])
   end
   print("Number of secrets is: " .. num_secrets)
   requests  = 0
   writes = 0
   deletes = 0
   responses = 0
   path = "/v1/secret/write-delete-test/secret-0"
   local msg = "thread %d created"
   print(msg:format(id))
end

function request()
   -- We assumse -t1 and -c2, meaning one thread and two connections
   -- Note that first and third requests are used for testing connections
   -- They are not actually invoked
   -- So, we don't write first secret until request 4
   requests = requests + 1
   if requests > 3 and requests % 2 == 0 then
      -- Write secret
      method = "POST"
      path = "/v1/secret/write-delete-test/test" .. identifier .. "-secret-" .. (writes % num_secrets) + 1
      body = '{"thread-' .. id .. '" : "write-' .. writes ..'","extra" : "1xxxxxxxxx2xxxxxxxxx3xxxxxxxxx4xxxxxxxxx5xxxxxxxxx6xxxxxxxxx7xxxxxxxxx8xxxxxxxxx9xxxxxxxxx0xxxxxxxxx"}'
      writes = writes + 1
   else
      -- Delete secret
      method = "DELETE"
      -- Reuse last path, so don't set one
      body = ''
      deletes = deletes + 1
   end
   -- local msg = "request: %d: method is %s, path is: %s"
   -- print(msg:format(requests, method, path))
   return wrk.format(method, path, nil, body)
end

function response(status, headers, body)
   if status == 200  or status == 204 then
      responses = responses + 1
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
