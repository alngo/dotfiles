"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_emit_conflict_warnings = 0
" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'mattn/emmet-vim'
  Plug 'w0rp/ale'
  Plug 'vim-syntastic/syntastic'
call plug#end()

" Ale configuration
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
" Emmet plugin
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
" Start autocompletion after 4 chars
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0
" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

syntax on
set autoindent

execute pathogen#infect()
syntax on
filetype plugin indent on

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
set t_vb=
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
nnoremap tc  :args *.c<CR>
nnoremap ts  :args *.js<CR>
nnoremap ti  :args Makefile include/*.h<CR>
nnoremap ta  :tab all<CR>

"Panes manipulation
nnoremap <S-j> <C-W><C-J>
nnoremap <S-k> <C-W><C-K>
nnoremap <S-l> <C-W><C-L>
nnoremap <S-h> <C-W><C-H>

"Reload
nnoremap rr	:edit<CR>
"Plugin for web
let g:closetag_filenames = "*.js,*.html,*.xhtml,*.phtml,*.php,*.jsx"

augroup templates
  au!
  autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END
"React skeleton
func! SubFileName()
  let filename = expand('%')
  let filename = substitute(filename, "\.js", "", "")
  %s/FILENAME/\=filename/g
endfunction

"Nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Skeleton
:command Component :0r ~/.vim/templates/skeleton/reactComponent.js | :silent call SubFileName()
set backspace=indent,eol,start
:set mouse=a

"Search file
if exists("$PROJECTDIR")
  set path=$PROJECTDIR/**
  set tags=$PROJECTDIR/tags
endif
