# ~/.config/posix-common/login.sh
LOCATION="posix-common/login.sh"

# Environment variables that don't need to be set for every terminal you open,
# put here. These envrionment variables get set once upon login and that's it.

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Personal Information ===
_mordu "Setting PIM data." 
NAME='Lord_Devi'
EMAIL='lord@mgk.one'
export NAME EMAIL
# }}} === Personal Information ===

# {{{ === Localizations ===
_mordu "Setting localization environment variables."
LANG='en_US.UTF-8'
LC_ALL=$LANG
LC_COLLATE=$LANG
LC_CTYPE=$LANG
LC_MESSAGES=$LANG
LC_MONETARY=$LANG
LC_NUMERIC=$LANG
LC_TIME=$LANG
export LANG LC_ALL LC_COLLATE LC_CTYPE LC_MESSAGES LC_MONETARY LC_NUMERIC \
	LC_TIME
# }}} === Localizations ===

_mordu "Finished processing $LOCATION."
