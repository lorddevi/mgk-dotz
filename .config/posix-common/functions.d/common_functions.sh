#!/usr/bin/env sh
_location=".config/posix-common/functions.d/common_functions.sh"

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

# {{{ === Func: 'fixperms' ===
# Recursively set DIRS to 755, and FILES to 644.
# Function to help me quickly set the perms on both files
# and directories in a home directory. Also helps sanitize shit I grab
# off of USB's or NTFS drives.
_mordu "Creating fixperms function."
fixperms() {
	find "$@" -type d -exec chmod 755 {} \;
	find "$@" -type f -exec chmod 644 {} \;
}
# }}} === Func: 'fixperms' ===

# {{{ === Func: 'rands' ===
# 'rands' stands for "Random String". It generates a
# short 12 character random string.  I use it to help name bulk-name
# files like pictures and such.
_mordu "Creating rands function."
rands() {
	LENGTH=12
	tr -dc A-Za-z0-9 </dev/urandom | head -c $LENGTH
}
# }}} === Func: 'rands' ===

# {{{ 'macgen' : Generate a random valid MAC addy.
macgen() {
	echo 00-60-2f$(od -txC -An -N3 /dev/random|tr \  -)
}
# }}} 'macgen' : Generate a random valid MAC addy.

# {{{ === Func: 'ansp' Ansible Playbook ===
_mordu "Creating 'ansp' function."
ansp () {
	ansible-playbook $1 --extra-vars "targets=$2"
}
# }}}=== Func: 'ansp' Ansible Playbook ===

# {{{ SSH Tunnel Manager
sshtm() { 
	ssh-tunnel-manager.sh --config ~/.config/ssh-tunnel-manager/ssh-tunnel-manager.conf $*
}
# }}} SSH Tunnel Manager
_mordu "Finished script."
