set nocompatible          "not compatible with vi
filetype off              "required

" WINDOWS
" set the runtime path to include Vundle and initialize
" set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
" call vundle#begin('$HOME/vimfiles/bundle/')

" OSX & Ubuntu
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'ryanoasis/vim-devicons'
Plugin 'myusuf3/numbers.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/fzf.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required

let mapleader=","
filetype plugin indent on "detect file types
colorscheme molokai       "better colour scheme
let python_highlight_all=1
syntax on                 "add syntax highlighting
set number                "turn on line numbers
set encoding=utf-8
set cursorline		  "easy to see what line your on
set rtp+=~/.fzf

" This is all about code folding
set foldmethod=indent     "enable folding
set foldlevel=99
nnoremap <space> za 
let g:SimpylFold_docstring_preview=1

" YouCompleteMe updates
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Cool fonts
let g:airline_powerline_fonts=1
set backspace=indent,eol,start
set autowrite

" arrow keys disable
nnoremap <right> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <up> <nop>

vnoremap <right> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <up> <nop>

" NERDTree
" Open NERDTree as I open vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close NERDTree if its last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Allow NERDTree delete buffers
let NERDTreeAutoDeleteBuffer = 1

" Open NERDTree in the directory of the current file (or /home if no file is open)
function! NERDTreeToggleFind()
"  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
"    execute ":NERDTreeClose"
"  else
    execute ":NERDTreeFind"
"  endif
endfunction

nnoremap <leader>c :call NERDTreeToggleFind()<cr>

" rust
set hidden
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" go stuff
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

let g:go_fmt_command = "goimports"
function! Imp()
	execute "!"."go fmt"." ".bufname("%").">/dev/null 2>&1" | redraw!
endfunction

augroup dom
	au!
	au BufWrite *.go silent! :call Imp()
augroup END

" FZF nicer search
nnoremap <leader>p :Files<CR>
nnoremap <C-n> :Buffers<CR>
" Preview files when calling File.
command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <leader>p :Files!<CR>
" Like File, but with PWD.
nnoremap <leader>P :call fzf#vim#files(expand("%:p:h"), fzf#vim#with_preview(), 1)<CR>
