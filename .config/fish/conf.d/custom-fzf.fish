#!/usr/bin/env fish
set _location ".config/fish/conf.d/custom-fzf.fish"

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

# {{{ === Function: fzf-cd-widget "Change directory" ===
# Set up the default, mnemonic key bindings unless the user has chosen to customize them
# function fzf-cd-widget -d "Change directory"
#     set -l commandline (__fzf_parse_commandline)
#     set -l dir $commandline[1]
#     set -l fzf_query $commandline[2]
#     set -l prefix $commandline[3]

#     test -n "$FZF_ALT_C_COMMAND"; or set -l FZF_ALT_C_COMMAND "
#     command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
# 	-o -type d -print 2> /dev/null | sed 's@^\./@@'"
#     test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
#     begin
# 	set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"
# 	eval "$FZF_ALT_C_COMMAND | "(__fzfcmd)' +m --query "'$fzf_query'"' | read -l result

# 	if [ -n "$result" ]
#             cd $result

#             # Remove last token from commandline.
#             commandline -t ""
#             commandline -it -- $prefix
# 	end
#     end

#     commandline -f repaint
# end
# }}} === Function: fzf-cd-widget "Change directory" ===

# {{{ === Function: fzf "Main fzf function. User fzf-tmux if in Tmux." ===
# Check if fzf is being ran inside of TMUX or not.
# function fzf --wraps=fzf --description="Use fzf-tmux if in tmux session"
#     if set --query TMUX
# 	fzf-tmux $argv
#     else
# 	command fzf $argv
#     end
# }}} === Function: fzf "Main fzf function. User fzf-tmux if in Tmux." ===
  
# {{{ === Function: __fzfcmd "Fzf Tmux Test." ===
function __fzfcmd
  test -n "$FZF_TMUX"; or set FZF_TMUX 0
  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  if [ -n "$FZF_TMUX_OPTS" ]
    echo "fzf-tmux $FZF_TMUX_OPTS -- "
  else if [ $FZF_TMUX -eq 1 ]
    echo "fzf-tmux -d$FZF_TMUX_HEIGHT -- "
  else
    echo "fzf"
  end
end
# }}} === Function: __fzfcmd "Fzf Tmux Test." ===

# {{{ === Function: __fzf_parse_commandline ===
function __fzf_parse_commandline -d 'Parse the current command line token and return split of existing filepath, fzf query, and optional -option= prefix'
  set -l commandline (commandline -t)
  
  # strip -option= from token if present
  set -l prefix (string match -r -- '^-[^\s=]+=' $commandline)
  set commandline (string replace -- "$prefix" '' $commandline)
  
  # eval is used to do shell expansion on paths
  eval set commandline $commandline
  
  if [ -z $commandline ]
    # Default to current directory with no --query
    set dir '.'
    set fzf_query ''
  else
    set dir (__fzf_get_dir $commandline)
    if [ "$dir" = "." -a (string sub -l 1 -- $commandline) != '.' ]
      # if $dir is "." but commandline is not a relative path, this means no file path found
      set fzf_query $commandline
    else
      # Also remove trailing slash after dir, to "split" input properly
      set fzf_query (string replace -r "^$dir/?" -- '' "$commandline")
    end
  end
  echo $dir
  echo $fzf_query
  echo $prefix
end
# }}} === Function: __fzf_parse_commandline ===

# {{{ === Function: __fzf_get_dir ===
function __fzf_get_dir -d 'Find the longest existing filepath from input string'
  set dir $argv
  
  # Strip all trailing slashes. Ignore if $dir is root dir (/)
  if [ (string length -- $dir) -gt 1 ]
    set dir (string replace -r '/*$' -- '' $dir)
  end
  
  # Iteratively check if dir exists and strip tail end of path
  while [ ! -d "$dir" ]
    # If path is absolute, this can keep going until ends up at /
    # If path is relative, this can keep going until entire input is consumed, dirname returns "."
    set dir (dirname -- "$dir")
  end
  echo $dir
end
# }}} === Function: __fzf_get_dir ===

# {{{ === Configure FZF Keybindings ===
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

# Vi View Mode FZF Bindings
#bind \ec fzf-cd-widget
bind \ec '__fzf_cd'
bind \eC '__fzf_cd --hidden'
bind \cg '__fzf_open'
bind \co '__fzf_open --editor'
bind \cf '__fzf_search_current_dir'
bind \cr '__fzf_search_history'
bind \e\cs '__fzf_search_git_status'
bind \e\cl '__fzf_search_git_log'

# Vi Insert Mode FZF Bindings
if bind -M insert > /dev/null 2>&1
  #    bind --mode insert \ec fzf-cd-widget
  bind --mode insert \ec '__fzf_cd'
  bind --mode insert \eC '__fzf_cd --hidden'
  bind --mode insert \cg '__fzf_open'
  bind --mode insert \co '__fzf_open --editor'
  bind --mode insert \cf '__fzf_search_current_dir'
  bind --mode insert \cr '__fzf_search_history'
  bind --mode insert \e\cs '__fzf_search_git_status'
  bind --mode insert \e\cl '__fzf_search_git_log'
end
# }}} === Configure FZF Keybindings ===

_mordu "Finished script."
