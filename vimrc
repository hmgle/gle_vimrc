" =============================================================================
" Vim Configuration - 基于 Neovim 配置转换
" =============================================================================

" ----------------------------- 基本设置 --------------------------------------
set nocompatible
filetype plugin indent on
syntax enable

" PlantUML 文件类型检测（配合 vim-plug 的 { 'for': 'plantuml' } 懒加载）
augroup PlantumlFiletypeDetect
    autocmd!
    autocmd BufNewFile,BufRead *.puml,*.plantuml,*.pu setfiletype plantuml
augroup END

" Leader 键
let mapleader = ','
let maplocalleader = ','

" 编码设置
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,ucs-bom,cp936,gb18030

" 行号
set number
set relativenumber

" 不创建备份文件
set nobackup
set nowritebackup
set noswapfile

" 持久化撤销历史
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undodir
    if !isdirectory(&undodir)
        call mkdir(&undodir, 'p', 0700)
    endif
endif

" 搜索设置
set ignorecase
set smartcase
set hlsearch
set incsearch

" 界面设置
set scrolloff=2
set ttimeoutlen=50
set updatetime=300
set signcolumn=yes
set laststatus=2
set showmode
set showcmd
set wildmenu
set wildmode=longest:full,full

" 分割窗口
set splitright
set splitbelow

" 缩进设置
set noexpandtab
set shiftwidth=8
set tabstop=8
set smarttab
set smartindent
set autoindent

" 换行设置
set textwidth=500
set whichwrap+=<,>,h,l
set backspace=indent,eol,start

" 文件格式
set fileformats=unix,dos,mac

" 光标设置
let &t_SI = "\e[6 q"  " Insert mode: 竖线光标
let &t_EI = "\e[2 q"  " Normal mode: 块状光标

" 补全设置
set completeopt=menu,menuone,noselect

" 鼠标支持
set mouse=a

" 剪贴板
if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamedplus
    else
        set clipboard=unnamed
    endif
elseif executable('xclip') && exists('##TextYankPost')
    " Vim 没有 clipboard 支持时，使用 xclip 作为替代
    " 通过 TextYankPost 自动同步所有 yank 操作到系统剪贴板
    augroup YankToClipboard
        autocmd!
        autocmd TextYankPost * call system('xclip -selection clipboard', join(v:event.regcontents, "\n"))
    augroup END

    " 从系统剪贴板粘贴
    function! s:PasteFromClipboard(cmd) abort
        let @" = system('xclip -selection clipboard -o')
        execute 'normal! ' . a:cmd
    endfunction

    nnoremap <silent> p :call <SID>PasteFromClipboard('p')<CR>
    nnoremap <silent> P :call <SID>PasteFromClipboard('P')<CR>
endif

" 终端真彩色支持
if has('termguicolors')
    set termguicolors
endif

" 背景色
set background=light

" 隐藏缓冲区
set hidden

" 命令行高度
set cmdheight=1

" 不显示模式（由状态栏显示）
" set noshowmode

" ----------------------------- 自动命令 --------------------------------------
augroup vimrc_settings
    autocmd!
    " 代码列标记
    autocmd FileType c,cpp,python,markdown,mkd,asciidoc,go,erlang,lua setlocal colorcolumn=81

    " 窗口大小调整（tmux）
    if exists('$TMUX')
        autocmd VimResized * wincmd =
    endif
augroup END

" ----------------------------- 快捷键映射 ------------------------------------
" Buffer 切换
nnoremap gt :bn<CR>
nnoremap gT :bp<CR>

" 清除搜索高亮
map <silent> <leader><cr> :noh<cr>

" 窗口间移动（仅 normal 模式，避免与插入模式补全冲突）
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Quickfix 切换
nnoremap <silent><expr> <leader>q ":".(!empty(getqflist())? "cclose" : "botright copen")."<cr>"

" 插入日期
inoremap <C-d> <C-R>=strftime("%Y-%m-%d")<CR>

" 命令行快捷键（类似 Bash）
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <right>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" 关闭其他 buffer
function! CloseBufsButCurr()
    let l:bufnr = bufnr('%')
    for i in range(1, bufnr('$'))
        if i != l:bufnr && bufexists(i)
            try
                execute 'bdelete ' . i
            catch
            endtry
        endif
    endfor
endfunction
nnoremap <leader>o :call CloseBufsButCurr()<CR>

" 快速编辑和重载配置文件
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>:echo "vimrc reloaded!"<CR>
nnoremap <leader>ec :edit ~/.vim/coc-settings.json<CR>

