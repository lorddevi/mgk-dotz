# ~/.config/posix-common/functions.d/common_functions.sh
LOCATION="posix-common/functions.d/common_functions.sh"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Func: 'fixperms' ===
# Recursively set DIRS to 755, and FILES to 644.
# Function to help me quickly set the perms on both files
# and directories in a home directory. Also helps sanitize shit I grab
# off of USB's or NTFS drives.
_mordu "Creating fixperms function."
fixperms() {
	find "$@" -type d -exec chmod 755 {} \;
	find "$@" -type f -exec chmod 644 {} \;
}
# }}} === Func: 'fixperms' ===

# {{{ === Func: 'rands' ===
# 'rands' stands for "Random String". It generates a
# short 12 character random string.  I use it to help name bulk-name
# files like pictures and such.
_mordu "Creating rands function."
rands() {
	LENGTH=12
	tr -dc A-Za-z0-9 </dev/urandom | head -c $LENGTH
}
# }}} === Func: 'rands' ===

# {{{ 'macgen' : Generate a random valid MAC addy.
macgen() {
	echo 00-60-2f$(od -txC -An -N3 /dev/random|tr \  -)
}
# }}} 'macgen' : Generate a random valid MAC addy.

# {{{ === Func: 'ansp' Ansible Playbook ===
_mordu "Creating 'ansp' function."
ansp () {
	ansible-playbook $1 --extra-vars "targets=$2"
}
# }}}=== Func: 'ansp' Ansible Playbook ===

# {{{ SSH Tunnel Manager
sshtm() { 
	ssh-tunnel-manager.sh --config ~/.config/ssh-tunnel-manager/ssh-tunnel-manager.conf $*
}
# }}} SSH Tunnel Manager
_mordu "Finished processing $LOCATION."
