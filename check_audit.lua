-- This function checks if audit is enabled, as that is a big driver in performance
-- It won't work for HCP Vault, as we dont have access to sys/audit, but, we know
--   HCP vault has auditing enabled anyways :-) 
function check_audit()
        local file = assert(io.popen('vault audit list', 'r'))
        local audit_output = file:read('*all')
        file:close()
        print("Audit list says: " .. audit_output) -- > Prints the output of the command.

        if string.match(audit_output, "No audit devices are enabled.") then
                print "Auditing is disabled"
		audit_enabled = false
        elseif string.match(audit_output, "") then
                print "Checking audit returned nothing, unsure if audit is enabled."
                audit_enabled = false
        else
                print "Audit is enabled. Eventually this should tell you which audit method as well."
		audit_enabled = true
        end
	return audit_enabled
end

