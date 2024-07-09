# ~/.config/zsh/env.zsh
LOCATION="zsh/env.zsh"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to enable DEBUGing.
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

# {{{ === Source Posix Common env.sh ===
_mordu "Sourcing Env Vars from ~/.config/posix-common/env.sh."
source "$HOME"/.config/posix-common/env.sh
LOCATION="zsh/env.zsh"
_mordu "Completed sourcing environment variables from ~/.config/posix-common/env.sh."
# }}} === Source Posix Common env.sh ===

# {{{ === Configure initial ZSH specific settings. ===
_mordu "Configuring initial ZSH specific settings needed for the rest of the shell setup."
# Set ZDOTDIR to allow us to move zsh init files into XDG config.
ZDOTDIR="$HOME/.config/zsh"
export ZDOTDIR

# Create a functions directory in ~/.config/zsh/functions.
#typeset -U FPATH fpath
#if [ -d "$HOME/.config/zsh/functions" ] ; then
#	_mordu "Could not find ~/.config/zsh/functions.  Creating."
#	mkdir -p ~/.config/zsh/functions
#fi
#_mordu "Setting fpath."
#fpath=("$HOME/.config/zsh/functions" "$fpath")
#export FPATH
# }}} === Configure initial ZSH specific settings. ===

# {{{ === ZSH History settings. ===
_mordu "Configuring ZSH command history settings."
if [ ! -d "$HOME/.local/share/zsh/" ] ; then
	_mordu "Could not find ~/.local/share/zsh. Creating it Master."
	mkdir -p "$HOME"/.local/share/zsh
fi

# Set location with hostname prepended.
export HISTFILE="$HOME/.local/share/zsh/${HOST//\./_}_zsh_history"

# Without SAVEHIST zsh won't work.
export SAVEHIST=10000
export HISTSIZE=10000

setopt hist_ignore_all_dups  # Don't add duplicate commands to histfile.
setopt hist_find_no_dups     # Don't recall dupes either.
                             # (Shouldn't be needed but set anyway.)
setopt append_history        # Append to the history as we go. Not just on logout. 
setopt share_history         # Share appended history with other terminals.
# }}} === ZSH History settings. ===

_mordu "Finished processing $LOCATION"
