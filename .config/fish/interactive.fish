#!/usr/bin/env fish
set _location ".config/fish/interactive.fish"

# {{{ <mordu debug system>
# set _debug y # Comment this out to disable DEBUGing.
set _blue "\033[34m"
set _magenta "\033[35m"
set _green "\033[92m"
set _cyan "\033[36m"
set _white "\033[97m"
set _end_color "\033[0m"

# Mordu with location.
function _mordu
    set -q _debug; and echo -e "$_blue>>> $_magenta""Mordu""$_cyan@$_green$_location$_cyan:$_white $argv$_end_color"
end

# Mordu with location and no new line.
function _mordu_n
    set -q _debug; and echo -en "$_blue>>> $_magenta""Mordu""$_cyan@$_green$_location$_cyan:$_white $argv$_end_color"
end

# Echo with new line to add completion messages to _mordu_n
function _mordu_nl
    set -q _debug; and echo -e "$_white$argv$_end_color"
end

_mordu "Starting script."
# }}} </mordu debug system>

# {{{ === Source Posix Common Aliases ===
# Load the posix-common Interactive Shell settings we have setup too.
# Initially I was just loading ~/.config/posix-common/interactive.sh like
# sh and bash were doing.  But Fish cannot actually import functions from
# posix-common/functions.d/*.  Which is more than half of what
# posix-common/interactive.sh does.  The other half is sourcing all the
# aliases from posix-common/aliases.d/*.
# So now we will skip ahead for Fish and just source that aliases directory
# directly, skipping posix-common/interactive.sh.

# >>> DON'T USE THIS BLOCK
#  _mordu "Sourcing Interactive Shell settings from ~/.config/posix-common/interactive.sh"
#  replay "source ~/.config/posix-common/interactive.sh"
#  set -l _location "fish/interactive.fish"
#  _mordu "Finished sourcing Interactive Shell settings from ~/.config/posix-common/interactive.sh"
# <<< DON'T USE THIS BLOCK

# >>> USE THIS BLOCK
# Aliases Second 
#_mordu "Sourcing Aliases from ~/.config/posix-common/aliases.d/*."
#for alias_file in ~/.config/posix-common/aliases.d/*.sh
#  _mordu "Sourcing $alias_file."
#  set -l _location "posix-common/aliases.d/$alias_file"
#  #replay "source $alias_file"
#end
#set -l _location interactive.fish
#_mordu "Finished sourcing Aliases from ~/.config/posix-common/aliases.d/*."
# <<< USE THIS BLOCK
# }}} === Source Posix Common Aliases ===

# {{{ === Source Posix Common Environment Variables ===
#_mordu "Sourcing Common Env Vars from ~/.config/posix-common/env.sh."
#replay "source ~/.config/posix-common/env.sh"
#set -l _location "fish/interactive.fish"
#_mordu "Finished sourcing Common Env Vars from ~/.config/posix-common/env.sh."
# }}} === Source Posix Common Environment Variables ===

# {{{ === Source prompt.fish ===
_mordu "Sourcing Fish prompt from .config/fish/prompt.fish."
source "$HOME"/.config/fish/prompt.fish
set -l _location ".config/fish/interactive.fish"
_mordu "Finished sourcing Fish prompt from .config/fish/prompt.fish."
# }}} === Source prompt.fish ===

# {{{ === Enable VI Mode ===
_mordu "Enabling VI mode for command line editing."
function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings
# }}} === Enable VI Mode ===

# {{{ === Configure LS_COLORS ===
# ColorLS. Yes, 'lsd' will use it. ;)
# Sauce: https://github.com/trapd00r/LS_COLORS
#_mordu "Sourcing LS Colors from ~/.config/posix-common/lscolors.sh"
#replay 'source ~/.config/posix-common/lscolors.sh'
#_mordu "Finished LS Colors from ~/.config/posix-common/lscolors.sh"
# }}} === Configure LS_COLORS ===

# {{{ === Configure 'thefuck' / 'uwu' ===
# Neat little tool.  Not sure how to load it from
# posix-common/aliases.d/ yet.  That would be preferred. Right now I
# am loading it from interactive.fish and interactive.sh files.
if type -qf thefuck
    _mordu "Configuring 'thefuck' to be referenced as 'uwu'."
    thefuck --alias uwu | source
end
# }}} === Configure 'thefuck' / 'uwu' ===

# {{{ === FZF Completions ===
# Load default fzf keybindings
# fzf_key_bindings

# bind --erase --all \ct
# bind --erase --all \cr

# if not set --query fzf_fish_custom_keybindings
#     # \cf is Ctrl+f
#     # bind \cf __fzf_search_current_dir
#     # bind \cr __fzf_search_history
#     # # The following two key binding use Alt as an additional modifier key to avoid conflicts
#     # bind \e\cl __fzf_search_git_log

#     # set up the same key bindings for insert mode if using fish_vi_key_bindings
#     if test "$fish_key_bindings" = fish_vi_key_bindings -o "$fish_key_bindings" = fish_hybrid_key_bindings
#         # bind --mode insert \cf __fzf_search_current_dir
#         # bind --mode insert \cr __fzf_search_history
#         # bind --mode insert \e\cl __fzf_search_git_log
#     end
# end

# function _mgk-fzf_uninstall --on-event fzf_uninstall
#     # Not going to erase FZF_DEFAULT_OPTS because too hard to tell if it was set by the user or by this plugin
#     if not set --query fzf_fish_custom_keybindings
#         # bind --erase --all \cf
#         # bind --erase --all \cr
#         # bind --erase --all \e\cl

#         set_color --italics cyan
#         echo "mgk-fzf.fish key bindings removed"
#         set_color normal
#     end

#     #set --erase __fzf_search_vars_cmd
#     functions --erase _mgk_fzf_uninstall
# end
# }}} === FZF Completions ===

# {{{ === Aliases: Sudo ===
_mordu "Setting up sudo aliases."
alias firewall-cmd='sudo firewall-cmd'
alias fwc='sudo firewall-cmd'
alias dnf='sudo dnf'
alias systemctl='sudo systemctl'
alias lsof='sudo lsof'
alias service='sudo service'
alias snap='sudo snap'
alias sysupdate='dnf mc --refresh && dnf -y update'
alias lxc='sudo lxc'
# }}} === Aliases: Sudo ===
    
_mordu "Finished script."
