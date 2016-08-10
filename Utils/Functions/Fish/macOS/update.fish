# Update the package manager's packages list and then check the outdated packages with the new list
function update
	command brew update
	outdated
end
