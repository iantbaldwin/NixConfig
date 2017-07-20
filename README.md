# *Nix Configuration #
![ian baldwin terminal][term-sc]
This is my configuration for the terminals and software tools that I use most frequently.

## Fonts ##
 This contains FiraCode, my preferred font for use in terminals. At the moment, this only works in the macOS terminal.
 You can download the font [here] [fira-code].

## Terminal Theme ##
 Once again, this if for the macOS Terminal. 
 You can find it's source [here] [solarized-theme].

## TMUX Listeners ##
In order to provide myself with information about the status of my computer(s), I wrote several 'listeners' that run in an infinite loops, looking for changes to the system. If such a change is generally found, the TMUX status bar is forcefully updated. Below is a table that shows what each 'listener' does:

| Name                  | Function                        |       Active?      |
|-----------------------|---------------------------------|:------------------:|
| battery_listener.sh   | Battery if applicable           | :white_check_mark: |
| cpu_listener.sh       | CPU Load                        | :white_check_mark: |
| itunes_listener.sh    | iTunes artist and album         | :white_check_mark: |
| mem_listener.sh       | System memory                   | :white_check_mark: |
| priv_ip_listener.sh   | LAN IP Address                  | :white_check_mark: |
| pub_ip_listener.sh    | WAN IP Address                  | :x:                |
| weather_listener.sh   | Current weather based on WAN IP | :x:                |

Each of these listeners write to an individual file in `~/.cache/` and TMUX reads these 'cache' files using `cat`. As stated before, each listener will tell TMUX to reread the cache files if there is a change in their contents. 

### Listener Control ###
There are two utilities that control the state of all listeners:
* `run_listeners`: Run all listeners in `NixConfig/Utils/` that follow the naming scheme `*_listener.sh`
* `kill_listeners`: KIll all listeners in `NixConfig/Utils/` that follow the naming scheme `*_listener/sh`

### Further Development ###
Additional listeners can be added to `NixConfig/Utils/' using the supplied naming scheme. Integration into the TMUX statusbar requires changes made to `NixConfig/tmuxline_solarized`.

[fira-code]: https://github.com/tonsky/FiraCode (FiraCode on GitHub)
[solarized-theme]: https://github.com/altercation/solarized (Solarized on GitHub)
[term-sc]: https://cdn.iantbaldw.in/NixConfig/term.png
