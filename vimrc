set nocompatible

set ts=4
set sw=4
set sts=4
set et
set background=dark

set cin

set hlsearch
set incsearch

set mouse=a

let g:molokai_original = 1
color molokai
syntax enable

" Neovim features
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

filetype off                  " required

" set the runtime path to include Vundle and initialize
" TODO migrate to vim-plug
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'
Plugin 'zah/nimrod.vim'
" TODO migrate to 'benekastah/neomake'
" Plugin 'scrooloose/syntastic'
Plugin 'benekastah/neomake'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'wting/rust.vim'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'dln/avro-vim'

filetype plugin indent on     " required

" Language specific
let g:neocomplcache_enable_at_startup = 1
set completeopt+=longest 
let g:neocomplcache_enable_auto_select = 1 
au BufEnter * inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "<TAB>"
au BufEnter * inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "<TAB>"
au BufRead,BufNewFile *.avdl setlocal filetype=avro-idl

autocmd BufRead,BufNewFile *.md set filetype=markdown

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Keep all temporary and backup files in ~/.vim
set viminfo='10,\"100,:20,%,n~/.vim/viminfo
set backup
set backupdir=~/.vim/backup " Backup
set directory=~/.vim/tmp " Swap
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo " Undo
    set undolevels=100 " Maximum number of changes that can be undone
    set undoreload=1000 " Maximum number lines to save for undo on a buffer reload
endif

"----------------------
" Go commands
"let g:go_fmt_command = "goimports"
"let g:go_fmt_fail_silently = 1
let g:go_fmt_options = "-s"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_term_enabled = 1
let g:go_term_mode = "split"

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_javascript_checkers = ['jsxhint']
"let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>gc <Plug>(go-callers)
au FileType go nmap <leader>gr <Plug>(go-referrers)
au FileType go TagbarOpen
au FileType go let g:neocomplcache_ctags_program = "gotags"
au BufWritePost *.go GoInstall

" Quickfix window should go to the bottom
au FileType qf wincmd J


" Airline

"---------------------------------------------------------------------------
"
"  title string for screen
"
if &term == "screen" || &term == "screen-bce"
  set t_ts=k
  set t_fs=\
endif
if &term == "screen" || &term == "screen-bce" || &term == "xterm"
  set title
endif

function! SetTitle()
	let temptitle = &modified > 0 ? "+" : " "
	let &titlestring = "vim" . temptitle . expand("%:t") . ""
endfunction

call SetTitle()

augroup titlebar
	autocmd!
	autocmd BufEnter * call SetTitle()
	autocmd BufWritePost * call SetTitle()
	"autocmd CursorMoved * call SetTitle()
	"autocmd CursorMovedI * call SetTitle()
	autocmd InsertLeave * call SetTitle()
augroup END
"---------------------------------------------------------------------------

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  silent %!xmllint --format --nowarning -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

fun! JumpToDef()
    if exists("*GotoDefinition_" . &filetype)
        call GotoDefinition_{&filetype}()
    else
        exe "norm! \<C-]>"
    endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i
