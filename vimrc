"===================
"===== Plugins =====
"===================

" Needs to be called before any plugin logic
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe'
Plug 'fatih/vim-go'
Plug 'https://github.com/ctrlpvim/ctrlp.vihttps://github.com/ctrlpvim/ctrlp.vimm'
call plug#end()

"===================
"===== Options =====
"===================
" syntax highlighting
syntax enable
syntax on

" detect when a file is changed
set autoread

" Spaces and Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" Allow backspace
set backspace=2

" set autoindent
set wrap
filetype indent plugin on

" UI Config
set number
set relativenumber
set mouse=a
set laststatus=2
set lazyredraw
set showmatch

" Shows the last command entered
set showcmd

" Highlight current line
set cursorline

" Visual autocomplete
set wildmenu

" Highlight matching [{()}]
set showmatch

" Searching
set incsearch
set hlsearch
set smartcase
set ignorecase
nnoremap <silent><Space> :nohlsearch<CR>

" Keeps X lines offset while scrolling the file
set scrolloff=2

" also uses the X clipboard when yanking text
set clipboard=unnamed

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent

"========================
"===== key bindings =====
"========================
" leader as space bar is dope
"let mapleader="\<Space>"
map  <Space> <leader>

" To compile C++ code
" map <F8> :!g++ % && ./a.out <CR>
nnoremap <silent> <f7> :make %<<cr>
nnoremap <silent> <F8> :w<CR> :!clear; make<CR> :!./%<<CR>

"==========================
"===== plugin options =====
"==========================
"====== syntastic =====
nnoremap <leader>s :SyntasticCheck<CR>
nnoremap <leader>n :lnext<CR>
nnoremap <leader>b :lprevious<CR>
let g:syntastic_c_check_header = 1
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_pylint_exec = 'flake8'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_flake8_args = "--ignore=E501"

"===== NERDTree =====
" open and close nerdtree
noremap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1

" Pathogen Settings
" Plugin
" execute pathogen#infect()

" Enable filetype plugins
" filetype plugin on
"
"==========================
"======= Functions! =======
"==========================
" Automagically insert template for new header files
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  let filename = expand("%:t")
  execute "normal! i/* " . filename . " */\n"
  execute "normal! o#ifndef " . gatename
  execute "normal! o#define " . gatename . "\n"
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
