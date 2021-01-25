syntax on

"
"" Change color scheme
"
colorscheme solarized8

"
"" Improve menu colors
"   https://github.com/dracula/vim/issues/14#issuecomment-260397685
"
hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE

"
"" Improve bracket highlighting colors
"   https://stackoverflow.com/a/10746829
"
highlight MatchParen cterm=bold ctermbg=yellow ctermfg=red

"
"" Indentation
"   http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
"
filetype plugin indent on
" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab
" for other files, 4 spaces
autocmd Filetype tcl,xml,sh setlocal ts=4 sw=4 sts=0 expandtab


"
" Enable use of the mouse for all modes
"
set mouse=a


"
"" Swap cursor in vim insert mode
"   https://gist.github.com/andyfowler/1195581
"
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


"
"" Eliminating delays on ESC in vim
"   https://www.johnhawthorn.com/2012/09/vi-escape-delays/
"
set timeoutlen=1000 ttimeoutlen=0



"
"" Disabling automatic comment insertion
"   http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
"
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"
"" Improve searches
"   http://stackoverflow.com/questions/7103173/vim-how-to-change-the-highlight-color-for-search-hits-and-quickfix-selection
"
set ignorecase
set smartcase
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=yellow

"
"" Activate javascript syntax for jsonnet files
"
autocmd BufNewFile,BufRead *.jsonnet   set syntax=javascript

"
"" Add number of lines and more info at the bottom of vim
"
set ruler

"
"" Set the backspace to delete normally
"   https://stackoverflow.com/questions/44471262/cant-delete-character-in-vim
"
set backspace=indent,eol,start
