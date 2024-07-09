# ~/.config/fish/login.fish
set _location ".config/fish/login.fish"

# Intended to be used to run items we want to load only on login shells.
# Env vars that affect non-interactive shells or interactive shells alike.
# But perhaps not things like aliases for 'ls' quite yet.

# {{{ <mordu debug system>
set _debug y # Comment this out to disable DEBUGing.
set _blue "\033[34m"
set _magenta "\033[35m"
set _green "\033[92m"
set _cyan "\033[36m"
set _white "\033[97m"
set _end_color "\033[0m"

# Mordu with location.
function _mordu
    set -q _debug; and echo -e "$_blue>>> $_magenta""Mordu""$_cyan@$_green$_location$_cyan:$_white $argv$_end_color"
end

# Mordu with location and no new line.
function _mordu_n
    set -q _debug; and echo -en "$_blue>>> $_magenta""Mordu""$_cyan@$_green$_location$_cyan:$_white $argv$_end_color"
end

# Echo with new line to add completion messages to _mordu_n
function _mordu_nl
    set -q _debug; and echo -e "$_white$argv$_end_color"
end

_mordu "Starting script."
# }}} </mordu debug system>

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

_mordu "Finished script."
