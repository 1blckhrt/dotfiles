set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'voldikss/vim-floaterm'
Plugin 'scrooloose/nerdtree',{'on':'NERDTreeToggle'}

" themes
Plugin 'joshdick/onedark.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif