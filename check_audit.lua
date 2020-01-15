function check_audit()
        local file = assert(io.popen('vault audit list', 'r'))
        local audit_output = file:read('*all')
        file:close()
--        print("Audit list says: " .. audit_output) -- > Prints the output of the command.

        if string.match(audit_output, "No audit devices are enabled.") then
                print "Auditing is disabled"
		audit_enabled = false
        else
                print "Audit is enabled. Eventually this should tell you which audit method as well."
		audit_enabled = true
        end
	return audit_enabled
end

