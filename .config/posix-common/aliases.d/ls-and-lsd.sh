# ~/.config/posix-common/aliases.d/ls-and-lsd.sh
LOCATION="posix-common/aliases.d/ls-and-lsd.sh"

# Generally speaking, put items that are intended for INTERACTIVE
# shells in here.  If it is a setting that might be needed by an piece
# of software that might get ran during non-interactive shells - put
# that in common-envs.sh instead.

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Aliases: 'ls' Related ===
# 'ls' - Colorize if possible, and create shortcuts
if command -v lsd > /dev/null 2>&1; then # Typically I have this on Linux.
	_mordu "Found 'lsd', configuring aliases for it."
	alias ls='lsd -F --color=auto --icon=auto --date relative --size short'
	elif command -v colorls > /dev/null ; then # This is OpenBSD usually.
		alias ls='colorls -FGh'
	elif [ "$(uname)" = 'Linux' ]; then # If it is Linux we can assume gnu ls.
		alias ls='ls -Fh --color=auto --time-style=long-iso' # Set color to auto and enable classify.
	else
    alias ls='ls -Fh' # At least ensure --classify is on.
fi

_mordu "Creating 'ls' related aliases."
alias ll="exa -l"
alias la="exa -A"
alias lla="exa -lA"

# 'lt' Tree basically, but for all files minus '.' and '..'.
# Also with preference for 'lsd --tree' over 'tree -a'
if command -v lsd > /dev/null ; then # Typically I have this on Linux.
	_mordu "Creating tree related aliases using lsd'."
	alias lt='lsd --tree'
	alias lta='lt -A'
elif command -v tree > /dev/null ; then
	alias lt='tree'
	alias lta='lt -a'
fi
# }}} === Aliases: 'ls' Related ===

_mordu "Finished processing $LOCATION."
