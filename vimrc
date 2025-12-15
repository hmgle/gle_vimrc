" =============================================================================
" Vim Configuration - 基于 Neovim 配置转换
" =============================================================================

" ----------------------------- 基本设置 --------------------------------------
set nocompatible
filetype plugin indent on
syntax enable

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

" 搜索设置
set ignorecase
set smartcase
set hlsearch
set incsearch

" 界面设置
set scrolloff=2
set timeoutlen=500
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
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
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

" 窗口间移动
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Quickfix 切换
nnoremap <silent><expr> <leader>q ":".(!empty(getqflist())? "cclose" : "botright copen")."<cr>"

" 插入日期
inoremap <C-d> <C-R>=strftime("%Y-%m-%d")<CR>

" 命令行快捷键（类似 Bash）
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
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
Plug 'jiangmiao/auto-pairs'

" 快速移动
Plug 'easymotion/vim-easymotion'

" 对齐
Plug 'godlygeek/tabular'

" 缩进检测
Plug 'tpope/vim-sleuth'

" 标签栏
Plug 'preservim/tagbar'

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

" Yank 历史
Plug 'svermeulen/vim-yoink'

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
Plug 'aklt/plantuml-syntax'
Plug 'scrooloose/vim-slumlord'

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
let g:gruvbox_material_dim_inactive_windows = 1
let g:gruvbox_material_ui_contrast = 'high'
colorscheme gruvbox-material

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

" 自动关闭
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

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
" 类似 flash.nvim 的快速跳转
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

" ----------------------------- vim-illuminate 配置 ---------------------------
let g:Illuminate_delay = 200
nnoremap <leader>n :lua vim.lsp.buf.goto_next_reference()<CR>
nnoremap <leader>N :lua vim.lsp.buf.goto_prev_reference()<CR>
" 注意：vim-illuminate 在 vim 中功能受限，使用 ]r [r 跳转
nmap <leader>n <Plug>(Illuminate_next_reference)
nmap <leader>N <Plug>(Illuminate_prev_reference)

" ----------------------------- vim-yoink 配置 --------------------------------
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-m> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)
let g:yoinkIncludeDeleteOperations = 1

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
highlight OffscreenPopup guibg=#FF0000 guifg=blue

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
if executable('fcitx5-remote')
    autocmd InsertLeave * silent! call system('fcitx5-remote -c')
elseif executable('fcitx-remote')
    autocmd InsertLeave * silent! call system('fcitx-remote -c')
endif

" ----------------------------- 其他设置 --------------------------------------
" 自动保存视图
augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
augroup END

" 大文件优化
augroup LargeFile
    autocmd!
    autocmd BufReadPre * if getfsize(expand("<afile>")) > 2097152 |
        \ setlocal noswapfile |
        \ setlocal bufhidden=unload |
        \ setlocal undolevels=-1 |
        \ setlocal foldmethod=manual |
        \ setlocal nofoldenable |
        \ endif
augroup END
