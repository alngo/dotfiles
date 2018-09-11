"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Encoding standard
"scriptencoding utf-8
"set encoding=utf-8

"Set path recursive
set path+=**

""Set some feature
syntax on
set autoindent
set autoread
set number
set showmatch

"No Error Bell
set noerrorbells
set novisualbell
set tm=500

""Set Marker on file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")| exe "normal! g'\"" | endif

"Delete Trailing White Space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()

color despacio
set nu
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

"Tab manipulation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap tm  :tabm<Space>
nnoremap ta  :tab all<CR>

"Panes manipulation
nnoremap <S-j> <C-W><C-J>
nnoremap <S-k> <C-W><C-K>
nnoremap <S-l> <C-W><C-L>
nnoremap <S-h> <C-W><C-H>

"Cursor Shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Show file options above the command line
set wildmenu

" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*

" Pathogen()
execute pathogen#infect()

" Plug()
call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()
