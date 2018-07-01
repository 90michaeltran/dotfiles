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
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/tomtom/tcomment_vim'
call plug#end()

"===================
"===== Options =====
"===================
"Automatic reload of vimrc
autocmd! bufwritepost .vmrc source %

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
set colorcolumn=80
set listchars=tab:<-,trail:~
set showcmd
" set visualbell
set nostartofline
highlight ColorColumn ctermbg=233

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
nnoremap <leader><Space> :noh<CR>

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

" Alphapetize selection
vnoremap <Leader>a :sort<CR>

" Easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" Save and run python
nnoremap <leader>b :w !python %<CR>

" Easier navigating between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new panes right and below
set splitbelow
set splitright

" Disable swap files
set noswapfile

" Keep Undo history even after closing file
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

"========================
"===== key bindings =====
"========================
" leader as space bar is dope
"let mapleader="\<Space>"
map  <Space> <leader>

" To compile C++ code
" map <F8> :!g++ % && ./a.out <CR>
nnoremap <silent> <f7> :make %<<cr>
nnoremap <silent> <F8> :w<CR> :!clear; make<CR> :!./run<CR>

"==========================
"===== plugin options =====
"==========================
"====== syntastic =====
nnoremap <leader>s :SyntasticCheck<CR>
nnoremap <leader>n :lnext<CR>
" nnoremap <leader>b :lprevious<CR>
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

function! Makefile()
    " execute "normal! i# Declaration of variables"
    execute "normal! iCC = g++"
    execute "normal! oCC_FLAGS = -w\n"

    " execute "normal! o# File names"
    execute "normal! oEXEC = run"
    execute "normal! oSOURCES = $(wildcard *.cpp)"
    execute "normal! oOBJECTS= $(SOURCES:.cpp=.o)\n"

    execute "normal! oall: $(EXEC)\n"

    " execute "normal! o#Main target"
    execute "normal! o$(EXEC): $(OBJECTS)"
    execute "normal! o  $(CC) $(OBJECTS) -o $(EXEC)\n"

    " execute "normal! o#To obtain object files"
    execute "normal! o%.o: %.cpp"
    execute "normal! o  $(CC) -c $<\n"

    " execute "normal! o#To remove generated files"
    execute "normal! oclean:"
    execute "normal! o  rm -f $(EXEC) $(OBJECTS)"
    normal! kk
endfunction
noremap <leader>m :call Makefile()<CR>

"
" "# Declaration of variables
" "CC = g++
" "CC_FLAGS = -w
" " 
" "# File names
" "EXEC = run
" "SOURCES = $(wildcard *.cpp)
" "OBJECTS = $(SOURCES:.cpp=.o)
" " 
" "# Main target
" "$(EXEC): $(OBJECTS)
" "	$(CC) $(OBJECTS) -o $(EXEC)
" " 
" "# To obtain object files
" "%.o: %.cpp
" "	$(CC) -c $(CC_FLAGS) $< -o $@
" " 
" "# To remove generated files
" "clean:
" "	rm -f $(EXEC) $(OBJECTS)
