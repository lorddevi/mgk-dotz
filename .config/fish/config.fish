#!/usr/bin/env fish
set _location ".config/fish/config.fish"

# Fish specific configuration file.  Generally speaking, try to
# prioritize POSIX compatability for any added functionality.  If
# possible, try to add any desired function, alias, or the like to
# ~/.config/posix-common/[..] where possible.

# {{{ <mordu debug system>
# set _debug y # Comment this out to disable DEBUGing.
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

# {{{ === Primary Fish Configuration Section ===
set fish_greeting   # Disable fish greeting.

# Prepend hostname tocommand history file if possible

set -x fish_history (echo "$HOST"|sed 's/\./_/g')_fish
# }}} === Primary Fish Configuration Section ===

_mordu "Finished script."
