"Encoding standard
scriptencoding utf-8
set encoding=utf-8

"Set some feature
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

"Set Marker on file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")| exe "normal! g'\"" | endif

"Delete Trailing White Space
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()

"Tab manipulation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap tc  :args *.c<CR>
nnoremap ti  :args Makefile include/*.h<CR>
nnoremap ta  :tab all<CR>

"Panes manipulation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

