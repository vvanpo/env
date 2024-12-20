set nocompatible
filetype off

" Call :PluginInstall after changing these.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin '907th/vim-auto-save'
Plugin 'dense-analysis/ale'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'fatih/vim-go'
Plugin 'leafgarland/typescript-vim'
Plugin 'posva/vim-vue'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'VundleVim/Vundle.vim'
Plugin 'ludovicchabant/vim-gutentags'
call vundle#end()

syntax on

set viminfo=""

set ruler
set number
set hlsearch

" Auto-wrap everything past 80 chars
set columns=80
" textwidth causes automatic linebreaks:
" set textwidth=80
set linebreak
set wrap
set showbreak=..

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set foldmethod=indent
set foldlevelstart=5
set backspace=2

" https://unix.stackexchange.com/a/5313
set visualbell
set t_vb=

filetype plugin indent on

au BufRead,BufNewFile *.tmpl set filetype=html
au BufRead,BufNewFile *.cjs set filetype=javascript
au BufRead,BufNewFile *.mjs set filetype=javascript

au FileType sh,sql,go setlocal noexpandtab
au FileType c,h setlocal cindent
au FileType html,sh setlocal textwidth&

" AutoSave
let g:auto_save = 1

let g:ale_fixers = {
\   'css': ['stylelint', 'prettier'],
\   'javascript': ['eslint', 'prettier'],
\}
let g:ale_set_highlights = 0
