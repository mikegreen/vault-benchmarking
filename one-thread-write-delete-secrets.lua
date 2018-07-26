-- Script that writes and then deletes secrets in k/v engine in Vault
-- This should use be used with -t1 -c2
-- Additionally, add "-- <identifier>" after URL to pass ID so that multiple instances
-- of the script can be run in parallel
-- <identifier> should ideally be integers 1, 2, 3, ... with different identifier for each
-- script run in parallel
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
   identifier = args[1]
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
      writes = writes + 1
      method = "POST"
      path = "/v1/secret/write-delete-test/test-" .. identifier .. "-secret-" .. writes % 1000
      body = '{"thread-' .. id .. '" : "write-' .. writes ..'","extra" : "1xxxxxxxxx2xxxxxxxxx3xxxxxxxxx4xxxxxxxxx5xxxxxxxxx6xxxxxxxxx7xxxxxxxxx8xxxxxxxxx9xxxxxxxxx0xxxxxxxxx"}'
   else
      -- Delete secret
      method = "DELETE"
      deletes = deletes + 1
      -- Reuse last path, so don't set one
      body = ''
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

function done(summary, latency, requests)
   for index, thread in ipairs(threads) do
      local id        = thread:get("id")
      local requests  = thread:get("requests")
      local writes    = thread:get("writes")
      local deletes   = thread:get("deletes")
      local responses = thread:get("responses")
      local msg = "thread %d made %d requests including %d writes and %d deletes and got %d responses"
      print(msg:format(id, requests, writes, deletes, responses))
   end
end
