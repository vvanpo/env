set nocompatible
filetype off

" Call :PluginInstall after changing these.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
call vundle#end()

syntax on

set viminfo=""

set ruler
set number
set showbreak=..
set hlsearch

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80

set foldmethod=indent
set foldnestmax=5
set backspace=2

filetype plugin indent on

au BufRead,BufNewFile *.tmpl set filetype=html
au BufRead,BufNewFile *.vue set filetype=js

au FileType go,sql setlocal noexpandtab
au FileType c,h setlocal cindent

" ctags
set tags=tags;/
