# ~/.config/posix-common/aliases.d/less-and-bat.sh
LOCATION="posix-common/aliases.d/less-and-bat.sh"

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

# {{{ === Environment Setup: Less & Bat Related ===
# Themes that work: ansi, gruvbox-dark
# Note: 'bat' is also configured as our default pager, but is
# referenced from ~/.config/posix-common/env.d/common-envs.sh.
_mordu "Setting up 'less', and 'bat' related environment."

# First clean up after less, and make sure a cache dir exists for it.
if [ ! -d "$HOME"/.cache/less ]; then
	_mordu "$HOME/.cache/less/ not found.  Creating."
	mkdir -p "$HOME"/.cache/less  # Make the less cache dir for the history if needed.
fi

# We will set up less's preferred env even if we end up using
# 'bat'.  Just to keep things clean for those edge cases.
_mordu "Setting LESSKEY and LESSHISTFILE."
LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
LESSHISTFILE="$XDG_CACHE_HOME"/less/$(echo "$HOST"|sed 's/\./_/g')_less_history
export LESSKEY LESSHISTFILE

# Check if there is a '.lesshst' making a mess in our homedir or
# not and get rid of it if there is.
if [ -f "$HOME/.lesshst" ]; then
	_mordu "Found a stale ~/.lesshst file.  Deleting."
	rm "$HOME"/.lesshst  # Just get rid of it. I don't need it.
fi
# }}} === Environment Setup: Less & Bat Related ===

# {{{ === Aliases: Less and Bat Related ===
# Now the important part - Try to use 'bat' as our default pager
# if it is possible.  Sometimes bat doesn't always play nice, but
# let's assume it will 99% of the time.
if command -v bat > /dev/null ; then
	#alias bat='bat --style=changes,header,grid,numbers,snip --color=always'
	#alias batnl='bat --style=header,grid,snip'
	alias l='less'
	alias c='cat'
	#alias b='bat'
	alias man='batman'
	alias diff='batdiff'
fi
PAGER=less
export PAGER
# }}} === Aliases: Less and Bat Related ===

_mordu "Finished processing $LOCATION."
