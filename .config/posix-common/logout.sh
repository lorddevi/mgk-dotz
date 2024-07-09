# ~/.config/posix-common/logout.sh
LOCATION="posix-common/logout.sh"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Clear Screen on Logout ===
# When leaving the console, clear the screen to increase privacy
clear
# }}} === Clear Screen on Logout ===

_mordu "Finished processing $LOCATION."
