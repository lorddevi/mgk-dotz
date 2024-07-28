""""
"" XDG the nvim stuff
""""
"" Set a $MYVIMRC variable in case we want to reference our init file
"" for vim any time in the future.
if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

"" Likely unneeded sanity check for XDG_* Vars.  Make sure they exist.
if empty($XDG_CACHE_HOME)  | let $XDG_CACHE_HOME  = $HOME."/.cache"       | endif
if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME."/.config"      | endif
if empty($XDG_DATA_HOME)   | let $XDG_DATA_HOME   = $HOME."/.local/share" | endif

"" Add entries to runtimepath.
set runtimepath^=$XDG_CONFIG_HOME/nvim
set runtimepath+=$XDG_DATA_HOME/nvim
set runtimepath+=$XDG_CONFIG_HOME/nvim/after

"" Set a directory for vim8 build in packages.
set packpath^=$XDG_DATA_HOME/nvim,$XDG_CONFIG_HOME/nvim
set packpath+=$XDG_CONFIG_HOME/nvim/after,$XDG_DATA_HOME/nvim/after

"" Give Netrw the same home as vimrc.
let g:netrw_home = $XDG_DATA_HOME."/nvim"

"" Make sure there is a /spell directory in an XDG friendly location
"" for vim to find.
call mkdir($XDG_DATA_HOME."/nvim/spell", 'p', 0700)

set viewdir=$XDG_DATA_HOME/nvim/view      | call mkdir(&viewdir, 'p', 0700)
set undodir=$XDG_CACHE_HOME/nvim/undo     | call mkdir(&undodir,   'p', 0700)

""""
"" Import Common Settings
""""
"" Source the settings we can share in common with neovim safely.
:source $XDG_CONFIG_HOME/vim/common-vim-settings.vim


""""
"" Begin NVim Plugin Stuff
""""
call plug#begin()
Plug '~/.local/opt/git/git.mgk.one/vim/khaveesh.vim-fish-syntax'
Plug '~/.local/opt/git/git.mgk.one/nvim/norcalli.nvim-colorizer.lua'
""Plug '~/.local/opt/git/git.mgk.one/nvim/ishan9299.modus-theme-vim'
""Plug '~/.local/opt/git/git.mgk.one/nvim/maxmx03.dracula.nvim'
""Plug '~/.local/opt/git/git.mgk.one/nvim/maxmx03.solarized.nvim'
Plug '~/.local/opt/git/git.mgk.one/nvim/craftzdog.solarized-osaka.nvim'
""Plug '~/.local/opt/git/git.mgk.one/vim/lifepillar.vim-solarized8', { 'branch': 'neovim' }


""Plug '~/.local/opt/git/christoomey.vim-tmux-navigator'
Plug '~/.local/opt/git/git.mgk.one/tmux/sunaku.tmux-navigate'

Plug '~/.local/opt/git/git.mgk.one/vim/tpope.vim-surround'
Plug '~/.local/opt/git/git.mgk.one/vim/tpope.vim-repeat'
call plug#end()

""""
"" Custom Vim-Tmux-Navigator mappings.
""""
""let g:tmux_navigator_no_mappings = 1
""
""nnoremap <silent> <C-a>h :TmuxNavigateLeft<cr>
""nnoremap <silent> <C-a>j :TmuxNavigateDown<cr>
""nnoremap <silent> <C-a>k :TmuxNavigateUp<cr>
""nnoremap <silent> <C-a>l :TmuxNavigateRight<cr>
""nnoremap <silent> <C-a>\ :TmuxNavigatePrevious<cr>

""noremap <silent> <m-h> :TmuxNavigateLeft<cr>
""noremap <silent> <m-j> :TmuxNavigateDown<cr>
""noremap <silent> <m-k> :TmuxNavigateUp<cr>
""noremap <silent> <m-l> :TmuxNavigateRight<cr>

"" Enable nvim-colorizer globally.
set termguicolors
lua require'colorizer'.setup()

"" Set theme to modus
""colorscheme modus-vivendi
""colorscheme dracula
""colorscheme solarized8_high

""colorscheme solarized
colorscheme solarized-osaka
