# ~/.config/posix-common/functions.d/common_functions.sh
LOCATION="posix-common/functions.d/bookmarks.sh"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Buku Stuff ===
_mordu "Creating buku bookmark functions."


alias b='buku --suggest'

b-taglist() {
	buku --np -t | awk 'gsub( /\(|\)$/, "" ) { $1 = $NF; $NF = ""; print }'
}
# }}} === Buku Stuff ===

_mordu "Finished processing $LOCATION."
