# Vim 配置说明文档

本配置基于 [Neovim 配置](https://github.com/hmgle/nvim.git)转换而来，尽可能保持相同的快捷键和功能体验。

## 目录

- [安装说明](#安装说明)
- [基本设置](#基本设置)
- [插件列表](#插件列表)
- [快捷键说明](#快捷键说明)
  - [通用快捷键](#通用快捷键)
  - [Buffer 操作](#buffer-操作)
  - [窗口操作](#窗口操作)
  - [文件浏览 (NERDTree)](#文件浏览-nerdtree)
  - [模糊搜索 (FZF)](#模糊搜索-fzf)
  - [代码补全与 LSP (CoC)](#代码补全与-lsp-coc)
  - [快速移动 (EasyMotion)](#快速移动-easymotion)
  - [代码注释 (Commentary)](#代码注释-commentary)
  - [文本操作 (Surround)](#文本操作-surround)
  - [替换操作 (Subversive)](#替换操作-subversive)
  - [Git 操作](#git-操作)
  - [终端 (Floaterm)](#终端-floaterm)
  - [翻译](#翻译)
  - [命令行快捷键](#命令行快捷键)
- [插件命令](#插件命令)

---

## 安装说明

### 前置依赖

```bash
# Ubuntu/Debian
sudo apt install vim-gtk3 curl git nodejs npm fzf ripgrep ctags

# macOS
brew install vim node fzf ripgrep ctags

# 安装 Nerd Font (用于图标显示)
# 从 https://www.nerdfonts.com/ 下载并安装
```

### 安装步骤

1. **创建符号链接**
   ```bash
   ln -sf ~/.vim/vimrc ~/.vimrc
   ```

2. **启动 Vim 安装插件**
   ```bash
   vim +PlugInstall +qall
   ```

3. **安装 CoC 扩展** (在 Vim 中执行)
   ```vim
   :CocInstall coc-json coc-tsserver coc-go coc-pyright coc-lua coc-snippets coc-pairs
   ```

4. **配置 Copilot** (可选)
   ```vim
   :Copilot setup
   ```

---

## 基本设置

| 设置项 | 值 | 说明 |
|--------|-----|------|
| Leader 键 | `,` | 大部分自定义快捷键的前缀 |
| 编码 | UTF-8 | 支持中文 |
| 行号 | 相对行号 | 方便跳转 |
| 缩进 | Tab=8 | 使用 Tab 缩进 |
| 主题 | gruvbox-material | 浅色主题 |
| 鼠标 | 启用 | 支持鼠标操作 |
| 剪贴板 | 系统剪贴板 | 与系统共享 |
| Undo | 持久化 | 退出后保留撤销历史 |

---

## 插件列表

| 插件 | 说明 | 对应 Neovim 插件 |
|------|------|-----------------|
| gruvbox-material | 主题 | 相同 |
| vim-airline | 状态栏 | nvim-hardline |
| NERDTree | 文件浏览器 | nvim-tree |
| fzf.vim | 模糊搜索 | telescope.nvim |
| fzf-filemru | frecency 文件排序 | snacks.picker.smart |
| coc.nvim | LSP 补全 | nvim-lspconfig + blink.cmp |
| vim-fugitive | Git 集成 | 相同 |
| vim-gitgutter | Git 状态 | - |
| vim-surround | 包围操作 | nvim-surround |
| vim-commentary | 注释 | Comment.nvim |
| vim-easymotion | 快速移动 | flash.nvim |
| vim-polyglot | 语法高亮 | nvim-treesitter |
| rainbow | 括号彩虹 | rainbow-delimiters |
| vim-illuminate | 高亮光标词 | 相同 |
| vim-matchup | 匹配增强 | 相同 |
| vim-subversive | 替换操作 | substitute.nvim |
| vim-which-key | 快捷键提示 | which-key.nvim |
| vim-floaterm | 浮动终端 | toggleterm.nvim |
| tagbar | 代码大纲 | outline.nvim |
| coc-pairs (CoC 扩展) | 自动括号 | nvim-autopairs |
| copilot.vim | AI 补全 | copilot.lua |
| vim-go | Go 支持 | go.nvim |

---

## 快捷键说明

> **说明**: `<leader>` 键为 `,`

### 通用快捷键

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader><CR>` | Normal | 清除搜索高亮 |
| `<leader>q` | Normal | 切换 Quickfix 窗口 |
| `<leader>o` | Normal | 关闭其他所有 buffer |
| `<leader>ev` | Normal | 快速编辑 vimrc |
| `<leader>sv` | Normal | 重载 vimrc |
| `<leader>ec` | Normal | 编辑 `coc-settings.json` |
| `<leader>ms` | Normal | 保存会话到 `~/.vim/session.vim` |
| `<leader>mr` | Normal | 恢复会话 `~/.vim/session.vim` |
| `<C-d>` | Insert | 插入当前日期 (YYYY-MM-DD) |
| `<leader>` | Normal | 显示快捷键提示 (WhichKey) |

### Buffer 操作

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `gt` | Normal | 下一个 buffer |
| `gT` | Normal | 上一个 buffer |
| `[b` | Normal | 上一个 buffer |
| `]b` | Normal | 下一个 buffer |
| `[B` | Normal | 第一个 buffer |
| `]B` | Normal | 最后一个 buffer |
| `<A-1>` ~ `<A-9>` | Normal | 跳转到第 1-9 个 buffer |
| `<leader>b` | Normal | 显示 buffer 列表 (FZF) |
| `<leader>o` | Normal | 关闭其他 buffer |

### 窗口操作

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<C-h>` | Normal | 移动到左边窗口 |
| `<C-j>` | Normal | 移动到下边窗口 |
| `<C-k>` | Normal | 移动到上边窗口 |
| `<C-l>` | Normal | 移动到右边窗口 |
| `<C-w><C-e>` | Normal | 切换 Tagbar (代码大纲) |

### 文件浏览 (NERDTree)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>tt` | Normal | 切换文件树 |
| `<leader>tf` | Normal | 在文件树中定位当前文件 |

**NERDTree 内部快捷键:**

| 快捷键 | 功能 |
|--------|------|
| `o` / `<CR>` | 打开文件/展开目录 |
| `go` | 预览文件 |
| `t` | 在新标签页打开 |
| `T` | 在新标签页打开（保持焦点） |
| `i` | 水平分割打开 |
| `gi` | 水平分割预览 |
| `s` | 垂直分割打开 |
| `gs` | 垂直分割预览 |
| `O` | 递归展开目录 |
| `x` | 关闭父目录 |
| `X` | 递归关闭所有子目录 |
| `P` | 跳转到根目录 |
| `p` | 跳转到父目录 |
| `K` | 跳转到第一个子节点 |
| `J` | 跳转到最后一个子节点 |
| `u` | 向上移动根目录 |
| `C` | 设置当前目录为根目录 |
| `r` | 刷新当前目录 |
| `R` | 刷新根目录 |
| `m` | 显示菜单 |
| `I` | 切换隐藏文件显示 |
| `?` | 显示帮助 |

### 模糊搜索 (FZF + fzf-filemru)

使用 [fzf-filemru](https://github.com/tweekmonster/fzf-filemru) 实现 frecency（频率+最近）排序，类似 Neovim 的 snacks.picker.smart。

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<C-p>` | Normal | **智能文件搜索** (最近文件优先，frecency 排序) |
| `<leader>ff` | Normal | 普通文件搜索 |
| `<leader>fz` | Normal | MRU 文件搜索 |
| `<leader>fg` | Normal | 全局内容搜索 (ripgrep) |
| `<leader>fl` | Normal | 所有 buffer 行搜索 |
| `<leader>fb` | Normal | 当前 buffer 行搜索 |
| `<leader>b` | Normal | Buffer 列表 |
| `<leader>fh` | Normal | 帮助文档搜索 |
| `<leader>fr` | Normal | 最近文件历史 (vim 原生) |
| `<leader>*` | Normal | 搜索光标下的单词 |

**FZF 窗口内快捷键:**

| 快捷键 | 功能 |
|--------|------|
| `<CR>` | 在当前窗口打开 |
| `<C-t>` | 在新标签页打开 |
| `<C-x>` | 水平分割打开 |
| `<C-]>` | 垂直分割打开 |
| `<C-/>` | 切换预览窗口 |
| `<Tab>` | 多选 |
| `<C-j>` / `<C-n>` | 下一项 |
| `<C-k>` / `<C-p>` | 上一项 |

### 代码补全与 LSP (CoC)

**补全操作:**

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<Tab>` | Insert | 选择下一个补全项 / 触发补全 |
| `<S-Tab>` | Insert | 选择上一个补全项 |
| `<C-j>` | Insert | 选择下一个补全项 |
| `<C-k>` | Insert | 选择上一个补全项 |
| `<CR>` | Insert | 确认选择补全项 |
| `<C-Space>` | Insert | 手动触发补全 |

**LSP 导航:**

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `gd` | Normal | 跳转到定义 |
| `gy` | Normal | 跳转到类型定义 |
| `gi` | Normal | 跳转到实现 |
| `gr` | Normal | 查看引用 |
| `K` | Normal | 显示文档悬浮窗 |
| `[d` | Normal | 上一个诊断 |
| `]d` | Normal | 下一个诊断 |

**LSP 操作:**

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>rn` | Normal | 重命名符号 |
| `<leader>ca` | Normal/Visual | 代码动作 |
| `<leader>f` | Normal/Visual | 格式化选中代码 |
| `<leader>qf` | Normal | 快速修复 |
| `<leader>fd` | Normal | 显示诊断列表 |
| `<leader>ss` | Normal | 显示文档符号 |
| `<leader>sS` | Normal | 显示工作区符号 |

### 快速移动 (EasyMotion)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `s{char}{char}` | Normal/Visual/Operator | 双字符跳转 |

使用方法:
1. 按 `s`
2. 输入两个字符
3. 按显示的标签字母跳转

### 代码注释 (Commentary)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>cc` | Normal | 切换当前行注释 |
| `<leader>cc` | Visual | 切换选中行注释 |
| `<leader>cb` | Normal | 切换当前行块注释 |
| `gcc` | Normal | 切换当前行注释 (原生) |
| `gc{motion}` | Normal | 注释 motion 范围 |
| `gc` | Visual | 切换选中区域注释 |

### 文本操作 (Surround)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `cs{old}{new}` | Normal | 更换包围字符 |
| `ds{char}` | Normal | 删除包围字符 |
| `ys{motion}{char}` | Normal | 添加包围字符 |
| `yss{char}` | Normal | 整行添加包围 |
| `S{char}` | Visual | 选中区域添加包围 |

**示例:**
- `cs"'` - 将双引号改为单引号: `"hello"` → `'hello'`
- `ds"` - 删除双引号: `"hello"` → `hello`
- `ysiw]` - 给单词加方括号: `hello` → `[hello]`
- `yss)` - 整行加括号: `hello world` → `(hello world)`

### 替换操作 (Subversive)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>r{motion}` | Normal | 用寄存器内容替换 motion 范围 |
| `<leader>rs` | Normal | 替换整行 |
| `<leader>rS` | Normal | 替换到行尾 |
| `<leader>r` | Visual | 替换选中区域 |

使用方法:
1. 复制要替换成的内容 `yiw`
2. 移动到目标位置
3. `<leader>riw` 替换一个单词

### Git 操作

**vim-fugitive:**

| 命令 | 功能 |
|------|------|
| `:Git` / `:G` | 打开 Git 状态窗口 |
| `:Git blame` | 显示 blame 信息 |
| `:Git diff` | 显示 diff |
| `:Git log` | 显示日志 |
| `:Gwrite` | 暂存当前文件 |
| `:Gread` | 撤销当前文件修改 |

**vim-gitgutter:**

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `]c` | Normal | 下一个修改块 |
| `[c` | Normal | 上一个修改块 |
| `<leader>hp` | Normal | 预览修改 |
| `<leader>hs` | Normal | 暂存修改块 |
| `<leader>hu` | Normal | 撤销修改块 |

### 终端 (Floaterm)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<C-s>` | Normal/Terminal | 切换浮动终端 |

**终端内操作:**

| 快捷键 | 功能 |
|--------|------|
| `<C-\><C-n>` | 退出终端模式 |
| `<C-s>` | 隐藏终端 |

### 翻译

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>ee` | Normal | 翻译光标下的单词 |
| `<leader>ee` | Visual | 翻译选中的文本 |
| `<leader>yd` | Normal | 输入要翻译的内容 |

### 命令行快捷键

类似 Bash/Emacs 的命令行编辑快捷键:

| 快捷键 | 功能 |
|--------|------|
| `<C-a>` | 移动到行首 |
| `<C-e>` | 移动到行尾 |
| `<C-b>` | 向左移动一个字符 |
| `<C-f>` | 向右移动一个字符 |
| `<C-p>` | 上一条历史命令 |
| `<C-n>` | 下一条历史命令 |
| `<C-d>` | 删除光标下的字符 |
| `<C-k>` | 删除到行尾 (kill-line) |
| `<C-u>` | 删除到行首/清空命令行 (Vim 默认行为) |

### 其他快捷键

**vim-illuminate (高亮光标词):**

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>n` | Normal | CoC 符号/引用导航（依赖 CoC 命令） |
| `<leader>N` | Normal | CoC 符号/引用导航（依赖 CoC 命令） |

vim-illuminate 在 Vim 中可用 `]r` / `[r` 跳转高亮引用。

**Tagbar:**

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<C-w><C-e>` | Normal | 切换 Tagbar |

---

## 插件命令

### CoC 命令

```vim
:CocList              " 显示所有列表
:CocList extensions   " 显示已安装扩展
:CocList diagnostics  " 显示诊断信息
:CocList outline      " 显示文档大纲
:CocList symbols      " 搜索工作区符号
:CocInstall {ext}     " 安装扩展
:CocUninstall {ext}   " 卸载扩展
:CocUpdate            " 更新所有扩展
:CocConfig            " 打开配置文件
:CocRestart           " 重启 CoC
```

### FZF 命令

```vim
:Files [PATH]         " 文件搜索
:GFiles               " Git 文件
:Buffers              " Buffer 列表
:Rg [PATTERN]         " ripgrep 搜索
:Lines                " 所有 buffer 行搜索
:BLines               " 当前 buffer 行搜索
:Tags                 " 标签搜索
:Marks                " 标记搜索
:History              " 文件历史
:History:             " 命令历史
:History/             " 搜索历史
:Commands             " 命令列表
:Maps                 " 快捷键列表
:Helptags             " 帮助标签
:Filetypes            " 文件类型
:Colors               " 配色方案
```

### NERDTree 命令

```vim
:NERDTree             " 打开文件树
:NERDTreeToggle       " 切换文件树
:NERDTreeFind         " 定位当前文件
:NERDTreeFocus        " 聚焦文件树
:NERDTreeClose        " 关闭文件树
```

### Floaterm 命令

```vim
:FloatermNew          " 新建终端
:FloatermToggle       " 切换终端
:FloatermNext         " 下一个终端
:FloatermPrev         " 上一个终端
:FloatermKill         " 关闭终端
```

### Tabular 命令

```vim
:Tabularize /{pattern}    " 按模式对齐
:Tabularize /=            " 按等号对齐
:Tabularize /|            " 按竖线对齐
:Tabularize /:\zs         " 按冒号后对齐
```

### vim-go 命令 (Go 文件)

```vim
:GoRun                " 运行
:GoBuild              " 编译
:GoTest               " 测试
:GoTestFunc           " 测试当前函数
:GoImports            " 整理导入
:GoFmt                " 格式化
:GoDef                " 跳转定义
:GoDoc                " 查看文档
:GoRename             " 重命名
:GoImpl               " 实现接口
:GoAddTags            " 添加 struct tags
:GoRemoveTags         " 删除 struct tags
```

---

## 自定义配置

配置文件位置:

- 主配置: `~/.vim/vimrc` 或 `~/.vimrc`
- CoC 配置: `~/.vim/coc-settings.json`
- 插件目录: `~/.vim/plugged/`

### 添加新插件

在 `call plug#begin()` 和 `call plug#end()` 之间添加:

```vim
Plug 'author/plugin-name'
```

然后执行 `:PlugInstall`

### 更新插件

```vim
:PlugUpdate           " 更新所有插件
:PlugUpgrade          " 更新 vim-plug 自身
```

### 删除插件

1. 从 vimrc 中删除 `Plug` 行
2. 重启 Vim
3. 执行 `:PlugClean`

---

## 故障排除

### 插件未加载

```vim
:PlugStatus           " 检查插件状态
:PlugInstall          " 重新安装
```

### CoC 报错

```vim
:CocInfo              " 查看 CoC 信息
:CocOpenLog           " 查看日志
:checkhealth          " 健康检查 (Neovim)
```

### 图标显示异常

确保安装了 Nerd Font 并在终端中使用该字体。

### 颜色显示异常

确保终端支持真彩色，在 `.bashrc` 或 `.zshrc` 中添加:

```bash
export TERM=xterm-256color
```

---

## 相关文档

- [INCOMPATIBLE.md](./INCOMPATIBLE.md) - 与 Neovim 不兼容的功能说明
- [vim-plug](https://github.com/junegunn/vim-plug) - 插件管理器
- [coc.nvim](https://github.com/neoclide/coc.nvim) - LSP 客户端
- [fzf.vim](https://github.com/junegunn/fzf.vim) - 模糊搜索
