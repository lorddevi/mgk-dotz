# ~/.config/fish/login.fish
set LOCATION "fish/login.fish"

# Intended to be used to run items we want to load only on login shells.
# Env vars that affect non-interactive shells or interactive shells alike.
# But perhaps not things like aliases for 'ls' quite yet.

# {{{ === Script Debug Settings ===
#set -l DEBUG y # Comment this out to disable DEBUGing.
function _mordu
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $argv"
end

function _mordu_n
	[ "$DEBUG" ] && echo -n ">>> Mordu@$LOCATION: $argv"
end

function _mordu_nlk
	[ "$DEBUG" ] && echo "$argv"
end
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Souce System Posix Profile TODO: FIX ===
# Load Operating System POSIX environment. Important on Arch, Gentoo
# and likely others.
#_mordu "Sourcing OS-Specific /etc/profile."
#replay "source /etc/profile"
#_mordu "Finished sourcing OS-Specific /etc/profile."
# }}} === Souce System Posix Profile ===

# {{{ === Souce User Common Posix Profile TODO: FIX===
# Load the posix-common Login Shell settings we have setup too.
#_mordu "Sourcing Login Shell settings from ~/.config/posix-common/login.sh"
#replay "source ~/.config/posix-common/login.sh"
#set -l LOCATIONl "fish/login.fish"
#_mordu "Finished sourcing Login Shell settings from ~/.config/posix-common/login.sh"
# }}} === Souce User Common Posix Profile ===

_mordu "Finished processing $LOCATION."
