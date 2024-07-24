#!/usr/bin/env sh
_location=".config/posix-common/env_local.sh"

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

# {{{ === Set HOST ===
# Set HOST as per FQDN of currently running host.
_mordu "Setting HOST."
if [ "$(uname)" = "Linux" ] ; then
	HOST="$(hostname -f)"
elif [ "$(uname)" = "OpenBSD" ] ; then
	HOST="$(hostname)"
fi
export HOST
# }}} === Set HOST ===
    
# {{{ === Load XDG Environment Variables ===
_mordu "Setting XDG Environment Variables."
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_DATA_DIRS="/usr/local/share:/usr/share"
XDG_CONFIG_DIRS="/etc/xdg"
# The xdg user-dirs below usually aren't handled as Env Vars.  I
# find it simplifies things for me right now.
XDG_DESKTOP_DIR="$HOME/.local/desktop"
XDG_DOCUMENTS_DIR="$HOME/dox"
XDG_DOWNLOAD_DIR="$HOME/dl"
XDG_MUSIC_DIR="$HOME/mzk"
XDG_PICTURES_DIR="$HOME/pix"
XDG_PROJECTS_DIR="$HOME/dox/proj"
XDG_PUBLICSHARE_DIR="$HOME/pub"
XDG_TEMPLATES_DIR="$HOME/.local/templates"
XDG_VIDEOS_DIR="$HOME/vidz"

export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_DATA_DIRS \
	XDG_CONFIG_DIRS XDG_DESKTOP_DIR XDG_DOCUMENTS_DIR XDG_DOWNLOAD_DIR \
	XDG_MUSIC_DIR XDG_PICTURES_DIR XDG_PROJECTS_DIR XDG_PUBLICSHARE_DIR \
	XDG_TEMPLATES_DIR XDG_VIDEOS_DIR
# }}} === Load XDG Environment Variables ===

# {{{ === Configure XDG-USER-DIRS with xdg-user-dirs-update ===
if command -v xdg-user-dirs-update > /dev/null ; then
  _mordu "Configuring XDG-USER-DIRS with xdg-user-dirs-update."
	xdg-user-dirs-update --set DOCUMENTS "$XDG_DOCUMENTS_DIR"
	xdg-user-dirs-update --set DESKTOP "$XDG_DESKTOP_DIR"
	xdg-user-dirs-update --set DOWNLOAD "$XDG_DOWNLOAD_DIR"
	xdg-user-dirs-update --set MUSIC "$XDG_MUSIC_DIR"
	xdg-user-dirs-update --set PICTURES "$XDG_PICTURES_DIR"
	xdg-user-dirs-update --set TEMPLATES "$XDG_TEMPLATES_DIR"
	xdg-user-dirs-update --set VIDEOS "$XDG_VIDEOS_DIR"
	xdg-user-dirs-update --set PUBLICSHARE "$XDG_PUBLICSHARE_DIR"
fi
# }}} === Configure XDG-USER-DIRS with xdg-user-dirs-update ===

# {{{ === Create XDG-USER-DIRS if Not Already Made ===
# Let's make sure the XDG dirs exist. There is a good argument to
# be made that we keep this mkdir stuff solely in a boostrap
# phase, and not in a login or interactive shell phase of things.
# I will try to see if this helps with my sanity or if it is a bad
# idea later after trying for a while.
_mordu "Creating XDD-USER-DIRS that do not already exist."
for _xdgdir in "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" \
	"$XDG_DATA_HOME" "$XDG_DESKTOP_DIR" "$XDG_DOCUMENTS_DIR" \
  "$XDG_DOCUMENTS_DIR" "$XDG_DOWNLOAD_DIR" "$XDG_MUSIC_DIR" \
	"$XDG_PICTURES_DIR" "$XDG_PUBLICSHARE_DIR" \
	"$XDG_TEMPLATES_DIR" "$XDG_VIDEOS_DIR" "$XDG_PROJECTS_DIR"
do
	[ ! -d "$_xdgdir" ] && mkdir -p "$_xdgdir"
done
# }}} === Create XDG-USER-DIRS if Not Already Made ===

# {{{ === XDG Misc Remaining ===
_mordu "XDGing readline."
INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export INPUTRC

CALCHISTFILE="$HOME/.cache/calc_history"
export CALCHISTFILE

# }}} === XDG Misc Remaining ===

_mordu "Finished script."
