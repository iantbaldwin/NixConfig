# *Nix Configuration #
## About ##
This is my configuration for the terminals and software tools that I use most frequently.

## Fonts ##
 This contains FiraCode, my preferred font for use in terminals. At the moment, this only works in the macOS terminal.
 You can download the font [here] [fira-code].

## Terminal Theme ##
 Once again, this if for the macOS Terminal. 
 You can find it's source [here] [solarized-theme].

## TMUX Listeners ##
In order to provide myself with information about the status of my computer(s), I wrote several 'listeners' that run in an infinite loops, looking for changes to the system. If such a change is generally found, the TMUX status bar is forcefully updated. Below is a table that shows what each 'listener' does:

| Name                  | Function                        | Active? |
|-----------------------|---------------------------------|:-------:|
| battery_listener.sh   | Monitor battery                 | :white_check_mark:  |
| cpu_listener.sh       | Monitor CPU Load                | \u2705  |
| itunes_listener.sh    | Monitor iTunes artist and album | \u2705  |

[fira-code]: https://github.com/tonsky/FiraCode (FiraCode on GitHub)
[solarized-theme]: https://github.com/altercation/solarized (Solarized on GitHub)