" Buffer 快速导航
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" 会话管理
nnoremap <leader>ms :mksession! ~/.vim/session.vim<CR>:echo "Session saved!"<CR>
nnoremap <leader>mr :source ~/.vim/session.vim<CR>:echo "Session restored!"<CR>

" ----------------------------- 插件管理 (vim-plug) ----------------------------
" 自动安装 vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" ----- 核心插件 -----
" 主题
Plug 'sainnhe/gruvbox-material'

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 文件浏览器
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" 模糊搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tweekmonster/fzf-filemru'  " frecency 排序 (最近+频率)

" Git 集成
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" 文本操作
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
" 注：使用 coc-pairs 代替 auto-pairs（避免冲突）

" 快速移动
Plug 'easymotion/vim-easymotion'

" 对齐
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" 缩进检测
Plug 'tpope/vim-sleuth'

" 标签栏
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }

" 代码补全和 LSP (coc.nvim)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 语法高亮增强
Plug 'sheerun/vim-polyglot'

" 括号彩虹
Plug 'luochen1990/rainbow'

" 搜索增强
Plug 'romainl/vim-cool'  " 自动清除搜索高亮

" 高亮光标词
Plug 'RRethy/vim-illuminate'

" 匹配增强
Plug 'andymass/vim-matchup'

" 替换操作
Plug 'svermeulen/vim-subversive'

" Which Key
Plug 'liuchengxu/vim-which-key'

" 翻译
Plug 'ianva/vim-youdao-translater'

" GitHub Copilot
Plug 'github/copilot.vim'

" 终端
Plug 'voldikss/vim-floaterm'

" 布尔值切换
Plug 'AndrewRadev/switch.vim'

" PlantUML
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'scrooloose/vim-slumlord', { 'for': 'plantuml' }

" Go 支持
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': ['go', 'gomod'] }

call plug#end()

" ----------------------------- 主题配置 --------------------------------------
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_current_word = 'bold'
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_show_eob = 0
let g:gruvbox_material_dim_inactive_windows = 0
let g:gruvbox_material_ui_contrast = 'high'

" 加载主题（带错误处理）
try
    colorscheme gruvbox-material
catch /^Vim\%((\a\+)\)\=:E185/
    " 主题未安装时使用默认配色
    colorscheme default
    echohl WarningMsg
    echo "gruvbox-material not found, using default colorscheme. Run :PlugInstall to install."
    echohl None
endtry

" ----------------------------- 统一背景色设置 --------------------------------
" 覆盖主题的高亮设置，保持背景色一致
" 使用下划线、粗体、前景色变化代替背景色变化
function! s:UnifyBackground() abort
    " 醒目的前景色（gruvbox 红/橙色系）
    let l:fg_search = '#c14a4a'      " 红色 - 搜索高亮
    let l:fg_ref = '#6c782e'         " 绿色 - 引用高亮
    let l:fg_match = '#b47109'       " 橙色 - 括号匹配

    " 搜索高亮：红色前景 + 下划线 + 粗体
    execute 'highlight Search ctermbg=NONE guibg=NONE ctermfg=red guifg=' . l:fg_search . ' cterm=underline,bold gui=underline,bold'
    execute 'highlight IncSearch ctermbg=NONE guibg=NONE ctermfg=red guifg=' . l:fg_search . ' cterm=reverse,underline,bold gui=reverse,underline,bold'
    execute 'highlight CurSearch ctermbg=NONE guibg=NONE ctermfg=red guifg=' . l:fg_search . ' cterm=underline,bold gui=underline,bold'

    " 视觉选择：使用反色
    highlight Visual ctermbg=NONE guibg=NONE cterm=reverse gui=reverse

    " 当前词高亮 (vim-illuminate)：绿色前景 + 下划线
    execute 'highlight IlluminatedWordText ctermbg=NONE guibg=NONE ctermfg=green guifg=' . l:fg_ref . ' cterm=underline gui=underline'
    execute 'highlight IlluminatedWordRead ctermbg=NONE guibg=NONE ctermfg=green guifg=' . l:fg_ref . ' cterm=underline gui=underline'
    execute 'highlight IlluminatedWordWrite ctermbg=NONE guibg=NONE ctermfg=green guifg=' . l:fg_ref . ' cterm=underline gui=underline'

    " CoC 高亮：绿色前景 + 下划线
    execute 'highlight CocHighlightText ctermbg=NONE guibg=NONE ctermfg=green guifg=' . l:fg_ref . ' cterm=underline gui=underline'
    execute 'highlight CocHighlightRead ctermbg=NONE guibg=NONE ctermfg=green guifg=' . l:fg_ref . ' cterm=underline gui=underline'
    execute 'highlight CocHighlightWrite ctermbg=NONE guibg=NONE ctermfg=green guifg=' . l:fg_ref . ' cterm=underline gui=underline'

    " 匹配括号：橙色前景 + 下划线 + 粗体
    execute 'highlight MatchParen ctermbg=NONE guibg=NONE ctermfg=yellow guifg=' . l:fg_match . ' cterm=bold,underline gui=bold,underline'

    " QuickFix 当前行
    highlight QuickFixLine ctermbg=NONE guibg=NONE cterm=bold gui=bold

    " 注意：Cursor（光标字符位置）保持主题默认，不覆盖
