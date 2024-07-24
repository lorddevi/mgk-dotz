#!/usr/bin/env sh
_location=".config/posix-common/interactive.sh"

# Anything we might expect to want or need in an interactive shell should be added from here somehow.

# {{{ <mordu debug system>
_debug=y # Comment this out to disable debuging.

_blue="\e[34m"
_magenta="\e[35m"
_green="\e[92m"
_cyan="\e[36m"
_white="\e[97m"
_end_color="\e[0m"

# Mordu with location.
_mordu() {
	[ "$_debug" ] && echo -e "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Mordu with location and no new line.
_mordu_n() {
	[ "$_debug" ] && echo -en "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Echo with new line to add completion messages to _mordu_n
_mordu_nl() {
	[ "$_debug" ] && echo -e "${_white}$*${_end_color}"
}

_mordu "Starting script."
# }}} </mordu debug system>

# {{{ === Source all Functions ===
_mordu "Sourcing Functions from ~/.config/posix-common/functions.d/*."
for functions_file in "$HOME"/.config/posix-common/functions.d/*.sh; do
	# shellcheck source=/dev/null
	_location=".config/posix-common/functions.d/$functions_file"
	. "$functions_file"
done
unset -v functions_file 
_location=".config/posix-common/interactive.sh"
_mordu "Finished sourcing Functions from ~/.config/posix-common/functions.d/*."
# }}} === Source all Functions ===

# {{{ === Source all Aliases ===
_mordu "Sourcing Aliases from ~/.config/posix-common/aliases.d/*."
for alias_file in "$HOME"/.config/posix-common/aliases.d/*.sh; do
	# shellcheck source=/dev/null
	_mordu "Sourcing $alias_file."
	_location=".config/posix-common/aliases.d/$alias_file"
	. "$alias_file"
done
unset -v alias_file 
_location=".config/posix-common/interactive.sh"
_mordu "Finished sourcing Aliases from ~/.config/posix-common/aliases.d/*."
# }}} === Source all Aliases ===

# {{{ === LS_COLORS === 
# Sauce: https://github.com/trapd00r/LS_COLORS
#_mordu "Sourcing LS_COLORS from ~/.config/posix-common/lscolors.sh"
#. "$HOME"/.config/posix-common/lscolors.sh
#_mordu "Finished sourcing LS_COLORS from ~/.config/posix-common/lscolors.sh"

# Trying nord dir colors instead:
test -r ~/.config/posix-common/nord-dir-colors && eval $(dircolors ~/.config/posix-common/nord-dir-colors)
# }}} === LS_COLORS === 

# {{{ === Configure 'thefuck' as 'uwu'. ===
# Pretty awesome little tool.
if [ ! "$0" = "sh" ] ; then
	if command -v thefuck >/dev/null ; then
    eval "$(thefuck --alias uwu)"
	fi
fi
# }}} === Configure 'thefuck' as 'uwu'. ===

# {{{ === Garbage Collection ===
# Last minute homedir cleanup.  Just to present the user (me) with
# as 'clean' a working environment, let's check for some commonly
# left over files in HOME that shouldn't be there, and delete
# them.  Files like shell_history files that were not removed yet.

# Remove any stale .bash_history files still sitting around the homedir.
if [ -f "$HOME"/.bash_history ] ; then
	_mordu "Deleting stale ~/.bash_history."
	rm "$HOME"/.bash_history
fi
# }}} === Garbage Collection ===

# {{{ === Post Login Fun i.e. Fortune ===
# Post-login fun.  Right now just fortune, but would like other.  Disabled temporarily.
#if command -v fortune >/dev/null 2>&1 && command -v lolcat >/dev/null 2>&1; then
#    fortune "${HOME}/.local/share/fortunes/lotr" | lolcat
#elif command -v fortune >/dev/null 2>&1; then
#    fortune "${HOME}/.local/share/fortunes/lotr"
#fi

#fastfetch --logo-type kitty --kitty ~/.config/posix-common/fastfetch-logo.jpg --logo-height 17 --logo-padding-left 3 --logo-padding-right 1 -s Title:Separator:OS:Kernel:Packages:Processes:CPU:GPU:Memory:LocalIP:Shell:Uptime:Player:Media:Theme:Font

# }}} === Post Login Fun i.e. Fortune ===

_mordu "Finished script."
