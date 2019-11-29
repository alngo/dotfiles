"============================================================================"
" GLOBAL SETTINGS
"============================================================================"
syntax on
colorscheme desert
filetype plugin indent on
setglobal mouse=a
setglobal autoread
setglobal autowrite
setglobal smartcase
setglobal incsearch
setglobal nocompatible
setglobal path=.,,
setglobal tags=./tags
setglobal fileencoding=utf-8
setglobal encoding=utf-8
set laststatus=2
set showtabline=2
set guioptions-=e

" DISPLAY
"============================================================================"
setglobal lazyredraw
setglobal display=lastline
setglobal scrolloff=2
setglobal cmdheight=1
set number
set hlsearch

" CURSOR SHAPE
"============================================================================"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" WILD
"============================================================================"
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/,*.class,*/target/*,.idea/
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico,*.snap,
set wildignore+=*.pdf,*.psd
set wildignore+=*.o,*.a,*.pyc,*.d
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*
set wildignore+=*/dist/*
set wildignore+=*/build/*
set wildignore+=*/tmp/*
set wildignore+=tags,.*pyc,*.o,*.d,*.swp
setglobal wildmenu
setglobal wildmode=full

" EDITING SETTINGS
"============================================================================"
setglobal history=200
setglobal backspace=2
setglobal complete-=i
setglobal dictionary+=/usr/share/dict/words
setglobal infercase
setglobal showmatch
setglobal virtualedit=block
setglobal shiftround
setglobal autoindent
set colorcolumn=80

" TABULATIONS WIDTH                                                          "
"============================================================================"
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype scss setlocal ts=2 sw=2 sts=2 expandtab

" FOLDING                                                                    "
"============================================================================"
setglobal foldenable
setglobal foldlevelstart=10
setglobal foldnestmax=10
setglobal foldmethod=marker
setglobal foldopen+=jump
setglobal commentstring=#\ %s
if !get(v:, 'vim_did_enter', !has('vim_starting'))
	setlocal commentstring<
endif
autocmd FileType c,cpp,cs,java,js        setlocal commentstring=//\ %s

" INFORMATION                                                                "
"============================================================================"
setglobal confirm
setglobal showcmd
setglobal novisualbell

"============================================================================"
" MAPPING                                                                    "
"============================================================================"

" MISC
"============================================================================"
nnoremap Y y$
nnoremap U <C-r>

autocmd FileType Help noremap <buffer> q :q<cr>

" EDITION
"============================================================================"
nnoremap <leader>t 	:tabedit **/*
nnoremap <leader>e 	:e **/*
tnoremap <leader>t 	<C-w>:tabedit **/*
tnoremap <leader>e 	<C-w>:e **/*

" TABS NAVIGATION
"============================================================================"
nnoremap <leader>[ 	:tabprevious<CR>
nnoremap <leader>] 	:tabnext<CR>
tnoremap <leader>[ 	<C-w>:tabprevious<CR>
tnoremap <leader>] 	<C-w>:tabnext<CR>

" PANES NAVIGATION                                                           "
"============================================================================"
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

tnoremap <C-h> <C-w>h 
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

" BUFFERS NAVIGATION                                                         
"============================================================================"
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" QUICKFIX NAVIGATION
"============================================================================"
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>

" PUM MAPPING
"============================================================================"
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
inoremap <silent><expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <silent><expr> <C-[> pumvisible() ? "\<C-[>" : "\<C-[>"

"============================================================================"
" HELPER FUNCTION
"============================================================================"

" Quickfix filename into args for argdo
"============================================================================"
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" Deleter trailing spave on write
"============================================================================"
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()

" Deleter trailing spave on write
"============================================================================"
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

" AUTOSEARCH SEARCH WITH *
"============================================================================"
vnoremap <silent> * :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy/<C-R><C-R>=substitute(
	\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>
	
"============================================================================"
" PLUGINS
"============================================================================"

" PLUG
"============================================================================"
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-flagship'

Plug 'justinmk/vim-syntax-extra'
Plug 'pbondoer/vim-42header'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NEERDTREE
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" FUZZY SEARCH
Plug 'ctrlpvim/ctrlp.vim'

" JAVASCRIPT/TYPESCRIPT
Plug 'alvan/vim-closetag'
Plug 'gregsexton/matchtag'
Plug 'vim-syntastic/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'

Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/yajs.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" RUST
Plug 'rust-lang/rust.vim'

" Experimental :3
Plug 'alngo/tissue-vim'

call plug#end()

"============================================================================"
" PLUGINS SETTINGS
"============================================================================"

" Flagship"
autocmd User Flags call Hoist("buffer", "fugitive#statusline")

" vim-fugitive
set diffopt+=vertical
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=94 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=89 gui=none guifg=bg guibg=Red

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules$']

" Ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Coc.nvim
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" JAVASCRIP/TYPESCRIPT
"============================================================================"
" Syntastic
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_exec = 'happiness'
let g:syntastic_javascript_standard_generic = 1

" CloseTag
let g:closetag_filenames = "*.js,*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx"
