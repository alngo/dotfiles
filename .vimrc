"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Encoding standard
set encoding=utf-8
set mouse=a
set backspace=indent,eol,start
set path=.,$PWD/**,,**/**
set autoindent
set autoread
set number
set showmatch
set relativenumber
set noerrorbells
set novisualbell
set tm=500
set nu
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set hlsearch
syntax on
color despacio

" calculator
ino <C-A> <C-O>yiW<End><C-O>viWd<End><C-R>=<C-R>0<CR>

" Custom Command
command! -nargs=+ R call R(<f-args>)
command! -nargs=+ Sub call Sub(<f-args>)

function! Sub( ... )
  if a:0 != 2
    echo "Need two arguments"
    return
  endif
  execute "%substitute/" . a:1 . "/" . a:2 . "/g"
endfunction

function! R( ... )
    if a:0 != 2
        echo "Need two arguments"
        return
    endif
    execute "0r ~/.vim/templates/" . a:1
    execute "%substitute/\$SUB/" . a:2 . "/g"
endfunction

" Set Marker on file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")| exe "normal! g'\"" | endif

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
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

inoremap "      ""<Left>
inoremap "<CR>  "<CR>"<Esc>O
inoremap ""     "
inoremap ""     ""

inoremap '      ''<Left>
inoremap '<CR>  '<CR>'<Esc>O
inoremap ''     '
inoremap ''     ''

inoremap `      ``<Left>
inoremap `<CR>  `<CR>`<Esc>O
inoremap ``     `
inoremap ``     ``

" Tab manipulation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap ttl :tabedit<Space>**/*
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap ta  :tab all<CR>

" AutoQuit Insert Mode
imap jk  <Esc>

" Quickfix list
nnoremap cn   :cn<CR>
nnoremap cp   :cp<CR>
nnoremap cc   :ccl<CR>
nnoremap co   :copen<CR>

" Line manipulation
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Panes manipulation
nnoremap <S-j> <C-W><C-J>
nnoremap <S-k> <C-W><C-K>
nnoremap <S-l> <C-W><C-L>
nnoremap <S-h> <C-W><C-H>

"Cursor Shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" CloseTag
let g:closetag_filenames = "*.js,*.html,*.xhtml,*.phtml,*.php,*.jsx"

" Show file options above the command line
set wildmenu

" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*

" netrw config
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
	if exists("t:expl_buf_num")
		let expl_win_num = bufwinnr(t:expl_buf_num)
		if expl_win_num != -1
			let cur_win_nr = winnr()
			exec expl_win_num . 'wincmd w'
			close
			exec cur_win_nr . 'wincmd w'
			unlet t:expl_buf_num
		else
			unlet t:expl_buf_num
		endif
	else
		exec '1wincmd w'
		Vexplore
		let t:expl_buf_num = bufnr("%")
	endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>
let g:netrw_banner = 0
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 15
augroup ProjectDrawer
	autocmd!
	autocmd VimEnter * :Vexplore
augroup END

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

" Console.log Configuration
" Console log from insert mode; Puts focus inside parentheses
imap cll console.log();<Esc>==f(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p

" Pathogen()
execute pathogen#infect()

" Plug()
call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-syntastic/syntastic'
Plug 'metakirby5/codi.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'neomake/neomake', { 'on': 'Neomake' }
Plug 'ludovicchabant/vim-gutentags'

if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
	Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
endif

call plug#end()

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})

" deoplete tab completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:deoplete#sources#tss#javascript_support = 1

autocmd! BufWritePost * Neomake
let g:neomake_warning_sign = {
			\ 'text': '?',
			\ 'texthl': 'WarningMsg',
			\ }

let g:neomake_error_sign = {
			\ 'text': 'X',
			\ 'texthl': 'ErrorMsg',
			\ }
