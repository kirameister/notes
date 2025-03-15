"""{{{ dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/akira_kakinohana/.vim/dein/repos/github.com/Shougo/dein.vim

"if dein#load_state('/home/akira_kakinohana/.vim/dein_cache')
"call dein#begin('/home/akira_kakinohana/.vim/dein')
"call dein#add('Shougo/dein.vim')
"
"" Add or remove your plugins here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
""call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
"call dein#add('Shougo/vimshell')
"call dein#add('Shougo/neocomplcache')
""call dein#add('Shougo/neomru.vim')
"call dein#add('Shougo/unite.vim')
"call dein#add('Shougo/vimfiler')
"" Use VimFiler as defult explorer
"let g:vimfiler_as_default_explorer=1
"call dein#add('tpope/vim-fugitive')
"call dein#add('gregsexton/gitv')
"call dein#add('junegunn/vim-easy-align')
"call dein#add('plasticboy/vim-markdown')
"call dein#add('kannokanno/previm')
""call dein#add('tyru/open-browser.vim')
"call dein#add('terryma/vim-expand-region')
"
"call dein#end()
"endif
" Required:
filetype plugin indent on
syntax enable

"" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
"}}}


"""{{{ Editing Settings..

set fileencoding=utf-8  " Use UTF-8 by default.
set tabpagemax=20       " Max number of opened tab pages.
set shiftround          " round it by shiftwidth when indenting with '<' or '>'
set infercase           " case-insensitive in auto-completion.
set hidden              " Hide buffer instead of close, to retain Undo history.
set switchbuf=useopen   " Open already-opened buffer, instead of open it anew.
set history=9999        " set the command history size to something big

" Move naturally by j and k even within wrapped lines.
nnoremap j gj
nnoremap k gk

" Start entering the vim command even with the semi-colon
nnoremap ; : 

" I prefer using the tabs..
set autoindent
"set noexpandtab
"set tabstop=4
"" If you like using tab..
set expandtab
set tabstop=4
set shiftwidth=4

" Disalbe both Swap and Backup files.
set nowritebackup
set nobackup
set noswapfile
" If you'd like to use Backup and/or Swap files, collect them in one place.
"set backup
"set swapfile
"set backupdir=~/.vim/backup
"set directory=~/.vim/swap


" 'v' twice to select until EOL
vnoremap v $h

" Disable screen bell.
set t_vb=
set novisualbell

" Increment/Decrement by decimal by C^a and C^x
set nrformats=

" Let the backspace delete everything.
set backspace=indent,eol,start

" Type 'jj' during the Input mode to enter normal mode.
inoremap jj <Esc>
" Emacs-like key-bindings during the Input mode.
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" Add '<' and '>' to matching pair.
set matchpairs& matchpairs+=<:>
" Jump to matching pair by Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Move along Windows by Ctrl + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use OS's clipboard.
set clipboard=unnamed,autoselect
" Use ClipBoard as default register, which is useful when you're working in client machine.
if has('unnamedplus')
        set clipboard& clipboard+=unnamedplus,unnamed
else
        set clipboard& clipboard+=unnamed
endif

" Undo even after exiting Vim
if has('persistent_undo')
        set undofile
        set undodir=./.vimundo,~/.vim/undo
endif
" Save as super user by w!! (available only in such an env)
cmap w!! w !sudo tee > /dev/null %

" Enable modeline (an individual setting for each file).
set modeline

" Toggle various settings bt T + ?
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]n :setl number!<CR>:setl number?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" Assign comma to leader
"let mapleader=","
"let mapleader="\<Space>"
"nnoremap <Leader>w :w<CR>
"nnoremap <Leader>o :e ./<CR>
"nmap <Leader><Leader> V
"vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)


"}}}


"""{{{ Search Settings..
set ignorecase
set smartcase
set incsearch
set hlsearch

" Type ESC twice to remove search highlights.
nnoremap <ESC><ESC> :nohlsearch<CR>

" Let the matched word be on middle of the screen after jump.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" You can also include '/' or '?' in search term as is.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" Search the word that cursor is on by '*'.
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

"}}}


""{{{ Tab and Pane Settings..
" Anywhere SID.
function! s:SID_PREFIX()
        return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
        let s = ''
        for i in range(1, tabpagenr('$'))
          let bufnrs = tabpagebuflist(i)
          let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
          let no = i  " display 0-origin tabpagenr.
          let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
          let title = fnamemodify(bufname(bufnr), ':t')
          if i != tabpagenr()
        let title = strpart(title,0,10) " set max lenth of title to same width space
          "else
          "  let title = pathshorten(fnamemodify(bufname(bufnr), ':p')) " it turned out having path information wasn't too useful..
      endif
          let title = '[' . title . ']'
          let s .= '%'.i.'T'
          let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
          let s .= no . ':' . title
          let s .= mod
          let s .= '%#TabLineFill# '
        endfor
        let s .= '%#TabLineFill#%T%=%#TabLine#'
        return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " Always show tabline.

" The prefix key.
nnoremap        [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
" 't1' to jump to left-most tab, 't2' to jump 2nd left tab..
for n in range(1, 9)
        execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc : Create new tab on the right.
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx : CLose the tab.
map <silent> [Tag]x :tabclose<CR>
" tn : Next tab.
map <silent> [Tag]n :tabnext<CR>
" tp : Prev tab.
map <silent> [Tag]p :tabprevious<CR>

" Mappings for Pane (using the same prefix key)..
nnoremap tw <C-w>w
"horisontal split
nnoremap tt :<C-u>vs<CR>
"vertical split
nnoremap tr :<C-u>sp<CR>
nnoremap <S-Left>  <C-w>h
nnoremap <S-Right> <C-w>l
nnoremap <S-Up>    <C-w>k
nnoremap <S-Down>  <C-w>j
" Change (split) Window size by Ctrl + Shift + arrow
nnoremap <S-C-Left>  <C-w><<CR>
nnoremap <S-C-Right> <C-w>><CR>
nnoremap <S-C-Up>        <C-w>-<CR>
nnoremap <S-C-Down>  <C-w>+<CR>
"}}}


"""{{{ Display Settings..
syntax enable
filetype plugin on
filetype indent on

set number                              " Show line number.
set wrap                                " Word wrap.
set textwidth=0                 " Do not let the new line inserted.
set foldmethod=marker   " Let the chunk fold.
colorscheme koehler     " Seems like the best delivered color scheme.
set cursorline                  " Highlight the current line.
set laststatus=2                " Always show the status line.
set showmatch                   " Briefly show the matching bracket.
set matchtime=3                 " Show the matching bracket for 3 seconds.

" Let the TAB appear.
"set list
" Use unicode chars for TAB. Use the one you like.
 set listchars=tab:»-,extends:»,precedes:«,nbsp:%
" Use following line, if your env does not allow unicode
"set listchars=nbsp:%

" Status Line
highlight StatusLine cterm=NONE ctermfg=black ctermbg=white
highlight StatusLineNC cterm=NONE ctermfg=darkblue ctermbg=white
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]%=(%l,%c)[%P] " If fugitive is not installed..
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ (%l,%v)[%p%%]\ [LEN=%L]%=%{fugitive#statusline()}
" Following lines assume nyan_modoki bundle has been installed (=^・^=)
let g:nyan_modoki_select_cat_face_number = 2
let g:nayn_modoki_animation_enabled= 1
"}}}


""{{{ When insert mode, change statusline.
let g:hi_insert = 'hi StatusLine cterm=None ctermfg=Black ctermbg=Yellow'
let g:hi_visual = 'hi StatusLine cterm=None ctermfg=Black ctermbg=darkcyan'

if has('syntax')
  augroup InsertHook
      autocmd!
      autocmd InsertEnter * call s:StatusLine('Enter')
      autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
exec 'highlight '.a:hi
  redir END
let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
return hl
endfunction
"}}}


""{{{ Highlight the Zenkaku-space, presumably useful only for CJK langs.
function! ZenkakuSpace()
  highlight ZenkakuSpace ctermbg=red ctermfg=red
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,Bufread * let w:m1=matchadd('ZenkakuSpace', '　')
"        autocmd ColorScheme       * call ZenkakuSpace()
"        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"        autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif
"}}}


""{{{ read the viminfo with history (possibly updated by other vim processes) right before writing on exit
augroup quitcmd
  autocmd!
  autocmd VimLeavePre * :rviminfo
augroup END
"}}}


"""{{{ netrw Settings..
let g:netrw_banner    = 0
let g:netrw_list_hide = '^\..*'
let g:netrw_liststyle = 0
let g:netrw_sizestyle = "H"
let g:netrw_timefmt   = "%Y/%m/%d(%a) %H:%M:%S"
function! NetrwMapping_l(islocal)
    return "normal \<Enter>"
endfunction
function! NetrwMapping_h(islocal)
    return "normal -"
endfunction
let g:Netrw_UserMaps = [
\   ['l',  'NetrwMapping_l'],
\   ['h',  'NetrwMapping_h'],
\ ]
"}}}


""{{{Most (and least?) Important Settings at Last..

" use "c." to execute the previously executed command
nnoremap c. q:k<Cr>

" Exit quickly when:
" - this plugin was already loaded
" - when 'compatible' is set
" - some autocommands are already taking care of compressed files
if exists("loaded_gzip") || &cp || exists("#BufReadPre#*.gz")
      finish
endif
let loaded_gzip = 1
augroup gzip
  " Remove all gzip autocommands
  au!
  " Enable editing of gzipped files.
  " The functions are defined in autoload/gzip.vim.
  "
  " Set binary mode before reading the file.
  " Use "gzip -d", gunzip isn't always available.
  autocmd BufReadPre,FileReadPre    *.gz,*.bz2,*.Z,*.lzma,*.xz,*.lz,*.zst setlocal bin
  autocmd BufReadPost,FileReadPost    *.gz  call gzip#read("gzip -dn")
  autocmd BufReadPost,FileReadPost  *.bz2 call gzip#read("bzip2 -d")
  autocmd BufReadPost,FileReadPost    *.Z   call gzip#read("uncompress")
  autocmd BufReadPost,FileReadPost  *.lzma call gzip#read("lzma -d")
  autocmd BufReadPost,FileReadPost    *.xz  call gzip#read("xz -d")
  autocmd BufReadPost,FileReadPost  *.lz  call gzip#read("lzip -d")
  autocmd BufReadPost,FileReadPost    *.zst call gzip#read("zstd -d --rm")
  autocmd BufWritePost,FileWritePost    *.gz  call gzip#write("gzip")
  autocmd BufWritePost,FileWritePost  *.bz2 call gzip#write("bzip2")
  autocmd BufWritePost,FileWritePost    *.Z   call gzip#write("compress -f")
  autocmd BufWritePost,FileWritePost  *.lzma call gzip#write("lzma -z")
  autocmd BufWritePost,FileWritePost    *.xz  call gzip#write("xz -z")
  autocmd BufWritePost,FileWritePost  *.lz  call gzip#write("lzip")
  autocmd BufWritePost,FileWritePost    *.zst  call gzip#write("zstd --rm")
  autocmd FileAppendPre           *.gz  call gzip#appre("gzip -dn")
  autocmd FileAppendPre         *.bz2 call gzip#appre("bzip2 -d")
  autocmd FileAppendPre           *.Z   call gzip#appre("uncompress")
  autocmd FileAppendPre         *.lzma call gzip#appre("lzma -d")
  autocmd FileAppendPre           *.xz   call gzip#appre("xz -d")
  autocmd FileAppendPre         *.lz   call gzip#appre("lzip -d")
  autocmd FileAppendPre           *.zst call gzip#appre("zstd -d --rm")
  autocmd FileAppendPost        *.gz  call gzip#write("gzip")
  autocmd FileAppendPost      *.bz2 call gzip#write("bzip2")
  autocmd FileAppendPost        *.Z   call gzip#write("compress -f")
  autocmd FileAppendPost      *.lzma call gzip#write("lzma -z")
  autocmd FileAppendPost        *.xz call gzip#write("xz -z")
  autocmd FileAppendPost      *.lz call gzip#write("lzip")
  autocmd FileAppendPost        *.zst call gzip#write("zstd --rm")
augroup END


" Move the cursor from previous session when you launch Vim.
augroup previousline
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" This is required to avoid automatically inserting the comment at the beginning of line.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"}}}

