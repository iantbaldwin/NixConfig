# Print outdated packages from the package manager
function outdated
	brew outdated > ~/.brewoutdated
	cat ~/.brewoutdated
end
