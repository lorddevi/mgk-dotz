# ~/.config/posix-common/interactive.sh
LOCATION="posix-common/interactive.sh"

# Anything we might expect to want or need in an interactive shell should be added from here somehow.

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Source all Functions ===
_mordu "Sourcing Functions from ~/.config/posix-common/functions.d/*."
for functions_file in "$HOME"/.config/posix-common/functions.d/*.sh; do
	# shellcheck source=/dev/null
	LOCATION="posix-common/functions.d/$functions_file"
	. "$functions_file"
done
unset -v functions_file 
LOCATION="posix-common/interactive.sh"
_mordu "Finished sourcing Functions from ~/.config/posix-common/functions.d/*."
# }}} === Source all Functions ===

# {{{ === Source all Aliases ===
_mordu "Sourcing Aliases from ~/.config/posix-common/aliases.d/*."
for alias_file in "$HOME"/.config/posix-common/aliases.d/*.sh; do
	# shellcheck source=/dev/null
	_mordu "Sourcing $alias_file."
	LOCATION="posix-common/aliases.d/$alias_file"
	. "$alias_file"
done
unset -v alias_file 
LOCATION="posix-common/interactive.sh"
_mordu "Finished sourcing Aliases from ~/.config/posix-common/aliases.d/*."
# }}} === Source all Aliases ===

# {{{ === LS_COLORS === 
# Sauce: https://github.com/trapd00r/LS_COLORS
_mordu "Sourcing LS_COLORS from ~/.config/posix-common/lscolors.sh"
. "$HOME"/.config/posix-common/lscolors.sh
_mordu "Finished sourcing LS_COLORS from ~/.config/posix-common/lscolors.sh"
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
#if command -v fortune > /dev/null ; then
#  fortune ~/.local/share/fortunes/lotr
#fi
#fastfetch --logo-type kitty --kitty ~/.config/posix-common/fastfetch-logo.jpg --logo-height 17 --logo-padding-left 3 --logo-padding-right 1 -s Title:Separator:OS:Kernel:Packages:Processes:CPU:GPU:Memory:LocalIP:Shell:Uptime:Player:Media:Theme:Font

fortune ~/.local/share/fortunes/lotr | lolcat
# }}} === Post Login Fun i.e. Fortune ===

_mordu "Finished processing $LOCATION."
