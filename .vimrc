syntax on
set autoindent

execute pathogen#infect()
syntax on
filetype plugin indent on

color despacio
set nu

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
nnoremap ti  :args Makefile include/*.h<CR>
nnoremap ta  :tab all<CR>

"Panes manipulation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

