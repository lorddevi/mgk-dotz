# ~/.config/fish/conf.d/load-posix-profiles.fish
set LOCATION "fish/conf.d/load-posix-profiles.fish"

# This file will help ensure our shell environment is in compliance with the
# distribution / operating systems standards by sourcing /etc/profile.  Which
# will hopefully pull in /etc/profile.d/*.sh settings as well.
#
# Also, we will pull in the environment variables, aliases, and functions from
# our posix configuration.  This lets us to avoid having to repeat ourselves
# with some basic things like setting environment variables.  (Would not be a
# problem if I did not insist on wanting to run so many different shells.)

# {{{ === Script Debug Settings ===
#set -l DEBUG y # Comment this out to disable DEBUGing.
function _mordu
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $argv"
end

function _mordu_n
	[ "$DEBUG" ] && echo -n ">>> Mordu@$LOCATION: $argv"
end

function _mordu_nl
	[ "$DEBUG" ] && echo "$argv"
end
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Source login.fish (If interactive.) ===
# If this instance is found to be a Login Shell, ensure all environment
# variables and other OS-specific gets loaded.
if status --is-login
  _mordu "This appears to be a Login Shell.  Sourcing ~/.config/fish/login.fish."
  source "$HOME"/.config/fish/login.fish
  set -l LOCATION "fish/conf.d/load-posix-profiles.fish"
  _mordu "Finished sourcing ~/.config/fish/login.fish."
end
# }}} === Source login.fish (If interactive.) ===

# {{{ === Source interactive.fish (If interactive.) ===
# For Interactive Shell instances, be sure that the user has access to all the
# expected functions, aliases, etc.  I try to centralize the really simple
# stuff under ~/.config/posix-common so I have access to those resources from
# both Bash, Fish, or other.
if status --is-interactive
	_mordu "This appears to be an Interactive Shell.  Sourcing ~/.config/fish/interactive.fish."
	source "$HOME"/.config/fish/interactive.fish
    set -l LOCATION "fish/conf.d/load-posix-profiles.fish"
	_mordu "Finished sourcing ~/.config/fish/interactive.fish."
end
# }}} === Source interactive.fish (If interactive.) ===

# {{{ === Source logout.fish (If logging out.) ===
# Fish doesn't have a '.logout' file, but does have support for the
# functionality through the use of a shell hook.  Another opportunity to
# centralize settings under ~/.config/posix-common.
_mordu "Coupling Fish logout function with ~/.config/posix-common/logout.sh through ~/.config/fish/logout.fish."
function on_exit --on-event fish_exit
  source "$HOME"/.config/fish/logout.fish
  set -l LOCATION "fish/conf.d/load-posix-profiles.fish"
end
# }}} === Source logout.fish (If logging out.) ===

_mordu "Finished processing $LOCATION."
