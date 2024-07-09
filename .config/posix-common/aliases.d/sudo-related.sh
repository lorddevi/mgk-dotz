# ~/.config/posix-common/aliases.d/sudo-related.sh
LOCATION="posix-common/aliases.d/sudo-related.sh"

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

# {{{ === Aliases: Sudo Related ===
alias firewall-cmd='sudo firewall-cmd'
alias dnf='sudo dnf'
alias lsof='sudo lsof'
alias service='sudo service'
alias nmcli='sudo nmcli'
#alias systemctl='sudo systemctl'
#alias journalctl='sudo journalctl'

# }}} === Aliases: Sudo Related ===

_mordu "Finished processing $LOCATION."
