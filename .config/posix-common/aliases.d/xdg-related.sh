# ~/.config/posix-common/aliases.d/xdg-related.sh
LOCATION="posix-common/aliases.d/xdg-related.sh"

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

# {{{ === Aliases: XDG Related ===
# XDG wget
WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget_hsts"'
export WGETRC

# XDG Weechat
WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat
alias weechat='weechat -d "$XDG_CONFIG_HOME"/weechat'
export WEECHAT_HOME
# }}} === Aliases: XDG Related ===

_mordu "Finished processing $LOCATION."
