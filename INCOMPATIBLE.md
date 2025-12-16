# Neovim 到 Vim 配置迁移 - 不兼容功能说明

本文档记录了 Neovim 配置中无法在 Vim 中直接实现的功能，以及相应的替代方案。

## 无法实现的功能

### 1. Treesitter 相关功能

**Neovim 插件**: `nvim-treesitter/nvim-treesitter`

**说明**: Treesitter 是 Neovim 独有的增量解析器，提供了精确的语法分析能力。

**影响的功能**:
- 基于 AST 的精确语法高亮
- `nvim-treesitter-textobjects` 提供的文本对象
- `flash.nvim` 的 treesitter 跳转功能 (`S` 键)
- `treewalker.nvim` 的代码结构导航

**替代方案**:
- 使用 `vim-polyglot` 提供传统的语法高亮
- 文本对象使用原生 vim 或 `vim-textobj-user`

---

### 2. Treewalker 代码导航

**Neovim 插件**: `aaronik/treewalker.nvim`

**原快捷键**:
- `<C-d>`: move_down
- `<C-u>`: move_up
- `<leader>h`: move_out
- `<leader>l`: move_in

**说明**: 基于 treesitter 的代码结构导航，Vim 中无法实现。

**替代方案**:
- 使用 `]]` `[[` 跳转到函数
- 使用 `%` 跳转匹配括号
- 使用 tagbar 查看代码结构

---

### 3. Flash.nvim Treesitter 模式

**Neovim 插件**: `folke/flash.nvim`

**原快捷键**:
- `S`: Flash Treesitter 跳转
- `R`: Treesitter Search

**说明**: 基于 treesitter 的选择功能无法在 Vim 中实现。

**替代方案**:
- `vim-easymotion` 提供了基本的快速跳转功能
- `s` 键已映射为 easymotion 的双字符跳转

---

### 4. Blink.cmp 自动补全

**Neovim 插件**: `saghen/blink.cmp`

**说明**: 这是 Neovim 专用的补全引擎，使用 Lua 编写。

**替代方案**:
- 使用 `coc.nvim` 提供类似的补全体验
- 补全菜单内快捷键已配置为相同 (`<C-j>`, `<C-k>`, `<CR>`)

---

### 5. Outline 插件

**Neovim 插件**: `hedyhli/outline.nvim`

**原快捷键**: `<C-w><C-e>`

**说明**: LSP 符号大纲视图。

**替代方案**:
- 使用 `tagbar` (已配置相同快捷键)
- 使用 `:CocList outline`

---

### 6. nvim-hlslens 搜索增强

**Neovim 插件**: `kevinhwang91/nvim-hlslens`

**说明**: 显示搜索匹配数量和当前位置。

**替代方案**:
- 使用 `vim-cool` 自动清除搜索高亮
- Vim 原生 `:set shortmess-=S` 可显示匹配数

---

### 7. Noice.nvim UI 增强

**Neovim 插件**: `folke/noice.nvim`

**说明**: 美化命令行、消息、通知等 UI 元素，Neovim 专用。

**替代方案**: 无直接替代，使用 Vim 原生 UI

---

### 8. notify 通知系统

**Neovim 插件**: `rcarriga/nvim-notify`

**说明**: 美化的通知显示系统。

**替代方案**: 无直接替代，使用 Vim 原生消息

---

### 9. goto-preview 预览跳转

**Neovim 插件**: `rmagatti/goto-preview`

**原快捷键**: `gp`, `gP`

**说明**: 在浮动窗口中预览定义。

**替代方案**:
- 使用 `:CocAction jumpDefinition split` 在分割窗口中打开
- 使用 `<C-w>d` 已配置为分割窗口打开定义

---

### 10. tiny-code-action 代码动作

**Neovim 插件**: `rachartier/tiny-code-action.nvim`

**说明**: 美化的代码动作选择器。

**替代方案**:
- 使用 coc.nvim 的 `<Plug>(coc-codeaction-cursor)` (已映射到 `<leader>ca`)

---

### 11. grug-far 搜索替换

**Neovim 插件**: `MagicDuck/grug-far.nvim`

**原快捷键**: `<leader>sr`, `<leader>sa`

**说明**: 交互式搜索替换工具。

**替代方案**:
- 使用 Vim 原生 `:vimgrep` 和 `:cdo s///`
- 使用 fzf.vim 的 `:Rg` 搜索

---

### 12. Yanky.nvim 复制历史

**Neovim 插件**: `gbprod/yanky.nvim`

**说明**: 增强的复制历史管理。

**替代方案**:
- 使用 `vim-yoink` (已配置)
- `<C-n>/<C-m>` 循环粘贴历史

---

### 13. AI 辅助插件

**Neovim 插件**:
- `zbirenbaum/copilot.lua`
- `CopilotC-Nvim/CopilotChat.nvim`
- `yetone/avante.nvim`
- `aweis89/aider.nvim`

**替代方案**:
- GitHub Copilot: 使用 `github/copilot.vim` (已配置)
- Copilot Chat: 无直接替代，可使用外部终端运行
- avante/aider: 无直接替代

