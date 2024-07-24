#!/usr/bin/env sh
_location=".config/posix-common/aliases.d/xdg-related.sh"

# Generally speaking, put items that are intended for INTERACTIVE
# shells in here.  If it is a setting that might be needed by an piece
# of software that might get ran during non-interactive shells - put
# that in common-envs.sh instead.

# {{{ <mordu debug system>
# _debug=y # Comment this out to disable debuging.

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

# {{{ === Aliases: XDG Related ===
# XDG wget
WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget_hsts"'
export WGETRC

# XDG Weechat
WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat
alias weechat='weechat -d "$XDG_CONFIG_HOME"/weechat'
export WEECHAT_HOME
# }}} === Aliases: XDG Related ===

_mordu "Finished script."
