# Hayden's Neovim RC

If you want to use this config, clone this repo inside the `~/.config` directory on macOS. Make sure that the top level folder just inside `~/.config` is called `nvim`.

My setup is based on [this video](https://www.youtube.com/watch?v=vdn_pKJUda8&t=2294s) by Josean Martinez, I've only changed a handful of key bindings and added a few plugins and LSP servers for my specific needs.

## Features

In making the move from VSCode to Neovim, I wanted to take advantage of Neovim's performance, extensibility, and keyboard based workflow without losing the user-friendly bells and whistles of VSCode. For the sort of work I do, I decided on this list of features I would need

- Fuzzy finder
- File tree
- Git commands and diff view
- Basic programming text utilities (indentation, automatically adding the closing `)` or `}`, etc.)
- Auto-complete with full LSP support
- Ability to run CMake configure and build commands from inside the editor

## Plugins

The config is all written in Lua and the plugins are managed by [packer](https://github.com/wbthomason/packer.nvim). Plugins are added and managed in `lua/hayden/plugins-setup.lua` and their setup and options are handled in the lua files in the `lua/hayden/plugins` folder. The details are obvious enough from reading the code, but to give a brief overview of the plugins being used

- "tpope/vim-surround": Key bindings for dealing with quotes, parentheses, etc
- "nvim-lua/plenary.nvim": Lua utilities used by other plugins
- "bluz71/vim-nightfly-guicolors": Color theme
- "nvim-tree/nvim-tree.lua": File tree
- "kyazdani42/nvim-web-devicons": IDE-like icons (mostly for file tree)
- "nvim-lualine/lualine.nvim": Status line
- "nvim-telescope/telescope-fzf-native.nvim": Fuzzy finder
- "hrsh7th/nvim-cmp": Autocomplete
- "hrsh7th/cmp-buffer": Autocomplete from buffers
- "hrsh7th/cmp-path": Autocomplete from system paths
- "L3MON4D3/LuaSnip": Snippets engine
- "saadparwaiz1/cmp_luasnip": Snippets in autocomplete
- "rafamadriz/friendly-snippets": Just some useful snippets
- "williamboman/mason.nvim": Main LSP managment plugin
- "neovim/nvim-lspconfig": For configuring LSP servers
- "williamboman/mason-lspconfig.nvim": Links Mason with lspconfig
- "hrsh7th/cmp-nvim-lsp": Allows LSP to show up in autocomplete
- "jose-elias-alvarez/null-ls.nvim": formatting/linting
- "jayp0521/mason-null-ls.nvim": lets null-ls work with LSP via Mason
- "Civitasv/cmake-tools.nvim": CMake utilities, similar to the VSCode plugin of the same name
- "nvim-treesitter/nvim-treesitter": Syntax highlighting
- "windwp/nvim-autopairs": Automatically add `)`, `}`, `"`, etc.
- "windwp/nvim-ts-autotag": Same as above for xml tags
- "lewis6991/gitsigns.nvim": Color-codes git changes along left edge of the editor
- "NeogitOrg/neogit": Git popup menus
- "sindrets/diffview.nvim": Git diff view

## Key Bindings

All the custom key bindings are set in `lua/hayden/core/keymaps.lua`. The "\<leader\>" key used to preface many of the commands below can be set to any key that doesn't already have a binding in normal mode. By default, this config uses the space bar.

### Window Navigation

- "\<leader\>sv": open a new vertical editor window
- "\<leader\>sx": close the current editor window
- "\<leader\>e": toggle the file tree on/off

### Fuzzy Finding

- "\<leader\>ff": search for file name
- "\<leader\>fs": search for a string in the current directory
- "\<leader\>fc": search for the string under the cursor in the current directory
- "\<leader\>fb": list currently open buffers
- "\<leader\>fh": show Telescope help tags

### CMake

- "\<leader\>cg": start configure on current CMakeLists.txt
- "\<leader\>bm": switch between build configurations (i.e. Debug and Release mode)
- "\<leader\>cx": cancel current CMake task
- "\<leader\>ct": select the build target
- "\<leader\>cr": run current target
- "\<leader\>cb": build current target

### Git

- "\<leader\>gc": open git commit dialog
- "\<leader\>gb": open git branch dialog
- "\<leader\>gm": open git merge dialog
- "\<leader\>gp": open git pull dialog
- "\<leader\>gP": open git push dialog

### LSP

**Important:** unlike all of the above, LSP key bindings are set up in `lua/hayden/plugins/lsp/lspconfig.lua`

- "gf": show definition and references in popup
- "gD": jump to declaration
- "gd": jump to definition
- "gi": jump to implementation
- "\<leader\>ca": see available code actions for current line
- "\<leader\>rs": rename symbol (Editor's Note: this is the most useful key binding I've ever used in any text editor. It's also much faster than smart renaming in a heavy IDE.)
- "\<leader\>D": see diagnostics for current line
- "\<leader\>d": see diagnostics for symbol under cursor
- "[d": jump to previous diagnostic
- "]d": jump to next diagnostic
- "K": show popup with documentation for symbol under cursor

## LSP Servers

LSP servers are installed and managed by "mason" and "mason-lspconfig". [The readme](https://github.com/williamboman/mason-lspconfig.nvim) from mason-lspconfig's github page has a full list of available servers, these are the ones I have installed

- "clangd": C++
- "cmake": CMake
- "tsserver": TypeScript
- "lua_ls": Lua
- "html": HTML