endfunction

" 主题加载后应用统一背景
augroup UnifyBackgroundGroup
    autocmd!
    autocmd ColorScheme * call s:UnifyBackground()
augroup END

" 立即应用（首次加载）
call s:UnifyBackground()

" ----------------------------- Airline 配置 ----------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme = 'gruvbox_material'
let g:airline_powerline_fonts = 1

" Buffer 索引快捷键 (Alt+数字)
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <A-1> <Plug>AirlineSelectTab1
nmap <A-2> <Plug>AirlineSelectTab2
nmap <A-3> <Plug>AirlineSelectTab3
nmap <A-4> <Plug>AirlineSelectTab4
nmap <A-5> <Plug>AirlineSelectTab5
nmap <A-6> <Plug>AirlineSelectTab6
nmap <A-7> <Plug>AirlineSelectTab7
nmap <A-8> <Plug>AirlineSelectTab8
nmap <A-9> <Plug>AirlineSelectTab9

" ----------------------------- NERDTree 配置 ---------------------------------
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^\.git$', '^node_modules$']
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

" 自动关闭（最后一个窗口时）
augroup NERDTreeConfig
    autocmd!
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END

" ----------------------------- FZF 配置 --------------------------------------
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" fzf-filemru 配置 (frecency 排序)
let g:fzf_filemru_bufwrite = 1        " 保存文件时更新 MRU
let g:fzf_filemru_git_ls = 1          " 使用 git ls-files (更快)
let g:fzf_filemru_ignore_submodule = 1

" 快捷键映射 (与 Neovim telescope 类似)
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fb :BLines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>* :Rg <C-R><C-W><CR>
nnoremap <leader>fr :History<CR>
" Ctrl+P 使用 ProjectMru - 最近文件排在前面 (类似 snacks.picker.smart)
nnoremap <C-p> :ProjectMru --tiebreak=index<CR>
nnoremap <leader>fz :FilesMru<CR>

" FZF 窗口内快捷键
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-]': 'vsplit' }

" ----------------------------- CoC 配置 --------------------------------------
" 扩展列表
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-go',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-lua',
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ ]

" Tab 补全
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter 确认补全
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ctrl+j/k 在补全菜单中移动
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

" 触发补全
inoremap <silent><expr> <c-space> coc#refresh()

" 跳转定义
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 显示文档
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" 重命名
nmap <leader>rn <Plug>(coc-rename)

" 格式化
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" 代码动作
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
xmap <leader>ca  <Plug>(coc-codeaction-selected)

" 快速修复
nmap <leader>qf  <Plug>(coc-fix-current)

" 诊断跳转
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" 显示诊断列表
nnoremap <leader>fd :<C-u>CocList diagnostics<CR>

" 显示符号
nnoremap <leader>ss :<C-u>CocList outline<CR>
nnoremap <leader>sS :<C-u>CocList -I symbols<CR>

" ----------------------------- EasyMotion 配置 -------------------------------
" 类似 flash.nvim 的快速跳转（双字符跳转）
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-overwin-f2)
xmap s <Plug>(easymotion-overwin-f2)
omap s <Plug>(easymotion-overwin-f2)

" ----------------------------- Tagbar 配置 -----------------------------------
let g:tagbar_silent = 1
nnoremap <C-w><C-e> :TagbarToggle<CR>

" Zig 支持
let g:tagbar_type_zig = {
    \ 'ctagstype': 'zig',
    \ 'kinds': [
        \ 'f:functions',
        \ 's:structs',
        \ 'e:enums',
        \ 'u:unions',
        \ 'E:errors',
    \ ],
\ }

" ----------------------------- Rainbow 配置 ----------------------------------
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'separately': {
\       '*': {},
\       'markdown': 0,
\       'html': 0,
\   }
\}

