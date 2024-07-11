#!/usr/bin/env bash
_location=".config/yadm/shell-extras.d/06-install-sbcl-and-quicklisp-stuff.sh"

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

# {{{ <prepare source directory>
_prepare_src_dir() {
	if [ ! -d "${HOME}/.local/opt/src" ]; then
		_mordu "${HOME}/.local/opt/src not created yet.  Creating."
		mkdir -p "${HOME}/.local/opt/src"
	fi
	
	if [ ! -d "${HOME}/.local/opt/src/sbcl" ]; then
		_mordu "${HOME}/.local/opt/src/sbcl not created yet.  Creating."
		mkdir -p "${HOME}/.local/opt/src/sbcl"
	fi
}
# }}} </prepare source directory>

# {{{ <fetch sbcl info>
_fetch_sbcl_info() {
	_mordu "Installing sbcl."
	# Get the latest release information
	_mordu "Fetching info on what the latest version of sbcl is."
	_api_response=$(curl -s "https://api.github.com/repos/sbcl/sbcl/releases/latest")
	
	_mordu "Assembling SBCL variables."
	# Extract the tag name from the API response
	_tag_name=$(echo "$_api_response" | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4)
	
	# Construct the download URL
	_download_url="http://prdownloads.sourceforge.net/sbcl/${_tag_name}-x86-64-linux-binary.tar.bz2"
	
	# Get the current installed version of SBCL
	if command -v sbcl > /dev/null 2>&1; then
		_current_sbcl_version=$(sbcl --version | awk '{print $2}')
		_mordu "Current SBCL Version: ${_current_sbcl_version}."
	fi
	
	# The new version to install
	_new_sbcl_version=$(echo "$_tag_name" | cut -d'-' -f2)
	_mordu "The New SBCL Version: ${_new_sbcl_version}."
}
# }}} </fetch sbcl info>

# {{{ <download latest sbcl>
_download_latest_sbcl() {
	# Download the latest release
	cd "${HOME}/.local/opt/src/sbcl" || exit
	if [ -f "${HOME}/.local/opt/src/sbcl/${_tag_name}-x86_64-linux-binary.tar.bz2" ]; then
		_mordu "Latest SBCL already downloaded."
	else
		_mordu "Downloading latest SBCL."
		curl -L -o "${_tag_name}-x86_64-linux-binary.tar.bz2" "$_download_url"
		_mordu "Downloaded latest SBCL release: ${_tag_name}"
	fi
}
# }}} </download latest sbcl>

# {{{ <extract sbcl archive>
_extract_sbcl() {
	# Extract the archive
	if [ ! -d "${HOME}/.local/opt/src/sbcl/${_tag_name}-x86-64-linux" ]; then
		_mordu "Extracting archive."
		tar -jxpvf "${_tag_name}-x86_64-linux-binary.tar.bz2"
	else
		_mordu "Archive already extracted.  Continueing."
	fi
}
# }}} </extract sbcl archive>

# {{{ <run sbcl install script>
_run_sbcl_install_script() {
	# Running SBCL install script.
	_mordu "Running SBCL install script."
	cd "${_tag_name}-x86-64-linux" || exit
	sudo ./install.sh
}
# }}} </run sbcl install script>

# {{{ <install sbcl>
# Function to compare versions
_version_gt() {
    # Return true if $1 > $2
    test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"
}

_install_sbcl() {
    # Check if the current version is unset or empty
    if [ -z "$_current_sbcl_version" ]; then
        _mordu "No current SBCL version detected. Installing version ${_new_sbcl_version}..."
        # Place your installation code here
        _run_sbcl_install_script
        return
    fi

    if [ "$_current_sbcl_version" == "$_new_sbcl_version" ]; then
        _mordu "SBCL is already up-to-date with version ${_current_sbcl_version}."
    elif _version_gt "$_new_sbcl_version" "$_current_sbcl_version"; then
        _mordu "A newer version of SBCL is available. Installing version ${_new_sbcl_version}..."
        # Place your installation code here
        _run_sbcl_install_script
    else
        _mordu "Current SBCL version ${_current_sbcl_version} is newer than the version to install ${_new_sbcl_version}."
    fi
}
# }}} </install sbcl>

# {{{ <configure /etc/sbclrc>
_configure_etc_sbclrc() {
	_sbclrc_path="/etc/sbclrc"
	
	# Check if /etc/sbclrc exists
	if [ -f "$_sbclrc_path" ]; then
		_mordu "$sbclrc_path already exists.  Not copying config."
	else
		_mordu "$sbclrc_path does not exist.  Copying over config."
		sudo cp "${HOME}"/.config/yadm/config-files/sbclrc /etc
		sudo chown root:root /etc/sbclrc
		sudo chmod go+r /etc/sbclrc
	fi
}

# }}} </configure /etc/sbclrc>

# {{{ <quicklisp install function>
_quicklisp_install_function() {
	sbcl --load ~/.local/opt/src/quicklisp.lisp \
		--eval "(quicklisp-quickstart:install :path \"${HOME}/.local/opt/quicklisp/\")" \
		--eval '(ql:quickload "clx")' \
		--eval '(ql:quickload "cl-ppcre")' \
		--eval '(ql:quickload "alexandria")' \
		--eval '(quit)'
}
# }}} </quicklisp install function>

# {{{ <download quicklisp>
_download_quicklisp() {
	_mordu "Downloading quicklisp."
	curl -o "${HOME}/.local/opt/src/quicklisp.lisp" \
		https://beta.quicklisp.org/quicklisp.lisp
}
# }}} </download quicklisp>

# {{{ <install quicklisp>
_install_quicklisp() {
	# Run SBCL to check if Quicklisp is installed and print a confirmation
	sbcl --noinform --eval '
	(handler-case
	    (progn
	        (if (find-package :ql)
	            (format t "Quicklisp is installed.~%")
	            (progn
	                (format t "Quicklisp is not installed.~%")
	                (sb-ext:exit :code 1))))
	  (error (e)
	         (format t "Quicklisp is not installed.~%")
	         (sb-ext:exit :code 1)))
	' --quit
	
	# Check the exit code of the previous command
	if [ $? -eq 1 ]; then
	    # Install Quicklisp if it is not installed
			_mordu "Quiclisp not installed yet.  Installing."
			_quicklisp_install_function
	else
	    _mordu "Quicklisp is already installed. No need to install."
	fi
}
# }}} </install quicklisp>

# {{{ <main loop>
_main() {
	# Prep install area.
	_prepare_src_dir

	# Install SBCL
	_fetch_sbcl_info
	_download_latest_sbcl
	_extract_sbcl
	_install_sbcl
	_configure_etc_sbclrc

	# Install Quicklisp
	_download_quicklisp
	_install_quicklisp
}
_main
# }}} </main loop>

_mordu "Completed script."
