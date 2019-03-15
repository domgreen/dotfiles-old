set nocompatible          "not compatible with vi
filetype off              "required

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'myusuf3/numbers.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'rhysd/vim-grammarous'
call plug#end()

let mapleader=","
filetype plugin indent on "detect file types
let python_highlight_all=1
syntax on                 "add syntax highlighting
colorscheme molokai
let g:molokai_original = 1
set number                "turn on line numbers
set encoding=utf-8
set cursorline		  "easy to see what line your on
set rtp+=~/.fzf

" This is all about code folding
set foldmethod=indent     "enable folding
set foldlevel=99
nnoremap <space> za 
let g:SimpylFold_docstring_preview=1

"Use deoplete
let g:deoplete#enable_at_startup = 1

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

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


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

" Org mode
let g:org_agenda_files = ['~/org/index.org']
