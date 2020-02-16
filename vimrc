set nocompatible
filetype off

" Call :PluginInstall after changing these.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin '907th/vim-auto-save'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'fatih/vim-go'
Plugin 'leafgarland/typescript-vim'
Plugin 'posva/vim-vue'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'VundleVim/Vundle.vim'
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
set foldlevelstart=5
set backspace=2

filetype plugin indent on

au BufRead,BufNewFile *.tmpl set filetype=html

au FileType sh,sql,go setlocal noexpandtab
au FileType c,h setlocal cindent
au FileType sh setlocal textwidth&

" ctags
set tags=tags;/

" AutoSave
let g:auto_save = 1
