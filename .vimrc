" ======================================================================================================
set nocompatible " New vim features when available
set backspace=indent,eol,start " Allow backspacing in Insert mode
set history=50 " Remember last 50 commands
set ruler " Show current cursor position in the bottom line
syntax on " Turn on syntax
"syntax enable

" Indent and space
filetype indent on
filetype plugin indent on
set shiftwidth=4
set expandtab
set softtabstop=4
set tabstop=4
set autoindent
set smartindent
set cindent
set smarttab

" Other settings
set splitright " Open split windows on the right (:vnew)
set splitbelow " Open split windows below (:new)
set hidden " Vim doesnt require to save current file when :e new_file (open new file)
set number " Vim show line numbers
set encoding=utf-8
set shiftround " When shifting a non-aligned set of lines, align them to the next tabstop
set textwidth=0
set wrap "Wrap text
set linebreak "Wrap text at the end of word
set nolist "Turn off display whitespace as text
set autoread " Auto re-read files changed out of vim
set autowrite " Auto save before executing command
set wildmenu " Show all options when pressing <Tab> if there s more than one
set clipboard=unnamed,unnamedplus " y and d put stuffs in system clipboard
set showcmd " Show cmd in the bottom right corner
set timeout
set timeoutlen=300 ttimeoutlen=0 " Timeout for mapped cmds
set display+=lastline " Show all if displaying line is too long
set display+=uhex " Show cannot be displayd chars as <13> instead of ^M
set lazyredraw " Dont redraw while executing macros (for performance)
set mouse-=a " disable mouse in vim; set mouse=a to enable
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"set virtualedit=all " Move the cursor freely even in empty lines
"
" ======================================================================================================
"
" Starting NERDTree
function! ToggleNERDTree()
  if getbufvar('%', '&filetype')=='nerdtree'
    bd
  else
    NERDTreeToggle
    only
  endif
endfunction

nnoremap <C-n> :call ToggleNERDTree()<CR>
" or nnoremap <C-n> :if getbufvar('%', '&filetype')=='nerdtree' <bar> bd <bar> else <bar> NERDTreeToggle <bar> only <bar> endif<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close Nerdtree upon opening file
let g:NERDTreeQuitOnOpen = 1
"
" ======================================================================================================

" Compile
"
"****************************************************************************
"
" Auto brackets
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}
"
"****************************************************************************
"
" Numbertoggle and MyDiff settings from William Lin
augroup numbertoggle " For fast navigating using <number>j/k
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
"
"****************************************************************************
"
" -Wextra -Wshadow flags to get more errors.
" Adding -fsanitize=address will tells the compiler to insert additional code into the program that checks for common memory-related errors such as buffer overflows, use-after-free, and out-of-bounds accesses. Will slow down compile time.
" Adding -g flag will create a dSYM file
" Ask for a cpp template to load when creating a new file
autocmd BufNewFile *.cpp execute "0r ~/.vim/template/".input("Template name: ").".cpp" 
autocmd filetype cpp nnoremap <C-p> :w <bar> <C-U>!g++ -std=c++17 -O2 -Wall -Wextra -Wshadow % -o %:r && time ./%:r<CR>
autocmd filetype cpp nnoremap <C-m> :w <bar> <C-U>!time ./%:r<CR>
map <C-s> :w <CR>
"map <C-p> :!gdb ./%:r <CR>
"
"****************************************************************************
"