" ----------------------------- CoC Document Highlight 配置 --------------------
" 启用光标停留时自动高亮引用
augroup CocDocumentHighlight
    autocmd!
    if exists('*CocActionAsync')
        autocmd CursorHold * silent call CocActionAsync('highlight')
    endif
augroup END

" 使用 CoC 的 LSP 引用导航（匹配 Neovim illuminate 和 vim-lsp 行为）
nmap <silent> <leader>n :CocCommand document.jumpToNextSymbol<CR>
nmap <silent> <leader>N :CocCommand document.jumpToPrevSymbol<CR>

" ----------------------------- vim-illuminate 配置 ---------------------------
let g:Illuminate_delay = 200
" 注意：vim-illuminate 提供额外的单词高亮，CoC 提供基于 LSP 的符号高亮

" ----------------------------- vim-subversive 配置 ---------------------------
" 类似 substitute.nvim
nmap <leader>r <plug>(SubversiveSubstitute)
nmap <leader>rs <plug>(SubversiveSubstituteLine)
nmap <leader>rS <plug>(SubversiveSubstituteToEndOfLine)
xmap <leader>r <plug>(SubversiveSubstitute)

" ----------------------------- Commentary 配置 -------------------------------
" 类似 Comment.nvim
nmap <leader>cc gcc
vmap <leader>cc gc
nmap <leader>cb gbc

" ----------------------------- Which Key 配置 --------------------------------
nnoremap <silent> <leader> :WhichKey ','<CR>
set timeoutlen=300

" ----------------------------- 翻译配置 --------------------------------------
vnoremap <leader>ee :<C-u>Ydv<CR>
nnoremap <leader>ee :<C-u>Ydc<CR>
nnoremap <leader>yd :<C-u>Yde<CR>

" ----------------------------- Floaterm 配置 ---------------------------------
" 类似 toggleterm.nvim
let g:floaterm_keymap_toggle = '<C-s>'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

" ----------------------------- Switch 配置 -----------------------------------
" 类似 boole.nvim
let g:switch_mapping = ""
let g:switch_custom_definitions =
    \ [
    \   ['true', 'false'],
    \   ['True', 'False'],
    \   ['TRUE', 'FALSE'],
    \   ['yes', 'no'],
    \   ['on', 'off'],
    \   ['enable', 'disable'],
    \   ['enabled', 'disabled'],
    \ ]

" ----------------------------- vim-matchup 配置 ------------------------------
let g:matchup_matchparen_offscreen = {'method': 'popup'}
" 使用下划线代替背景色变化
highlight OffscreenPopup gui=underline,bold

" ----------------------------- vim-go 配置 -----------------------------------
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
" 禁用 vim-go 的 LSP 功能，使用 coc.nvim
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_gopls_enabled = 0

" ----------------------------- 输入法切换 ------------------------------------
" 离开插入模式时切换到英文输入法
augroup InputMethodSwitch
    autocmd!
    if executable('fcitx5-remote')
        autocmd InsertLeave * silent! call system('fcitx5-remote -c')
    elseif executable('fcitx-remote')
        autocmd InsertLeave * silent! call system('fcitx-remote -c')
    endif
augroup END

" ----------------------------- 其他设置 --------------------------------------
" 自动保存视图（仅对普通文件，排除特殊缓冲区）
augroup remember_folds
    autocmd!
    autocmd BufWinLeave ?*
        \ if &buftype == '' && &filetype != '' && expand('%') !~ '\[.*\]' |
        \   silent! mkview |
        \ endif
    autocmd BufWinEnter ?*
        \ if &buftype == '' && &filetype != '' && expand('%') !~ '\[.*\]' |
        \   silent! loadview |
        \ endif
augroup END

" 大文件优化
function! s:HandleLargeFile(file)
    if getfsize(a:file) > 2097152  " 2MB
        setlocal noswapfile
        setlocal bufhidden=unload
        setlocal undolevels=-1
        setlocal foldmethod=manual
        setlocal nofoldenable
        " 禁用语法高亮以提升性能（避免全局关闭 syntax）
        silent! syntax clear
        unlet! b:current_syntax
    endif
endfunction

augroup LargeFile
    autocmd!
    autocmd BufReadPre * call s:HandleLargeFile(expand("<afile>"))
augroup END

" ----------------------------- 插件性能优化 -----------------------------------
" vim-gitgutter 性能优化
let g:gitgutter_max_signs = 500
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_priority = 10

" NERDTree 优化
let g:NERDTreeMinimalMenu = 1

" Copilot 优化（避免与 Tab 补全冲突）
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true
" 使用 Ctrl+Y 接受建议
imap <silent><script><expr> <C-y> copilot#Accept("\<CR>")
