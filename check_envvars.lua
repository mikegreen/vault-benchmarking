function check_envvars()
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
end


function isempty(s)
  return s == nil or s == ''
end