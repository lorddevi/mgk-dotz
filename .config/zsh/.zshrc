#!/usr/bin/env zsh
_location=".config/zsh/interactive.zsh"

# {{{ <mordu debug system>
_debug=y # Comment this out to disable debugging.
_blue="\033[34m"
_magenta="\033[35m"
_green="\033[92m"
_cyan="\033[36m"
_white="\033[97m"
_end_color="\033[0m"

# Mordu with location.
_mordu() {
    [[ -n "$_debug" ]] && echo -e "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Mordu with location and no new line.
_mordu_n() {
    [[ -n "$_debug" ]] && echo -en "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Echo with new line to add completion messages to _mordu_n
_mordu_nl() {
    [[ -n "$_debug" ]] && echo -e "${_white}$*${_end_color}"
}

_mordu "Starting script."
# }}} </mordu debug system>
    
# {{{ === Source Posix Common interactive.sh ===
_mordu "Sourcing interactive shell settings from ~/.config/posix-common/interactive.sh."
source "$HOME"/.config/posix-common/interactive.sh
_location=".config/zsh/interactive.zsh"
_mordu "Completed sourcing interactive shell settings from ~/.config/posix-common/interactive.sh."
# }}} === Source Posix Common interactive.sh ===

# {{{ === Zinit Bootstrap ===
_mordu "Performing ZINIT bootstrap."
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [ ! -d $ZINIT_HOME ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
fi
if [ ! -d $ZINIT_HOME/.git ]; then
	ghq get git.mgk.one/zsh/zdharma-continuum.zinit.git
fi

source "${ZINIT_HOME}/zinit.zsh"


_mordu "Enabling Turbo mode for Zinit."
MY_ZINIT_USE_TURBO=true

# Create an type of alias for loading modules more easily.
_icemgk () {zinit ice from"git.mgk.one" proto"https" $*}

# Shortcut for plugin locations
ZPLUGS="$HOME/.local/opt/git/git.mgk.one/zsh"
# Use mgkload to switch between 'load' and 'light' if desired.
mgkload=light

_mordu "Enabling important annexes."
_icemgk
zinit $mgkload "$ZPLUGS"/zdharma-continuum.zinit-annex-meta-plugins

# Example sourcing locally instead:
#zinit depth=1 lucid light-mode for \
#       ~/.local/git/zinit-annex-as-monitor

_icemgk
zinit $mgkload "$ZPLUGS"/zdharma-continuum.zinit-annex-bin-gem-node

_icemgk
zinit $mgkload "$ZPLUGS"/zdharma-continuum.zinit-annex-patch-dl

_icemgk
zinit $mgkload "$ZPLUGS"/zdharma-continuum.zinit-annex-rust
_mordu "Important annexes loaded."
# }}} End Zinit Bootstrap

# {{{ === Prompt setup. ===
#_mordu "Sourcing Zsh prompt from ~/.config/zsh/prompt.zsh."
#source "$HOME"/.config/zsh/prompt.zsh
#_location=".config/zsh/interactive.zsh"
#_mordu "Finished sourcing Zsh prompt from ~/.config/zsh/prompt.zsh."

_mordu "Setting prompt to powerlevel10k."
_icemgk
zinit $mgkload "$ZPLUGS"/romkatv.powerlevel10k
. "$HOME"/.config/zsh/prompt.zsh

# }}} === Prompt setup. ===

# {{{ === VI mode for zsh. ===
_mordu "Enabling vi mode for Zsh."
bindkey -v  # First enable vi mode for zsh.
KEYTIMEOUT=1 # Next reduce the delay zsh has between mode switches.
bindkey "^?" backward-delete-char # Tame the backspace key in insert mode.
export KEYTIMEOUT
# }}} === VI mode for zsh. ===

# {{{ === Misc Shell Settings. ===
_mordu "Configuring misc shell settings such as beeps and notifies."
# Disable beeps
unsetopt beep

# Report status of background jobs instantly.
setopt notify
# }}} === Misc Shell Settings. ===

# {{{1 === Completions ===

# {{{2 == Load zsh-completions & compinit ==
_mordu "Configuring completion framework."
_icemgk atload"zicompinit; zicdreplay" blockf lucid wait
zinit $mgkload "$ZPLUGS"/zsh-users.zsh-completions
# }}}  == Load zsh-completions & compinit ==

# {{{2 === Set Misc Completion Options ==
# cd to directory by typing its name.
setopt autocd

# Enhanced wildcards.
setopt extendedglob

# Print an error when filename completion fails.
setopt nomatch

# Enable completions cache.
zstyle ':completion::complete:*' use-cache 1

# Complete using aliases as well as executables.
setopt complete_aliases
# }}}  ==  Set Misc Completion Options ==

# {{{2 == Fish Style Completion ==
# Each 'string in quotes' is tried in order until one them succeeds.
# r:|[.]=** does .bar -> foo.bar
# r:?|[-_]=** does f-b -> foo-bar and F_B -> FOO_BAR
# l:?|=[-_] does foobar -> foo-bar and FOOBAR -> FOO_BAR
# m:{[:lower:]-}={[:upper:]_} does foo-bar -> FOO_BAR
# r:|?=** does fbr -> foo-bar and bar -> foo-bar

# The below was my last current preference for fuzzy matching.
zstyle ':completion:*:complete:*' matcher-list \
  'r:|[.]=** r:?|[-_]=** l:?|=[-_] m:{[:lower:]-}={[:upper:]_}' \
  'r:|?=** m:{[:lower:]}={[:upper:]}'
# }}}  == Fish Style Completion ==

# {{{2 == FZF Completion Settings ==
_mordu "Setting up fzf-tab for enhanced fuzzy searching with a tui."
_icemgk lucid wait
zinit $mgkload "$ZPLUGS"/aloxaf.fzf-tab

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

## Display group descriptions as headers.
zstyle ':fzf-tab:*' show-group full

## preview directory's content with exa when completing cd BROKEN
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always --icon=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 90 0

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Add some handy keybindings
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-s:toggle' 'ctrl-a:toggle-all'

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# Systemd unit status preview.
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Enable cat preview using lessfilter TODO Too small
# BUG: This is creating an annoying preview box in command previews.
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

# Enable previews for environment variables.
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'

# Enable previews for git.
# it is an example. you can change it
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# Preview for tldr
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'

zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
  \u00a6 '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'

# }}}  == FZF Completion Settings ==

# }}} === Completions ===

# {{{ === Zsh Autosuggestions ===
_mordu "Configuring autosuggestions."
_icemgk lucid wait
zinit $mgkload "$ZPLUGS"/zsh-users.zsh-autosuggestions

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# }}} End Zsh Autosuggestions

# {{{ === Fast Syntax Highlighting ===
_mordu "Configuring syntax highlighting."
_icemgk lucid wait
zinit $mgkload "$ZPLUGS"/zdharma-continuum.fast-syntax-highlighting
# }}} End Fast Syntax Highlighting

# {{{ === Command History Searching ===
_mordu "Configuring command history recall."
_icemgk lucid wait
#zinit $mgkload git/pub/by-name/history-search-multi-word.git
zinit $mgkload "$ZPLUGS"/joshskidmore.zsh-fzf-history-search
# }}}=== Command History Searching ===

# {{{ === Source conf.d/ Config Scripts ===
_mordu "Loading configs from ~/.config/zsh/conf.d/*."
for config in "$HOME"/.config/zsh/conf.d/* ; do
	_mordu "Sourcing $config."
	source $config
done
# }}} === Source conf.d/ Config Scripts ===

_mordu "Finished script."
