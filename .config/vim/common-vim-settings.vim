"" ~/.config/vim/common-vim-settings.vim
""
"" This file is a good place to put vim configuration options that we
"" can share with neovim or other vim compatible editors.  I opted to
"" have a separate config for both neovim and vim, to try and future
"" proof myself.  Also because I like to complicate things.


"" Set vim's shell to sh.
"" I frequently use fish as my login shell, which vim does not like.
if &shell =~# 'fish$'
    set shell=sh
endif


""""
"" Backup Settings
""""
set backupdir=$XDG_CACHE_HOME/backups/edits//     | call mkdir(&backupdir, 'p', 0700)
set directory=$XDG_CACHE_HOME/backups/autosaves// | call mkdir(&directory, 'p', 0700)

set backup "" Enable backups.
set writebackup "" Make backup before overwriting current buffer.
set backupcopy=yes "" Overwrite original backup file.

"" Meaningful backup name, ex: filename@2015-04-05.14:59
"" Sauce: https://gist.github.com/nepsilon/003dd7cfefc20ce1e894db9c94749755
au BufWritePre * let &bex = '##' . expand($USER) . '@'. hostname() . ',' . strftime("%F.%T.%z") . '~'


""""
"" Configure General Options
""""
"" Set the default foldingmethod.
set foldmethod=marker

"" Enable syntax highlighting
syntax on

"" Normalize the behaviour of backspace.  This may be worth undoing at some point.
set backspace=indent,eol,start

"" Incsearch: Show search matches while typing
set incsearch

"" Autoindent: Copy indent level from current line when starting a new line.
set autoindent

"" Smartindent: Enhanced autoindent by attempting to help guess nest levels.
set smartindent

"" Ruler: Show line and column number of cursor position.
set ruler

"" Smartab: Start of line tabs use 'shiftwidth', not 'tabstop' or
""   'softtabstop'.
set smarttab

"" Matchtime: Changes the time it takes to show matching paren.
set matchtime=2


""""
"" Tab Settings
""""
"" Tabstop: The number of spaces a TAB counts for.
""   Should typically be left at 8 for best compatability.
set tabstop=2
set shiftwidth=2
set softtabstop=2


""""
"" clipboard
""""
set clipboard+=unnamedplus


""""
"" keymappings / tools
""""
