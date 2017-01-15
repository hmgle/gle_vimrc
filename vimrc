"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Blog_post: 
"       http://amix.dk/blog/post/19486#The-ultimate-vim-configuration-vimrc
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bundle 配置
set nocompatible " be iMproved
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" {{ golang
Bundle "majutsushi/tagbar"
nmap <c-w><c-e> :TagbarToggle<CR>

Bundle "fatih/vim-go"
" Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
" 避免和 NERDTreeTabsToggle 键冲突
let g:go_def_mapping_enabled = 0
" }}

" Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'

" ctrlp
Bundle 'kien/ctrlp.vim'

" align {{
Bundle 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = ['String']
" }}

" auto specific indentation for different project
Bundle 'tpope/vim-sleuth'

" git
Plugin 'tpope/vim-fugitive'

" CoffeeScript
" require vim 7.4+ coffee 1.2.0+
Plugin 'kchmck/vim-coffee-script'

" asciidoc
Plugin 'asciidoc/vim-asciidoc'

" nerdtree {{
Plugin 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
map <C-T> :NERDTreeTabsToggle<CR>
let g:NERDTreeWinSize=24
" }}

" Surround.vim is all about surroundings
Plugin 'tpope/vim-surround'

Plugin 'lilydjwg/fcitx.vim'

" YCM
Plugin 'Valloric/YouCompleteMe'

" snips {{
" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsUsePythonVersion = 2

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
" }}

" easymotion {{
Bundle 'easymotion/vim-easymotion'
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
" }}

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" youdao-translater {{
Bundle 'hmgle/vim-youdao-translater'
vnoremap <silent> <leader>ee :<C-u>Ydv<CR>
nnoremap <silent> <leader>ee :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>
" }}

Bundle 'cespare/vim-toml'

Bundle 'rking/ag.vim'

Bundle 'ap/vim-buftabline'

Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'digitaltoad/vim-pug'
Bundle 'junegunn/goyo.vim'
Bundle 'marijnh/tern_for_vim', {'do': 'npm install'}
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-abolish'
" bundle end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=1700

" Enable filetype plugin
filetype plugin on
filetype indent on

au BufRead,BufNewFile *.{asciidoc,adoc,ad} set filetype=asciidoc

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 2 lines to the curors - when moving vertical..
set so=2

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

" 缺省为 1
" set cmdheight=1 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" 显示窗口末行尽量多的内容
set dy+=lastline

function! MySys()
	return 'linux'
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
if MySys() == "mac"
  set gfn=Menlo:h14
  set shell=/bin/bash
elseif MySys() == "windows"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
  set gfn=Monospace\ 10
  set shell=/bin/bash
endif

if has("gui_running")
  set guioptions-=T
  set background=dark
  colorscheme peaksea
  set nonu
else
  " colorscheme 256jungle
  set background=dark
  set nonu
endif

set t_Co=256

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set expandtab
set noexpandtab
set shiftwidth=8
set tabstop=8
set smarttab

" set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-B> <Left>
cnoremap <C-F> <right>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
" <C-d>: delete char.
cnoremap <C-d> <Del>
" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
      \ '' : getcmdline()[:getcmdpos()-2]<CR>

" Useful on some European keyboards
"map ? $
"imap ? $
"vmap ? $
"cmap ? $


func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always show the statusline
set laststatus=2

" Format the statusline
set statusline=\ %f%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
"map 0 ^

if MySys() == "mac"
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

"Delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.c,*.cpp,*.h,*.go,*.erl,*.hrl,*.js,*.wsgi :call DeleteTrailingWS()

set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

let g:bufExplorerSortBy = "name"

autocmd BufRead,BufNew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""
" => Go section
""""""""""""""""""""""""""""""
au FileType go inoremap <C-b> <C-x><C-o>

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.wsgi set ft=python

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

" python 缩进 changed by hmg
au FileType python setlocal et sta sw=4 sts=4

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

" JavaScript 缩进 changed by hmg
au FileType javascript setlocal et sta sw=4 sts=4

" ----------------------------------------------------------------------------
" tern_for_vim
" ----------------------------------------------------------------------------
let tern_show_signature_in_pum = 1
let tern_show_argument_hints = 'on_hold'
autocmd FileType javascript nnoremap <leader>d :TernDef<CR>
autocmd FileType javascript setlocal omnifunc=tern#Complete

