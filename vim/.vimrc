" ----------------------------------------
" general
" ----------------------------------------
set nocompatible
set history=100
set autoread                    " auto read when file is changed outside
filetype plugin on              " enable filetype plugins
filetype indent on
let mapleader= ","              " <leader> key
let g:mapleader = ","           " <leader> key
let maplocalleader = ","        " <localleader> key
set encoding=utf8
syntax on

" detect os
if !exists("g:os")
    if has("win32") || has("win64")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" ----------------------------------------
" user interface
" ----------------------------------------
set ruler
set number
set scrolloff=5
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" status line
set laststatus=2

" clear highlighting
nnoremap <CR> :noh<CR><CR>

" ----------------------------------------
" tab and indent
" ----------------------------------------
set autoindent
set smartindent
set expandtab
set smarttab

" 4 spaces for 1 tab
set shiftwidth=4
set tabstop=4

" ----------------------------------------
" moving
" ----------------------------------------
" treat long lines as break lines
map j gj
map k gk

" move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" using Command+[jk] on mac
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" insert mode navigation
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" window navigation (managed by vim-tmux-navigator now)
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" ----------------------------------------
" plugin manager
" ----------------------------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" plugins
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/Align'
Plugin 'vim-scripts/VimIM'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'vim-latex/vim-latex'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/python_match.vim'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/taglist.vim'
Plugin 'chikamichi/mediawiki.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'terryma/vim-multiple-cursors'

" color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'Pychimp/vim-sol'
Plugin 'Pychimp/vim-luna'

call vundle#end()
filetype plugin indent on


" ----------------------------------------
" plugin settings
" ----------------------------------------
" vimim
let g:vimim_cloud=-1 
let g:vimim_toggle=-1
let g:vimim_punctuation=3                       " including quotation marks
set pastetoggle=<C-h>

" surround
let b:surround_{char2nr("i")} = "_\r_"          " markdown italic
let b:surround_{char2nr("s")} = "**\r**"        " markdown bold
nmap <leader>i viwSiW
imap <leader>i <ESC>viwSiWa
nmap <leader>b viwSsW
imap <leader>b <ESC>viwSsWa

" easymotion
map f <Plug>(easymotion-prefix)
map fw <Plug>(easymotion-bd-w)
map fl <Plug>(easymotion-bd-jk)

" taglist
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Show_One_File = 1	                    " only show tags for current file
let Tlist_Use_Right_Window = 1	                " show Taglist window on the right
let Tlist_Exit_OnlyWindow = 1	                " quit when Taglist is the last window

" vim-latex
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
" set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_CompileRule_pdf = 'pdflatex $*'

if g:os == "Darwin"
    let g:Tex_ViewRule_pdf = 'open -a Preview'
elseif g:os == "Linux"
    let g:Tex_ViewRule_pdf = 'xdg-open'
endif

nnoremap <leader>t :TlistToggle<CR>

" difference between the current buffer and the file it was loaded from
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" indent guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" delimitmate
let g:delimitMate_expand_cr=1

" ----------------------------------------
" color scheme
" ----------------------------------------
set background=light
silent! colorscheme sol

" change transparency
noremap <F9> :call IncreaseTransparency()<CR>

" ----------------------------------------
" mappings
" ----------------------------------------
" switch colon and semicolon
nnoremap ; :
nnoremap : ;

" background toggle
noremap <F10> :call ToggleBackground()<CR>

" ----------------------------------------
" functions
" ----------------------------------------
" background toggle
function! ToggleBackground()
    if (&background == 'light')
        set background=dark
        colorscheme luna
    else
        set background=light
        colorscheme sol
    endif
endfunction

function! IncreaseTransparency()
endfunction
