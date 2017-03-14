function ssh-id
	if test (ssh-add -L | grep -c 'The agent has no identities.') -eq 1
		monkeysphere subkey-to-ssh-agent
	end
end
