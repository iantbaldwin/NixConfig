# Upgrade the outdated packages
function upgrade
	command brew upgrade
	command vim +PluginUpdate +qall
	outdated
end
