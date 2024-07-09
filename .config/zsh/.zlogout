#!/usr/bin/env zsh
_location=".config/zsh/logout.zsh"

# {{{ <mordu debug system>
_debug=y # Comment this out to disable debugging.
_blue="\033[34m"
_magenta="\033[35m"
_green="\033[92m"
_cyan="\033[36m"
_white="\033[97m"
_end_color="\033[0m"

# Mordu with location.
_mordu() {
    [[ -n "$_debug" ]] && echo -e "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Mordu with location and no new line.
_mordu_n() {
    [[ -n "$_debug" ]] && echo -en "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Echo with new line to add completion messages to _mordu_n
_mordu_nl() {
    [[ -n "$_debug" ]] && echo -e "${_white}$*${_end_color}"
}

_mordu "Starting script."
# }}} </mordu debug system>

# {{{ === Source Posix Common logout.sh ===
_mordu "Sourcing logout actions from ~/.config/posix-common/logout.sh."
source "$HOME"/.config/posix-common/logout.sh
_location=".config/zsh/logout.zsh"
_mordu "Completed sourcing ~/.config/posix-common/logout.sh."
}
# }}} === Source Posix Common logout.sh ===

_mordu "Finished script."
