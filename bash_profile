export HOMEBREW_GITHUB_API_TOKEN=3fe366368034695a68bcee2800acf52f9f908dbd
export PATH=/usr/local/texlive/2015basic/bin/universal-darwin:$PATH
alias exit='killall Terminal;'

#############
# LS Colors #
#############
#	a/A - black/bold black
#	b/B - red/bold red
#	c/C - green/bold green
#	d/D - brown/bold brown
#	e/E - blue/bold blue
#	f/F - magenta/ bold magenta
#	g/G - cyan/bold cyan
#	h/H - light grey/bold light grey
#	x - default foreground or background
#
#	Usage - zz -> The initial z is the foreground color and the second is the background color
#
# 1. 	Directory - Cyan (gx)
# 2. 	Sym. Link - Bold Red (Bx)
# 3. 	Socket - Green, black background (ca)
# 4. 	Pipe - Red, black background (ba)
# 5. 	Executable - Bold Magenta Fx
# 6. 	Block Special - Yellow (brown) (dx)
# 7. 	Character Special - Yellow (brown) (dx)
# 8. 	Executable with setuid bit - White, red background (hb)
# 9. 	Executable with setgid bit - White, red background (hb)
# 10. 	Directory writable to others, sticky bit - Bold white, cyan background (Hg)
# 11. 	Directory writable to tohers, wihout sticly bit - Bold white, cyan background (Hg)


## Commands
alias ls='ls -Gp'
export LSCOLORS=gxBxcabaFxdxdxhbhbHgHg


##################
# Prompt Styling #
##################
# \d - Current date
# \t - Current time
# \h - Hostname
# \# - Command number
# \u - Username
# \W - Current working directory
# \w - Absolute path of working directory

export PS1="\h( \W ) -> "
