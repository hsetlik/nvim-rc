# Hayden's Neovim RC

If you want to use this config, clone this repo inside the `~/.config` directory on macOS. Make sure that the top level folder just inside `~/.config` is called `nvim`.

My setup is based largely on [these videos by Josean Martinez](https://www.youtube.com/playlist?list=PLnu5gT9QrFg36OehOdECFvxFFeMHhb_07)

## Features

In making the move from VSCode to Neovim, I wanted to take advantage of Neovim's performance, extensibility, and keyboard based workflow without losing the user-friendly bells and whistles of VSCode. For the sort of work I do, I decided on this list of features I would need

- Fuzzy finder
- File tree
- Git commands and diff view
- Basic programming text utilities (indentation, automatically adding the closing `)` or `}`, etc.)
- Auto-complete with full LSP support
- Ability to run CMake configure and build commands from inside the editor

## Keymap Cheat Sheet

### Window Splitting and Tabs

- "`leader`sv": Split window vertically
- "`leader`sx": Close split window
- "`leader`x": Close current tab
- "`leader`xo": Close all other tabs
- "`leader`=": Next tab
- "`leader`-": Previous tab

### Comments

- "gcc": Toggle current line as single-line comment
- "gbc": Toggle current line as multi-line comment
- "gc": Toggle selection as single-line
- "gb": Toggle selection as multi-line
- "gco": Insert comment on previous line
- "gcO": Insert comment on next line
- "gcA": Insert comment at the end of the current line

### File Tree

- "`leader`e": Toggle file tree
- "`leader`ec": Show current file in tree
- "`Ctrl`t": Open selected result in new tab
- "a": Create file
- "r": Rename file
- "d": Delete file

### Fuzzy Finding

- "`leader`ff": Search for files in cwd
- "`leader`fr": Search for recent files
- "`leader`fs": Search for string in cwd
- "`leader`fc": Search for string under cursor in cwd
- "`Ctrl`t": Open selected result in new tab
- "`Ctrl`v": Open selected result in vertical split

### LSP

- "gR": Show references in Telescope
- "gd": Jump to declaration
- "gD": Show declaration in Telescope
- "gi": Show implementations in Telescope
- "gt": Show type definitions in Telescope
- "`leader`ca": Show available code actions
- "`leader`rn": Smart rename
- "`leader`D": Show buffer diagnostics in Telescope
- "`leader`d": Show line diagnostics in Telescope
- "[d": Jump to previous diagnostic
- "]d": Jump to next diagnostic
- "K": Show documentation for symbol under cursor if available
- "`leader`rs": Restart LSP

### Debugging

- "<F9>": Toggle breakpoint at current line
- "<F1>": Expand object under cursor
- "<F5>": Continue
- "<F4>": Terminate debugger
- "<F10>": Step over
- "<F11>": Step into
- "<F12>": Step out
- "`leader`ds": Show current debugger scopes

### CMake

- "`leader`cg": CMakeGenerate
- "`leader`cB": Select build target
- "`leader`cb": Build current target
- "`leader`cR": Select run target
- "`leader`cr": Run current target
- "`leader`cd": Debug current target

### Git

- "`leader`gA": Stage all changes
- "`leader`gs": View git status info
- "`leader`gc": Commit
- "`leader`gp": Push
- "`leader`gd": View diff of current file

### Formatting

- "`leader`fm": Format current file or selection

## Plugins

The config is all written in Lua and the plugins are managed by [Lazy](https://github.com/folke/lazy.nvim)
The current set of plugins installed:

- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim): An IDE-like file tab bar along the editor's top edge
- [cmake-tools.nvim](https://github.com/Civitasv/cmake-tools.nvim): CMake configure/build integration for Neovim. Similar to the VSCode plugin of the same name.
- [vim-nightfly-colors](https://github.com/bluz71/vim-nightfly-colors): A nice color scheme
- [conform.nvim](https://github.com/stevearc/conform.nvim): Handles all things formatting and formatters
- [fugitive.vim](https://github.com/tpope/vim-fugitive): All the git integration you'll ever want
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Shows the git status of each line along the left edge of the editor
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): Easy-to-customize bottom status bar
- [mason.nvim](https://github.com/williamboman/mason.nvim): Package manager for language servers, linters, and formatters
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs): You'll never guess what this does
- [nvim-dap](https://github.com/mfussenegger/nvim-dap): Plugin for debugging within neovim
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Lua-based autocompletion plugin
- [nvim-lint](https://github.com/mfussenegger/nvim-lint): Linting plugin that plays nice with LSP
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Manages and configures LSP
- [nvim-surround](https://github.com/kylechui/nvim-surround): Neat utilities for delimiter pairs (quotes, brackets, HTML tags, etc)
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua): File tree of choice
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Treesitter
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Fuzzy finder and search interface