---

### 14. nvim-tree 文件浏览器

**Neovim 插件**: `nvim-tree/nvim-tree.lua`

**替代方案**:
- 使用 NERDTree (已配置相同快捷键)
- `<leader>tt`: 切换文件树
- `<leader>tf`: 定位当前文件

---

### 15. Telescope 模糊搜索

**Neovim 插件**: `nvim-telescope/telescope.nvim`

**替代方案**:
- 使用 fzf.vim (已配置相同快捷键)

| Neovim 快捷键 | Vim 快捷键 | 功能 |
|--------------|-----------|------|
| `<leader>ff` | `<leader>ff` | 文件搜索 |
| `<leader>fg` | `<leader>fg` | 实时 grep |
| `<leader>fb` | `<leader>fb` | Buffer 内搜索 |
| `<leader>b` | `<leader>b` | Buffer 列表 |
| `<leader>fh` | `<leader>fh` | 帮助标签 |
| `<leader>*` | `<leader>*` | 搜索光标词 |
| `<C-p>` | `<C-p>` | 快速文件搜索 |

---

### 16. nvim-hardline 状态栏

**Neovim 插件**: `ojroques/nvim-hardline`

**替代方案**:
- 使用 vim-airline (已配置)
- Buffer 索引显示已启用

---

### 17. toggleterm 终端

**Neovim 插件**: `akinsho/toggleterm.nvim`

**原快捷键**: `<C-s>`

**替代方案**:
- 使用 vim-floaterm (已配置相同快捷键)

---

### 18. LazyDev Lua 开发

**Neovim 插件**: `folke/lazydev.nvim`

**说明**: Neovim Lua 开发辅助工具，Vim 中不需要。

---

### 19. lightbulb 代码动作提示

**Neovim 插件**: `kosayoda/nvim-lightbulb`

**说明**: 显示代码动作可用性的灯泡图标。

**替代方案**:
- coc.nvim 内置支持，光标处有代码动作时会显示

---

### 20. Substitute.nvim 替换操作

**Neovim 插件**: `gbprod/substitute.nvim`

**替代方案**:
- 使用 vim-subversive (已配置相同快捷键)

---

## 快捷键对照表

| 功能 | Neovim | Vim | 状态 |
|------|--------|-----|------|
| Leader 键 | `,` | `,` | 相同 |
| Buffer 切换 | `gt`/`gT` | `gt`/`gT` | 相同 |
| 窗口移动 | `<C-h/j/k/l>` | `<C-h/j/k/l>` | 相同 |
| 文件树 | `<leader>tt` | `<leader>tt` | 相同 |
| 定位文件 | `<leader>tf` | `<leader>tf` | 相同 |
| 文件搜索 | `<leader>ff` | `<leader>ff` | 相同 |
| 实时 grep | `<leader>fg` | `<leader>fg` | 相同 |
| Buffer 列表 | `<leader>b` | `<leader>b` | 相同 |
| 快速跳转 | `s` | `s` | 相同 (easymotion) |
| Treesitter 跳转 | `S` | - | 不可用 |
| 大纲视图 | `<C-w><C-e>` | `<C-w><C-e>` | tagbar 替代 |
| 跳转定义 | `gd` | `gd` | 相同 |
| 查看引用 | `gr` | `gr` | 相同 |
| 代码动作 | `<leader>ca` | `<leader>ca` | 相同 |
| 重命名 | `<leader>rn` | `<leader>rn` | 相同 |
| 替换操作 | `<leader>r` | `<leader>r` | 相同 |
| 注释 | `<leader>cc` | `<leader>cc` | 相同 |
| 终端切换 | `<C-s>` | `<C-s>` | 相同 |
| Buffer 索引 | `<A-1~9>` | `<A-1~9>` | 相同 |
| 翻译 | `<leader>ee` | `<leader>ee` | 相同 |
| Quickfix | `<leader>q` | `<leader>q` | 相同 |
| 清除高亮 | `<leader><CR>` | `<leader><CR>` | 相同 |
| 关闭其他buffer | `<leader>o` | `<leader>o` | 相同 |

---

## 安装说明

1. 确保 Vim 版本 >= 8.2 (支持 popup 窗口和异步操作)

2. 安装依赖:
   ```bash
   # Node.js (coc.nvim 需要)
   curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
   sudo apt install nodejs

   # fzf
   sudo apt install fzf ripgrep

   # 字体 (devicons 需要)
   # 安装 Nerd Font
   ```

3. 创建符号链接:
   ```bash
   ln -sf ~/.vim/vimrc ~/.vimrc
   ```

4. 启动 Vim 并安装插件:
   ```vim
   :PlugInstall
   ```

5. 安装 CoC 扩展:
   ```vim
   :CocInstall coc-json coc-tsserver coc-go coc-pyright coc-lua coc-snippets
   ```

---

## 性能注意事项

- Vim 的启动速度可能比 Neovim 配置的 lazy.nvim 慢
- 对于大文件，已配置自动禁用某些功能
- coc.nvim 需要 Node.js，可能消耗较多内存
