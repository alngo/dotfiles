" Global
syntax on
filetype plugin indent on
setglobal mouse=a
setglobal autoread
setglobal autowrite
setglobal smartcase
setglobal incsearch
setglobal nocompatible
setglobal path=.,,
setglobal tags=./tags
setglobal encoding=utf-8
setglobal fileencoding=utf-8
set laststatus=2
set showtabline=2
set guioptions-=e

" Display
setglobal lazyredraw
setglobal display=lastline
setglobal scrolloff=2
setglobal cmdheight=2
set number
set hlsearch

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Editing
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/,*.class,*/target/*,.idea/
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico,*.snap,
set wildignore+=*.pdf,*.psd
set wildignore+=*.o,*.a,*.pyc,*.d
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*
set wildignore+=*/dist/*
set wildignore+=*/build/*
set wildignore+=*/tmp/*

setglobal textwidth=78
setglobal backspace=2
setglobal complete-=i
setglobal dictionary+=/usr/share/dict/words
setglobal infercase
setglobal showmatch
setglobal virtualedit=block
setglobal shiftround
setglobal autoindent
setglobal omnifunc=syntaxcomplete#Complete
setglobal completefunc=syntaxcomplete#Complete
set colorcolumn=80

" Custom
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype scss setlocal ts=2 sw=2 sts=2 expandtab

" Folding - Comment
setglobal foldenable
setglobal foldlevelstart=10
setglobal foldnestmax=10
if has('folding')
	setglobal foldmethod=marker
	setglobal foldopen+=jump
endif
setglobal commentstring=#\ %s
if !get(v:, 'vim_did_enter', !has('vim_starting'))
	setlocal commentstring<
endif
autocmd FileType c,cpp,cs,java,js        setlocal commentstring=//\ %s

" Information
setglobal confirm
setglobal showcmd
setglobal novisualbell

" Mapping
nnoremap Y y
inoremap <C-C> <Esc>`^

" Tab manipulation
nnoremap ’  :tabnext<CR>
nnoremap ”  :tabprev<CR>
nnoremap †  :tabedit<Space>
nnoremap ˇ  :tabedit<Space>**/*
nnoremap å  :tab all<CR>
nnoremap Ø  :e<Space>**/*

tnoremap ’  <C-w>:tabnext<CR>
tnoremap ”  <C-w>:tabprev<CR>
tnoremap †  <C-w>:tabedit<Space>
tnoremap ˇ  <C-w>:tabedit<Space>**/*
tnoremap å  <C-w>:tab all<CR>
tnoremap Ø  <C-w>:e<Space>**/*

" Pane manipulation
inoremap Ó <C-\><C-N><C-w>h
inoremap Ô <C-\><C-N><C-w>j
inoremap  <C-\><C-N><C-w>k
inoremap Ò <C-\><C-N><C-w>l

nnoremap Ó <C-w>h
nnoremap Ô <C-w>j
nnoremap  <C-w>k
nnoremap Ò <C-w>l

tnoremap Ó <C-w>h 
tnoremap Ô <C-w>j
tnoremap  <C-w>k
tnoremap Ò <C-w>l

" Line manipulation
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Buffer manipulation
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Pum manipulation
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

" quickfix list
nnoremap ∆ :cn<CR>
nnoremap ˚ :cp<CR>

" Wildmenu
setglobal history=200
setglobal wildmenu
setglobal wildmode=full
setglobal wildignore+=tags,.*pyc,*.o,*.d

" Function
"	Testscript
func! TestScript()
	if filereadable("testscript.sh")
		:!./testscript.sh > /tmp/$USER 2>&1
	endif
endfunc
autocmd BufWrite *.c :call TestScript()
autocmd BufWrite *.h :call TestScript()

"	Delete trailing whitespace
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()

"	highlighting search
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
" Search with *
vnoremap <silent> * :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy/<C-R><C-R>=substitute(
	\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>
	
"	Pair map
function! PairMap(open, close)
	return a:open . a:close . repeat("\<left>", len(a:close))
endfunc
inoremap <expr> ( PairMap('(', ')')
inoremap <expr> { PairMap('{', '}')
inoremap <expr> [ PairMap('[', ']')
inoremap <expr> " PairMap('"', '"')
inoremap <expr> ' PairMap("'", "'")
inoremap <expr> ` PairMap('`', '`')

" Plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-flagship'

Plug 'vim-scripts/L9'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/FuzzyFinder'
Plug 'vim-scripts/AutoTag'

Plug 'justinmk/vim-syntax-extra'
Plug 'pbondoer/vim-42header'

" JAVASCRIPT/TYPESCRIPT
Plug 'alvan/vim-closetag'
Plug 'gregsexton/matchtag'
Plug 'vim-syntastic/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()

" Netrw
let g:netrw_liststyle=3

" Flagship"
autocmd User Flags call Hoist("buffer", "fugitive#statusline")

" vim-fugitive
set diffopt+=vertical
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=94 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=89 gui=none guifg=bg guibg=Red

" JAVASCRIP/TYPESCRIPT

" Vim_jsx_pretty
let g:vim_jsx_pretty_highlight_close_tag = 1

" Prettier
let g:prettier#autoformat = 1
"autocmd BufWritePre *.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" Syntastic
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_exec = 'happiness'
let g:syntastic_javascript_standard_generic = 1

" CloseTag
let g:closetag_filenames = "*.js,*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx"

" Ale
let g:ale_set_highlights = 1 " Disable highligting
let g:ale_completion_enabled = 0
let g:ale_linter_aliases = {'typescriptreact': 'typescript'}
highlight ALEError ctermbg=94 cterm=underline
highlight ALEWarning ctermbg=95 cterm=underline
