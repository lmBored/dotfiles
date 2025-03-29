" ======================================================================================================
set t_Co=256
let g:airline#extensions#disable_rtp_load=1

"True color support
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Settings from
" https://gist.github.com/paulrouget/ad44d1a907a668d012d23b0c1bdf72f9
set background=dark
" let g:gruvbox_italic=1
" let g:gruvbox_termcolors=16
" let g:gruvbox_contrast_dark = 'hard'
" let g:airline_powerline_fonts = 1
" let g:airline_theme='base16'
" colorscheme gruvbox
" colorscheme retrobox

colorscheme catppuccin_macchiato
let g:catppuccin_italic=1
let g:catppuccin_termcolors=16
let g:catppuccin_contrast_dark = 'hard'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'catppuccin_macchiato'

hi LineNr ctermfg=237
hi StatusLine ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
hi EndOfBuffer ctermfg=237 ctermbg=235
set termguicolors

set statusline=%=%P\ %f\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2
set noshowmode
" End

packadd comment "Turn on vim comment plugin <:help comment-install>

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
set guifont=Iosevka\ 20
set guioptions-=m
set guioptions-=T
" set relativenumber
set norelativenumber
set ignorecase
set smartcase
set incsearch
set autochdir
set cinoptions=l1

" Other settings
set splitright " Open split windows on the right (:vnew)
set splitbelow " Open split windows below (:new)
set hidden " Vim doesnt require to save current file when :e new_file (open new file)
" set number " Vim show line numbers
set nonumber " turn off line numbers
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
set termencoding=utf-8
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
set mouse=a " disable mouse in vim; set mouse-=a to disable

" Remove blank space when exiting vim
set cmdheight=1
set cmdwinheight=1

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"set virtualedit=all " Move the cursor freely even in empty lines

" Make background transparent
hi Normal guibg=NONE ctermbg=NONE
" Change vsplit separator, put it here cuz it has to render last else gonna be
" overwritten by colorscheme
hi VertSplit guifg=#292C3C guibg=#303446 ctermfg=235 ctermbg=NONE
"
" ======================================================================================================
"
" Starting NERDTred
" function! ToggleNERDTree()
"   if getbufvar('%', '&filetype')=='nerdtree'
"     bd
"   else
"     NERDTreeToggle
"     only
"   endif
" endfunction

" nnoremap <C-n> :call ToggleNERDTree()<CR>
" or nnoremap <C-n> :if getbufvar('%', '&filetype')=='nerdtree' <bar> bd <bar> else <bar> NERDTreeToggle <bar> only <bar> endif<CR>

" Toggle nerdtree
nnoremap <C-t> :NERDTreeToggle<CR>l
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeFileLines = 1
let NERDTreeShowHidden=1

" Close Nerdtree upon opening file
" let g:NERDTreeQuitOnOpen = 1
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
" augroup numbertoggle " For fast navigating using <number>j/k
"     autocmd!
"     autocmd BufEnter,FocusGained,InsertLeave * set rnu
"     autocmd BufLeave,FocusLost,InsertEnter * set nornu
" augroup END

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
" Vim plug
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"
"****************************************************************************
"
" Remove "File contents remains in terminal after exiting Vim
"if &term =~ "xterm"
"    let &t_ti = "\<Esc>[?47h"
"    let &t_te = "\<Esc>[?47l"
"endif

set rtp+=/opt/homebrew/opt/fzf

autocmd VimLeave * !clear
"
"****************************************************************************
"
" https://github.com/junegunn/fzf.vim/issues/358
" scroll using key bindings instead of shift up shift down for fzf preview
" panel
let $FZF_DEFAULT_OPTS="--preview-window 'right:57%' --preview 'bat --style=numbers --line-range :300 {}'
\ --bind ctrl-y:preview-up,ctrl-e:preview-down,
\ctrl-b:preview-page-up,ctrl-f:preview-page-down,
\ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,
\shift-up:preview-top,shift-down:preview-bottom,
\alt-up:half-page-up,alt-down:half-page-down"
