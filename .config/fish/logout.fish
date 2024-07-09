#!/usr/bin/env fish
set _location ".config/fish/logout.fish"

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

# {{{ === Sourcing Posix Common Logout ===
#_mordu "Sourcing POSIX logout from ~/.config/posix-common/logout.sh"
#replay "source ~/.config/posix-common/logout.sh"
#set -l LOCATION "fish/logout.fish"
#_mordu "Finished sourcing POSIX logout from ~/.config/posix-common/logout.sh"
# }}} === Sourcing Posix Common Logout ===

_mordu "Finished script."
