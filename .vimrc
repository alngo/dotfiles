"=============================================================================
" Vim-Plug core
"=============================================================================
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"
  autocmd VimEnter * PlugInstall
endif

"============================================================================"
" PLUGS
"============================================================================"
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-obsession'

" Enhanced syntax for c
Plug 'justinmk/vim-syntax-extra'

" Tagbar
Plug 'majutsushi/tagbar'

" CONQUEROR OF COMPLETION
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colorscheme
Plug 'alessandroyorba/despacio'

call plug#end()

"============================================================================"
" Basic Setup
"============================================================================"
" plugin
filetype plugin indent on

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" wildmenu
set wildmenu
set wildmode=longest:full,full
set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk,.o,.d,.out

" Fix backspace indent
set backspace=indent,eol,start

" Tabs
set tabstop=4
set shiftwidth=4
set noexpandtab

" Hidden buffers
set hidden

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Mouse Settings
let no_buffers_menu=1
set mouse=a
set mousemodel=popup

" Misc
set confirm
set noshowcmd
set novisualbell

"============================================================================"
" Visual Settings
"============================================================================"
silent! colorscheme despacio
syntax on
set number

" Cursor settings
let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

" Status bar
" set laststatus=2

" Color column
set colorcolumn=80

" Statusline
" set statusline=%F%m%r%h%w%=(%Y)\ (line\ %l\/%L,\ col\ %c)

"=============================================================================
"" Abbreviations
"=============================================================================
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qa! qa!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"=============================================================================
"" Mappings
"=============================================================================
" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Misc
nnoremap Y y$
nnoremap U <C-r>

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

" Buffer nav
inoremap <leader>q <C-w>:bp<CR>
inoremap <leader>w <C-w>:bn<CR>
tnoremap <leader>q <C-w>:bp<CR>
tnoremap <leader>w <C-w>:bn<CR>
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

" Tabs nav
nnoremap <leader>[ 	:tabprevious<CR>
nnoremap <leader>] 	:tabnext<CR>

" Quickfix nav
nnoremap <leader>n :cnext
nnoremap <leader>p :cprevious

" Edition
nnoremap <leader>e :e **/*
nnoremap <leader>t :tabnew **/*

" Panes nav
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Pane resize
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Pum mapping
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
inoremap <silent><expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <silent><expr> <C-[> pumvisible() ? "\<C-[>" : "\<C-[>"

"=============================================================================
" Autocommand
"=============================================================================
" Remove trailing space on save
autocmd BufWritePre * %s/\s\+$//e

" vim-comment
autocmd FileType c setlocal commentstring=//\ %s

"=============================================================================
" Plugs settings
"=============================================================================
" vim-fugitive
set diffopt=vertical
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=94 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=89 gui=none guifg=bg guibg=Red


" Tagbar
nnoremap <silent> <C-t> :TagbarToggle<CR>

" Coc.nvim
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <silent> <CR> :nohl<CR>

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
