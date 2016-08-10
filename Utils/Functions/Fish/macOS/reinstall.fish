# Run the instal script and re-source the configuration
function reinstall
	sh $INSTPATH/install.sh
	source $HOME/.config/fish/config.fish
end
