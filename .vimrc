" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-surround' 
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim'
Plug 'tomasiser/vim-code-dark'
Plug 'leafgarland/typescript-vim'
"Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'alaviss/nim.nvim'
"Plug 'prabirshrestha/asyncomplete.vim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'mattn/emmet-vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'vimwiki/vimwiki'
Plug 'peterhoeg/vim-qml'
" Taskwiki
Plug 'tbabej/taskwiki'
Plug 'majutsushi/tagbar'
Plug 'blindFS/vim-taskwarrior'
Plug 'vim-scripts/AnsiEsc.vim'
" FZF
Plug 'junegunn/fzf',{ 'do':{ -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Fish files
Plug 'dag/vim-fish'

"Plug 'bling/vim-bufferline'
call plug#end()
" colorscheme
"
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airlne_theme = 'codedark'
let g:user_element_leader_key = ','
" for emmet expanding
nmap , <C-Y>
let mapleader = " "
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set bg=dark
" NerdTree Config
"
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusLine = ''

" Close vim if nerdtree is the only thing running

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
"
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
"nnoremap <C-J> <C-w><C-w>

" File search ctrl-p
noremap <C-p> :GFiles<CR> 

" Goto code Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Code completion using TAB
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Trigger code suggestions
inoremap <silent><expr> <C-space> coc#refresh()

" Use enter<cr> to accept completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" use escape to exit terminal insert mode
tnoremap <Esc> <C-\><C-n>

" set location to store backup files
set backupdir=~/.vimbackups

" Dealing with splits
" set split location
set splitbelow
set splitright

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Close split/window
nnoremap <C-C> <C-W><C-C>
" Buffer navigation
map <A-h> :bprev<CR>
map <A-l> :bnext<CR>

" Autoclose braces
inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>]<Esc>O

" Vimwiki
let g:vimwiki_list = [{"path": "~/vimwiki/", "syntax": "markdown", "ext": ".md"}]
let g:vimwiki_ext2syntax = {".md" : "markdown",".markdown":"markdown"}

" Spellcheck
set spelllang=en_us

" powerline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"let g:airline_symbols.maxlinenr = ''

" Nim completion
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'nim',
    \ 'whitelist': ['nim'],
    \ 'completor': {opt, ctx -> nim#suggest#sug#GetAllCandidates({start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates)})}
    \ })

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

if !has("nvim")
" Get the defaults that most users want.
 source $VIMRUNTIME/defaults.vim
endif

" Code folding
set nofoldenable

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


