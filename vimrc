set nocompatible

set ts=4
set sw=4
set sts=4
set et
set encoding=utf8
set background=dark

set cin

set hlsearch
set incsearch

set mouse=a

set nomodeline

set number relativenumber

" Text highlight overrides
set list listchars=tab:\›\ ,trail:-,extends:>,precedes:<,eol:¬,space:·
highlight WhitespaceBeginning ctermfg=236
highlight WhitespaceMiddle ctermfg=232
match WhitespaceMiddle /\(\s\+\|\n\)/
2match WhitespaceBeginning /^\s\+/
au BufReadPost,BufNewFile,ColorScheme * match WhitespaceMiddle /\(\s\+\|\n\)/
                                \ | 2match WhitespaceBeginning /^\s\+/
                                \ | highlight WhitespaceBeginning ctermfg=236
                                \ | highlight WhitespaceMiddle ctermfg=232

" Neovim features
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

filetype off                  " required

" Load plugins
" Use :PlugInstall the first time
call plug#begin('~/.local/share/nvim/plugged')

" let Vundle manage Vundle, required
Plug 'gmarik/vundle'
Plug 'zah/nimrod.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'wting/rust.vim'
Plug 'fatih/vim-go'
Plug 'bling/vim-airline'
Plug 'dln/avro-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'wokalski/autocomplete-flow'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'cakebaker/scss-syntax.vim'
" Typescript
" FIXME: this seems to interfere with languageclient
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Various language highlighting
Plug 'sheerun/vim-polyglot'
Plug 'wellle/targets.vim'

call plug#end()

filetype plugin indent on     " required
let g:molokai_original = 1
color molokai
syntax enable

" Language specific
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

au BufRead,BufNewFile *.avdl setlocal filetype=avro-idl
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.iced set filetype=coffee
au BufRead,BufNewFile *.ts set filetype=typescript ts=2 sw=2
au BufRead,BufNewFile *.tsx set filetype=typescript.tsx ts=2 sw=2

" select pasted text
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
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_term_enabled = 1
let g:go_term_mode = "split"
let g:go_def_mode = "gopls"

let g:airline_powerline_fonts = 1

let g:LanguageClient_serverCommands = {
\ 'javascript': ['javascript-typescript-stdio'],
\ 'javascript.jsx': ['javascript-typescript-stdio', '--jsx'],
\ 'typescript': ['javascript-typescript-stdio'],
\ 'typescript.tsx': ['javascript-typescript-stdio', '--jsx']
\ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = 'location-list'
let g:LanguageClient_diagnosticsList = 'Location'


" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'scss': ['prettier', 'stylelint'],
\   'typescript': ['eslint', 'prettier'],
\   'typescript.jsx': ['eslint', 'prettier'],
\}
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'scss': ['stylelint'],
\   'typescript': ['eslint'],
\   'typescript.jsx': ['eslint'],
\}
let g:ale_fix_on_save = 1

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
au FileType go let g:neocomplcache_ctags_program = "gotags"

" Quickfix window should go to the bottom
au FileType qf wincmd J

au FileType javascript setl ts=2 sw=2 et
au FileType html setl ts=2 sw=2 et
au FileType css setl ts=2 sw=2 et
au FileType sass setl ts=2 sw=2 et
au FileType scss setl ts=2 sw=2 et
au FileType eruby setl ts=2 sw=2 et

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

fun! DoPrettyXML()
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

let g:S = 0
function! Sum(number)
    let g:S = g:S + a:number
    return a:number
endfunction

" Auto mkdir on save
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

function! ToggleVerbose()
  if !&verbose
    set verbosefile=~/.log/vim/verbose.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunction

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i
