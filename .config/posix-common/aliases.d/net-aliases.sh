# ~/.config/posix-common/aliases.d/net-aliases.sh
LOCATION="posix-common/aliases.d/net-aliases.sh"

# These are shortcuts for comming networking things I do.

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Aliases ===

# Firewall-cmd stuff.

alias fw='firewall-cmd'
alias fwls='fw --list-all'
alias fwlsa='fw --list-all-zones'
alias fwgaz='fw --get-active-zones'
# }}} === Aliases ===

_mordu "Finished processing $LOCATION."
