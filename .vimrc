" Vim

if !&compatible
  set nocompatible
endif

"Initialize------------------------------------------------------------
set encoding=utf8
set browsedir=buffer

if !isdirectory('~/.vim/backup')
  call mkdir('~/.vim/backup','p')
endif

set backupdir=~/.vim/backup
set directory=~/.vim/backup

augroup MyAutoCmd
  autocmd!
augroup END

"Dein Scripts----------------------------------------------------------
"プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let g:rc_dir    = expand('~/.vim/config')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"Dein Scripts end-------------------------------------------------------

" Required:
syntax on
"execute pathogen#infect
filetype plugin indent on

set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set incsearch
set number

set expandtab
set shiftwidth=2
set smarttab
set smartindent
set tabstop=4

set whichwrap=b,s,h,l,<,>,[,]
set nowrapscan


function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? ''._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
""" lightline.vim setting end -------------------------------

""" unite.vim setting
let g:unite_enable_start_insert=1
noremap fo :UniteWithBufferDir -buffer-name=files file file/new<CR>
noremap fy :Unite history/yank<CR>
noremap fp :Unite file_mru buffer<CR>

""" filetype mapping
au BufRead,BufNewFile *.md set filetype=markdown