" Erlang 缩进 changed by hmg
au FileType erlang setlocal et sta sw=4 sts=4

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""""""""""
let g:CommandTMaxHeight = 15
set wildignore+=*.o,*.obj,.git,*.pyc
noremap <leader>j :CommandT<cr>
noremap <leader>y :CommandTFlush<cr>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>
au BufRead,BufNewFile ~/buffer iab <buffer> xh1 ===========================================

map <leader>pp :setlocal paste!<cr>

map <leader>bb :cd ..<cr>

set nu
set rnu
:hi linenr ctermfg=lightcyan
hi Identifier ctermfg=blue cterm=none
set autoindent
set cindent
set smartindent
set tabstop=8
set shiftwidth=8

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
" :inoremap { {<CR>}<Up><ESC>A
" :inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
 
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

colorscheme 256jungle


" 解决从windows拷贝过来的GBK格式乱码
set fileencodings=utf-8,gbk,ucs-bom,cp936,gb18030


set mouse=a
set mousehide
":syntax enable
:set previewheight=12
:run macros/gdb_mappings.vim
":set asm=0
":set gdbprg=/usr/bin/gdb
:map <F8> :bel 30vsplit gdb-variables<cr>
:map <F9> :close<Esc>
map <c-w><c-f> :FirstExplorerWindow<cr>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-t> :WMToggle<cr>
let g:winManagerWindowLayout='FileExplorer|TagList'
:map <F6> :WMToggle<cr>

" set maxmempattern=2500

" 将插入模式aa映射为<esc>
imap aa <esc>
imap jj <esc>
" :nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
:nnoremap <silent><C-n> <C-w><C-]><C-w>T

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")
    " set cscopequickfix by hmg 这样会立即跳转到第一个找到的符号，要跳转到别处， 输入 cw 后选择
    :set cscopequickfix=s-,c-,d-,i-,t-,e-

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	

    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

    function! NewtabCS(cscmd)
    	let s:cskeyword=expand("<cword>")
    	:tabe
	let s:newpagnr=tabpagenr()
	try
		exe "cs find " . a:cscmd s:cskeyword
	catch
		exe "tabc" . s:newpagnr
		echoe "find null!^_^"
		return
	endtry
	let s:prepagnr=tabpagenr()
	if s:newpagnr != s:prepagnr
		exe "tabc" . s:newpagnr
	endif
    endfunction
    
    nmap <C-i>s :call NewtabCS('s')<cr>
    nmap <C-i>g :call NewtabCS('g')<cr>
    nmap <C-i>c :call NewtabCS('c')<cr>
    nmap <C-i>t :call NewtabCS('t')<cr>
    nmap <C-i>e :call NewtabCS('e')<cr>
    nmap <C-i>f :call NewtabCS('f')<cr>
    nmap <C-i>i :call NewtabCS('i')<cr>
    nmap <C-i>d :call NewtabCS('d')<cr>

    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100
    set timeoutlen=800
    set ttimeoutlen=200
endif

" 关闭标签后跳至左边标签
let s:prevtabnum=tabpagenr('$')
let s:prevtabid=tabpagenr()
augroup TabClosed
    autocmd! TabEnter * :if tabpagenr('$')<s:prevtabnum && tabpagenr()>1 && s:prevtabid != tabpagenr('$')+1
                \       |   tabprevious
                \       |endif
                \       |let s:prevtabnum=tabpagenr('$')
    		\	|let s:prevtabid=tabpagenr()
augroup END

au FileType c,cpp inoremap /* /*  */<ESC>hhi
au FileType c,cpp,python,markdown,mkd,asciidoc,go,erlang,lua set colorcolumn=81

" 分界线颜色
hi colorcolumn ctermbg=240 ctermfg=256

" 同级缩进块跳转
function! JumpUp()
	let CurrIndent = indent('.')
	let CurrLineNo = line('.')
	if CurrLineNo == 1
		return
	endif
	let UpLine = CurrLineNo - 1
	let UpIndent = indent(UpLine)
	if UpIndent > CurrIndent
		" 块的底部, 以上一行作为参考信息
		let CurrIndent = UpIndent
		let UpLine -= 1
		if UpLine > 0
			let UpIndent = indent(UpLine)
		else
			exe "normal gg"
			return
		endif
	endif
	" 块的中部
	while UpLine > 1
		if UpIndent < CurrIndent && strlen(getline(UpLine)) > 0
			exe "normal " . UpLine . "gg"
			return
		endif
		let UpLine = UpLine - 1
		let UpIndent = indent(UpLine)
	endwhile
	exe "normal gg"
endfunction

function! JumpDown()
	let CurrIndent = indent('.')
	let CurrLineNo = line('.')
	if CurrLineNo == line('$')
		return
	endif

	let DownLine = CurrLineNo
	" 确保以参考的下一行不为空行
	while DownLine < line('$')
		let DownLine = DownLine + 1
		let DownIndent = indent(DownLine)
		if strlen(getline(DownLine)) > 0
			break
		endif
	endwhile
	
	if DownIndent > CurrIndent
		" 块的顶部, 以下一行作为参考信息
		let CurrIndent = DownIndent
		let DownLine += 1
		if DownLine <= line('$')
			let DownIndent = indent(DownLine)
		else
			exe "normal G"
			return
		endif
	endif
	" 块的中部
	while DownLine < line('$')
		if DownIndent < CurrIndent && strlen(getline(DownLine)) > 0
			let TmpLine = DownLine - 1
			exe "normal " . TmpLine . "G"
			return
		endif
		let DownLine = DownLine + 1
		let DownIndent = indent(DownLine)
	endwhile
	exe "normal G"
endfunction

map vu :call JumpUp()<cr>
map vd :call JumpDown()<cr>

" C_HELP_man
let s:C_DocBufferName       = "C_HELP_man"
let s:C_DocHelpBufferNumber = -1
let s:C_Man                 = 'man'      " the manual program
function! MyC_Help( type )
	let cuc		= getline(".")[col(".") - 1]		" character under the cursor
	let	item	= expand("<cword>")							" word under the cursor
	if cuc == '' || item == "" || match( item, cuc ) == -1
		let	item=C_Input('name of the manual page : ', '' )
	endif

	if item == ""
		return
	endif
	"------------------------------------------------------------------------------
	"  replace buffer content with bash help text
	"------------------------------------------------------------------------------
	"
	" jump to an already open bash help window or create one
	"
	if bufloaded(s:C_DocBufferName) != 0 && bufwinnr(s:C_DocHelpBufferNumber) != -1
		exe bufwinnr(s:C_DocHelpBufferNumber) . "wincmd w"
		" buffer number may have changed, e.g. after a 'save as'
		if bufnr("%") != s:C_DocHelpBufferNumber
			let s:C_DocHelpBufferNumber=bufnr(s:C_OutputBufferName)
			exe ":bn ".s:C_DocHelpBufferNumber
		endif
	else
		exe ":new ".s:C_DocBufferName
		let s:C_DocHelpBufferNumber=bufnr("%")
		setlocal buftype=nofile
		setlocal noswapfile
		setlocal bufhidden=delete
		setlocal filetype=sh		" allows repeated use of <S-F1>
		setlocal syntax=OFF
	endif
	setlocal	modifiable
	"
	if a:type == 'm' 
		"
		" Is there more than one manual ?
		"
		let manpages	= system( s:C_Man.' -k '.item )
		if v:shell_error
			echomsg	"Shell command '".s:C_Man." -k ".item."' failed."
			:close
			return
		endif
		let	catalogs	= split( manpages, '\n', )
		let	manual		= {}
		"
		" Select manuals where the name exactly matches
		"
		for line in catalogs
			if line =~ '^'.item.'\s\+(' 
				let	itempart	= split( line, '\s\+' )
				let	catalog		= itempart[1][1:-2]
				if match( catalog, '.p$' ) == -1
					let	manual[catalog]	= catalog
				endif
			endif
		endfor
		"
		" Build a selection list if there are more than one manual
		"
		let	catalog	= ""
		if len(keys(manual)) > 1
			for key in keys(manual)
				echo ' '.item.'  '.key
			endfor
			let defaultcatalog	= ''
			if has_key( manual, '3' )
				let defaultcatalog	= '3'
			else
				if has_key( manual, '2' )
					let defaultcatalog	= '2'
				endif
			endif
			let	catalog	= input( 'select manual section (<Enter> cancels) : ', defaultcatalog )
			if ! has_key( manual, catalog )
				:close
				:redraw
				echomsg	"no appropriate manual section '".catalog."'"
				return
			endif
		endif

		set filetype=man
		silent exe ":%!".s:C_Man." ".catalog." ".item

	endif

	setlocal nomodifiable
endfunction		" ---------- end of function  C_Help  ----------

au FileType c,cpp map <Leader>h :call MyC_Help("m")<CR>
au FileType c,cpp map vh :call MyC_Help("m")<CR>
au FileType go nmap <Leader>h <Plug>(go-doc)
au FileType go nmap vh <Plug>(go-doc)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" 增加搜索项
function! AddSearchStr(str)
	if strlen(@/) > 0
		let searchstrs = split(@/, '\\|')
		let l:searchstrcnt = count(searchstrs, a:str)
		if l:searchstrcnt > 0
			return
		endif
		let @/ = @/ . "\\|" . a:str
	else
		let @/ = a:str
	endif
endfunction

" 删减搜索项
function! DelSearchStr(str)
	let searchstrs = split(@/, '\\|')
	let l:searchstrcnt = count(searchstrs, a:str)
	if l:searchstrcnt == 0
		return
	endif
	let l:searchall = ""
	for searchstr in searchstrs
		if a:str != searchstr
			let l:searchall = l:searchall . searchstr . '\|'
		endif
	endfor
	let @/ = l:searchall[0:-3]
endfunction

map <leader>a :call AddSearchStr(expand("<cword>"))<CR>
vmap <leader>a :call AddSearchStr(@*)<CR>
map <leader>d :call DelSearchStr(expand("<cword>"))<CR>
vmap <leader>d :call DelSearchStr(@*)<CR>

" gocode 补全快捷键
imap <leader>xo <C-x><C-o>

" 自动补全时的预览菜单, 不显示预览窗口
set completeopt=longest,menu

" 插入时间
nnoremap <C-d> "=strftime("%Y-%m-%d")<CR>P
inoremap <C-d> <C-R>=strftime("%Y-%m-%d")<CR>

" Move to next/previous line with same indentation
nnoremap <silent> [u :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <silent> ]u :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <silent> [d :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
nnoremap <silent> ]d :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>

" For vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
