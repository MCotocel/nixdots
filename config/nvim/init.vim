" General

set undofile                                              " Undo even after file close
set undodir=~/.cache/nvim/undo                            " Undo file location
set hidden                                                " Unsaved buffer is hidden instead of closed
set autoindent                                            " Automatically indent lines
set tabstop=4                                             " Set tab to 4 spaces
set shiftwidth=4                                          " Set tab to 4 spaces
set expandtab                                             " Convert tabs to spaces
set backspace=indent,eol,start                            " Make backspace key work
set autoread                                              " Auto read when file is changed
set nowrap                                                " Does not wrap text
set laststatus=2                                          " Always display status line
set hlsearch                                              " Highlights matching search patterns
set nolist                                                " Hides special characters
set so=15                                                 " Sets 15 lines to the cursor
set ignorecase                                            " Ignores case when searching
set smartcase                                             " Case insensitive only if all letters are lowercase
set foldcolumn=1                                          " Adds a little margin
set splitbelow                                            " Opens splits below main pane
set incsearch                                             " Incremental search
set showcmd                                               " Shows entered commands
set conceallevel=0                                        " Does not hide concealed characters
set relativenumber                                        " Relative line number
set numberwidth=3                                         " Line number column width
set foldmethod=manual                                     " Manual folding
set autochdir                                             " Set working directory to current file
" set signcolumn=number

set guicursor+=n-v-r:hor25 guicursor+=c-i:ver25           " Sets cursor to underline when in normal mode
set guicursor+=n-v-r-c-i:blinkwait10-blinkon20-blinkoff20 " Blink cursor

syntax on                                                 " Syntax color highlighting
filetype off                                              " Filetype detection off

" Spell suggestion size
set spellsuggest=7

" Hide mode
set noshowmode

" Plugins

" Mappings

" Changes leader key
let mapleader=' '

" Maps redraw screen and remove highlights
map <silent> <M-r> :nohl<CR><C-l>

" Toggle spelling
map <silent> <C-M-s> :setlocal spell! spelllang=en_us<CR>

" Maps quit and save
nmap <silent> <M-q> :q<CR>
nmap <silent> <M-s> :w<CR>

" Easier commands
nnoremap ; :

" Goes to file
map <silent> <C-o> gf

" Remaps Scroll up and down
map <M-k> <C-u>
map <M-j> <C-d>

" Sources Vim config file
nmap <silent> <C-A-r> :source ~/.config/nvim/init.vim <CR>

" Buffers and tabs

" Close buffer/tab
nnoremap <silent> <M-w> :bd <CR>

" New buffer
nnoremap <silent> <C-n> :new <CR>

" New tab
nnoremap <silent> <C-t> :tabnew <CR>

" Next buffer
nnoremap <silent> <M-TAB> :bn <CR>

" Next tab
nnoremap <silent> <S-TAB> :tabn <CR>

" Windows

" Horizontal and vertical splits
noremap <silent> <C-W>h :split <CR>
noremap <silent> <C-W>v :vsplit <CR>

" Window navigation
noremap <silent> <Left> <C-w>h
noremap <silent> <Down> <C-w>j
noremap <silent> <Up> <C-w>k
noremap <silent> <Right> <C-w>l

" Window resizing
noremap <silent> <M-Left> :vertical resize +5 <CR>
noremap <silent> <M-Down> :res -5 <CR>
noremap <silent> <M-Up> :res +5 <CR>
noremap <silent> <M-Right> :vertical resize -5 <CR>

" Leader bindings

" Copy to clipboard
vmap <leader>y "+y

" Colorscheme
" colorscheme xresources
colorscheme quiet
set termguicolors

set fillchars=vert:\
hi! VertSplit guifg=None guibg=None
hi! HorSplit guifg=None guibg=None
hi NonText guifg=bg

" Statusline config

" Highlighting
hi StatusLine guifg=#98C379 guibg=NONE

" Empty status
set statusline=

" File
set statusline+=\ %F
set statusline+=\ \╱

" Changed
set statusline+=\ %m

" Switch to right side
set statusline+=%=
set statusline+=\ \╲

" Filetype
set statusline+=\ Filetype:
set statusline+=\ %y
set statusline+=\ \╲

" Line and column
set statusline+=\ Line:
set statusline+=\ %l
set statusline+=\/%L
set statusline+=\,
set statusline+=\ Column:
set statusline+=\ %c
set statusline+=\ \╲

" Percentage through file
set statusline+=\ %p%%
set statusline+=\

" Icons ╱╲⎜

" Functions

" Toggle cursor bind
function! ToggleCursorbind()
  if &cursorbind == 1
    set nocursorbind
  else
    set cursorbind
  endif
endfunction

" Remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave ?* silent! mkview
  autocmd BufWinEnter ?* silent! loadview
augroup END
