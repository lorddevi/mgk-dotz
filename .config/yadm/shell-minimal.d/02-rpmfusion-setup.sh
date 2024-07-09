#!/usr/bin/env bash
_location=".config/yadm/shell-minimal.d/02-rpmfusion-setup.sh"

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

# {{{ <add rpmfusion repo>
_add_rpmfusion_repo() {
	_mordu "Adding RPM Fusion Repo."
	sudo dnf install -y \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
}
# }}} </add rpmfusion repo>

# {{{ <update package cache>
_update_package_cache() {
	_mordu "Updating the local DNF package cache."
	sudo dnf makecache --refresh
}
# }}} </update package cache>

# {{{ <update packages>
_update_packages() {
	_mordu "Updating Fedora packages."
	sudo dnf update -y
}
# }}} </update package cache>

# {{{ <main loop>
_main() {
	_add_rpmfusion_repo
	_update_package_cache
	_update_packages
}
_main
# }}} </main loop>

_mordu "Completed script."
