#!/usr/bin/env bash
_location=".config/yadm/shell-extras.d/04-install-python-stuff.sh"

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

# {{{ <install python>
_install_python() {
	_mordu "Installing python."
	sudo dnf install -y python3 python3-pip
}
# }}} </install python>

# {{{ <broken pyenv install FIX>
## Make sure pyenv is installed.
#if [ -e "$PYENV_ROOT"/bin/pyenv ]; then
#	echo "Pyenv already installed."
#else
#	echo "Pyenv not installed.  Installing."
#	echo "Cloning pyenv."
#	ghq get git.mgk.one/utils-code/pyenv.pyenv
#	echo "Cloning pyenv-virtualenv."
#	ghq get git.mgk.one/utils-code/pyenv.pyenv-virtualenv
#	echo "Linking pyenv."
#	ln -sr "$GHQ_ROOT"/git.mgk.one/utils-code/pyenv.pyenv "$PYENV_ROOT"
#	echo "Linking pyenv-virtual-env."
#	ln -sr "$GHQ_ROOT"/git.mgk.one/utils-code/pyenv.pyenv-virtualenv "$PYENV_ROOT"/plugins/pyenv-virtualenv
#	echo "Installing latest python version."
#	pyenv install "$(pyenv latest -k 3)"
#	echo "Setting default python version to the latest version."
#	pyenv global "$(pyenv latest -k 3)"
#fi
#
#echo "Initializing the pyenv shell environment."
#eval "$(pyenv init --path)"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#echo "Running update command for pip."
#pip install --upgrade pip
# }}} </broken pyenv install FIX>

# {{{ <install python packages>
_install_python_packages() {
	## Install ckill
	if command -v ckill > /dev/null 2>&1; then
		_mordu "Ckill already installed."
	else
		_mordu "Installing ckill."
		pip install ckill
	fi
}
# }}} </install python packages>

# {{{ <main loop>
_main() {
	_install_python
	_install_python_packages
}
_main
# }}} </main loop>

_mordu "Completed script."
