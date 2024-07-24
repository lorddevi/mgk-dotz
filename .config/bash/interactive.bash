#!/usr/bin/env bash
_location=".config/bash/interactive.bash"

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

# {{{ === Source Posix Common Interactive Shell Settings ===
_mordu "Sourcing Interactive Shell settings from ~/.config/posix-common/interactive.sh."
source "$HOME"/.config/posix-common/interactive.sh
_location=".config/bash/interactive.bash"
_mordu "Finished sourcing Interactive Shell settings from ~/.config/posix-common/interactive.sh."
# }}} === Source Posix Common Interactive Shell Settings ===

# {{{ === Load Bash Completion Framework ===
# Right now this is just grabbed from FreeBSD init scripts. It
# likely needs extending to work elsewhere.

if [ -f /usr/local/share/bash-completion/bash_completion.sh ] ; then
	_mordu "Bash completion found at /usr/local/share/bash-completion.sh.  Loading."
	source /usr/local/share/bash-completion/bash_completion.sh
elif [ -f /usr/share/bash-completion/bash_completion ] ; then
	_mordu "Bash completion found at /usr/share/bash-completion/bash_completion.  Loading."
	source /usr/share/bash-completion/bash_completion
fi

# }}} === Load Bash Completion Framework ===

# {{{ === Source prompt.bash ===
_mordu "Sourcing bash prompt from ~/.config/bash/prompt.bash."
source "$HOME"/.config/bash/prompt.bash
_location=".config/bash/interactive.bash"
_mordu "Finished sourcing bash prompt from ~/.config/bash/prompt.bash."
# }}} === Source prompt.bash ===

# {{{ === FZF Completions === TODO: FIX
#_mordu "Enabling FZF Completions."
#if [ -d /usr/share/fzf ] ; then
#    for fzfrc in /usr/share/fzf/*.bash ; do
#        _mordu "Sourcing $fzfrc."
#        source $fzfrc
#    done
#fi
# }}} === FZF Completions ===
    
_mordu "Finished script."
