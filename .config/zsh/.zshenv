#!/usr/bin/env zsh
_location=".config/zsh/env.zsh"

# {{{ <mordu debug system>
_debug=y # Comment this out to disable debugging.
_blue="\033[34m"
_magenta="\033[35m"
_green="\033[92m"
_cyan="\033[36m"
_white="\033[97m"
_end_color="\033[0m"

# Mordu with location.
_mordu() {
    [[ -n "$_debug" ]] && echo -e "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Mordu with location and no new line.
_mordu_n() {
    [[ -n "$_debug" ]] && echo -en "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Echo with new line to add completion messages to _mordu_n
_mordu_nl() {
    [[ -n "$_debug" ]] && echo -e "${_white}$*${_end_color}"
}

_mordu "Starting script."
# }}} </mordu debug system>

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
#setopt share_history         # Share appended history with other terminals.
setopt no_share_history      # Disable sharing of appended history.
setopt no_inc_append_history # Append history lines as they occur.
unsetopt extended_history
# }}} === ZSH History settings. ===

_mordu "Finished script."
