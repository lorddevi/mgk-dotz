# ~/.config/bash/interactive.bash
LOCATION="bash/interactive.bash"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
function _mordu {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}

function _mordu_n {
	[ "$DEBUG" ] && echo -n ">>> Mordu@$LOCATION: $*"
}

function _mordu_nl {
	[ "$DEBUG" ] && echo "$*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Source Posix Common Interactive Shell Settings ===
_mordu "Sourcing Interactive Shell settings from ~/.config/posix-common/interactive.sh."
source "$HOME"/.config/posix-common/interactive.sh
LOCATION="bash/interactive.bash"
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
LOCATION="bash/interactive.bash"
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
    
_mordu "Finished processing $LOCATION."
