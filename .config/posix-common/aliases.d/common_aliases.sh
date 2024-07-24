#!/usr/bin/env sh
_location=".config/posix-common/aliases.d/common-aliases.sh"

# Generally speaking, put items that are intended for INTERACTIVE
# shells in here.  If it is a setting that might be needed by an piece
# of software that might get ran during non-interactive shells - put
# that in common-envs.sh instead.

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

# {{{ === Aliases: 'cd' Related ===
# Change Directory shortcuts, commonly needed on BSD's.
_mordu "Setting cd related aliases."
alias ..='cd ..'		# Traverse 1 dir down.
alias ...='cd ../..'	# Traverse 2 dirs down.
alias ....='cd ../../..'	# Traverse 3 dirs down.
# }}} === Aliases: 'cd' Related ===

# {{{ === Aliases: Sorting Related ===
_mordu "Setting sorting related aliases."
# Make sort easier to |s to.
alias s='sort'

# 'esl': "env | sort | less" quickly.
alias esl="env|sort|less"
# }}} === Aliasess: Sorting Related ===

# {{{ === Aliases: Emacs Related ===
# If Emacs is in in the path, create an alias 'cmacs' for 'console emacs'.
if command -v emacs > /dev/null ; then
	_mordu "Setting emacs related aliases."
	alias e='emacs' # Because I'm lazy.
	alias cmacs='emacs -nw'	# Start emacs with no window system.
fi
# }}} === Aliases: Emacs Related ===

# {{{ === Aliases: 'getdate' - Used for Dating Files ===
# getdate - Used to create a date string in my preferred format. I
# use it when creating files and such.
alias getdate='date +%Y-%m-%d'
# }}} === Aliases: 'getdate' - Used for Dating Files ===

# {{{ === Aliases: 'purgebaks' - Used for Purging Vim and Emacs Backups ===
# purgebaks - An incredibly destructive recursive vim/emacs backup
# file deleter.  Use with caution.  I would prefer enhancing this
# to move the files into a backup folder inside of
# ~/.cache/something with (getdate) applied to the filenames.  But
# for now, this will simply search a subdirectory for anything
# like ~foobar.txt or #foobar.txt# and deletes them
alias purgebaks='find -name "\#*" -print -delete;find -name "*~" -print -delete'
# }}} === Aliases: 'purgebaks' - Used for Purging Vim and Emacs Backups ===

# {{{ === Aliases: 'grep' Related. ===
# Grep, handy to do things like 'cat foobar.txt|g secretcode'
alias g='grep -i'
# }}} === Aliases: 'grep' Related. ===

# {{{ === Misc Leftover Aliases. ===
alias reload-fonts="sudo fc-cache -v"

pghq() {
	GHQ_ROOT="$HOME/proj/git" ghq $*
}
# }}} === Misc Leftover Aliases. ===

_mordu "Finished script."
