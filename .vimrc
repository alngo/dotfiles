filetype indent plugin on
syntax on
color despacio
" Settings
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set hidden
set wildmenu
set showcmd
set sol
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set ruler
set laststatus=1
set confirm
set noerrorbells
set novisualbell
set mouse=a
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set path+=**                                                                    
" Statusline
set statusline =
set statusline +=[%n]
set statusline +=%f\ %h%m%r%w
set statusline +=%y                                                  
set statusline +=\ %{fugitive#statusline()}
set statusline +=\ %{strftime(\"[%d/%m/%y\ %T]\",getftime(expand(\"%:p\")))} 
set statusline +=%=%-10L
set statusline +=%=%-14.(%l,%c%V%)\ %P
" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico,*.snap
set wildignore+=*.pdf,*.psd
set wildignore+=**/node_modules/*,bower_components/*,**/node_modules/**
set wildignore+=**/node_modules/
"Cursor Shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" AUTOCMD 
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")| exe "normal! g'\"" | endif
" for htlm/css/js files, 2 spaces
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype scss setlocal ts=2 sw=2 sts=2 expandtab
" Buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" Tab manipulation
nnoremap ’  :tabnext<CR>
nnoremap ”  :tabprev<CR>
nnoremap †  :tabedit<Space>
nnoremap ˇ  :tabedit<Space>**/*
nnoremap å  :tab all<CR>
nnoremap Ø	:e<Space>**/*
nnoremap ø  :e<Space>
" Pane manipulation
inoremap Ó <C-\><C-N><C-w>h
inoremap Ô <C-\><C-N><C-w>j
inoremap  <C-\><C-N><C-w>k
inoremap Ò <C-\><C-N><C-w>l
nnoremap Ó <C-w>h
nnoremap Ô <C-w>j
nnoremap  <C-w>k
nnoremap Ò <C-w>l
" Argmuments
nnoremap Å :args<Space>**/*
" Line manipulation
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" quickfix list
nnoremap ∆ :cn<CR>
nnoremap ˚ :cp<CR>
" Delete Trailing White Space
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
" Bracket
function! ConditionalPairMap(open, close)
	let line = getline('.')
	let col = col('.')
	if col < col('$') || stridx(line, a:close, col + 1) != -1
		return a:open
	else
		return a:open . a:close . repeat("\<left>", len(a:close))
	endif
endf
inoremap <expr> ( ConditionalPairMap('(', ')')
inoremap <expr> { ConditionalPairMap('{', '}')
inoremap <expr> [ ConditionalPairMap('[', ']')
inoremap <expr> " ConditionalPairMap('"', '"')
inoremap <expr> ' ConditionalPairMap("'", "'")
inoremap <expr> ` ConditionalPairMap('`', '`')
" Highlight Configuration
let g:highlighting = 0
function! Highlighting()
	if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
		let g:highlighting = 0
		return ":silent nohlsearch\<CR>"
	endif
	let @/ = '\<'.expand('<cword>').'\>'
	let g:highlighting = 1
	return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()
" Search Configuration
vnoremap <silent> * :<C-U>
			\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
			\gvy/<C-R><C-R>=substitute(
			\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
			\gV:call setreg('"', old_reg, old_regtype)<CR>
" Extra
imap cll console.log();<Esc>==f(a
vmap cll yocll<Esc>p
nmap cll yiwocll<Esc>p
nnoremap Y y$
" Plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-syntastic/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'gregsexton/matchtag'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
if has('nvim')
	Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'zxqfl/tabnine-vim'
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()
" ale color
let g:ale_set_highlights = 1 " Disable highligting
highlight ALEError ctermbg=94 cterm=underline 
highlight ALEWarning ctermbg=95 cterm=underline
" Tagbar
nnoremap <S-t> :TagbarToggle<CR>
" Python-mode
let g:pymode_python = 'python3'
" TabNine
call deoplete#custom#var('tabnine', {
			\ 'line_limit': 500,
			\ 'max_num_results': 20,
			\ })
" Deoplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "<Tab>"
let g:deoplete#enable_at_startup = 1
let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
" Mac alt mapping
tnoremap Ó <C-\><C-N><C-w>h 
tnoremap Ô <C-\><C-N><C-w>j
tnoremap  <C-\><C-N><C-w>k
tnoremap Ò <C-\><C-N><C-w>l
" vim-fugitive
let mapleader = ' '
set diffopt+=vertical
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=94 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=89 gui=none guifg=bg guibg=Red
" Syntastic
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_exec = 'happiness'
let g:syntastic_javascript_standard_generic = 1
" CloseTag
let g:closetag_filenames = "*.js,*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx"
