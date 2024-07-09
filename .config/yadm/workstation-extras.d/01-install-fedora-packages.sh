#!/usr/bin/env bash
_location=".config/yadm/workstation-extras.d/01-install-fedora-packages.sh"

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

# {{{ <define packages>
_define_packages() {
	_packages=(\
		wireshark)
}
# }}} </define packages>

# {{{ <install pkgs>
_install_pkgs() {
	local __required_packages=("$@")

	for __package in "${__required_packages[@]}" ; do
		if [[ $(rpm -qi "${__package//\"/}") == "package ${__package//\"/} is not installed"  ]] ; then
			_mordu "Not installed yet: ${__package}."
			__not_installed_yet+=( "$__package" )
		else
			_mordu "Already installed: ${__package}."
		fi
	done
	_mordu "Total not installed yet: ${__not_installed_yet[*]}"

	if (( ${#__not_installed_yet[@]} )); then
		sudo dnf -y install "${__not_installed_yet[@]}"
	fi
}
# }}} </install pkgs>

# {{{ <define pkg groups>
# Define the package groups you want to install
_define_pkg_groups() {
    _pkg_groups=(\
			"Sound and Video" \
			"LibreOffice" \
			"Security Lab" \
			"Fonts" \
			"Multimedia")
}
# }}} </define pkg groups>

# {{{ <install pkg groups>
# Function to install package groups if not already installed
_install_pkg_groups() {
    local __required_pkg_groups=("$@")
    local __not_installed_yet=()

    # Get the list of installed package groups
    local __installed_groups
    __installed_groups=$(dnf group list --hidden installed | awk '/Installed Groups:/,/^$/' | sed '1d' | sed 's/^[ \t]*//')

    for __group in "${__required_pkg_groups[@]}"; do
        if echo "$__installed_groups" | grep -q "^${__group}$"; then
            _mordu "Already installed: ${__group}."
        else
            _mordu "Not installed yet: ${__group}."
            __not_installed_yet+=( "$__group" )
        fi
    done

    _mordu "Total not installed yet: ${__not_installed_yet[*]}"

    if (( ${#__not_installed_yet[@]} )); then
        sudo dnf -y group install "${__not_installed_yet[@]}"
    fi
}
# }}} </install pkg groups>

# {{{ <main loop>
_main() {
	# Install Fedora packages
	_define_packages
	_install_pkgs "${_packages[@]}"

	# Install Fedora package groups
	_define_pkg_groups
	_install_pkg_groups "${_pkg_groups[@]}"
}
_main
# }}} </main loop>

_mordu "Completed script."
