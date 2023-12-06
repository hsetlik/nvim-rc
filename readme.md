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

## Plugins

The config is all written in Lua and the plugins are managed by [Lazy](https://github.com/folke/lazy.nvim)

## Keymaps

### Window Splitting

- "<leader>sv": Split window vertically
- "<leader>sx": Close split window

### File Tree

- "<leader>e": Toggle file tree
- "a": Create file
- "r": Rename file
- "d": Delete file

### Fuzzy Finding

- "<leader>ff": Search for files in cwd
- "<leader>fr": Search for recent files
- "<leader>fs": Search for string in cwd
- "<leader>fc": Search for string under cursor in cwd

### CMake

- "<leader>cg": CMakeGenerate
- "<leader>cB": Select build target
- "<leader>cb": Build current target
- "<leader>cR": Select run target
- "<leader>cr": Run current target

### Git

- "<leader>gA": Stage all changes
- "<leader>gs": View git status info
- "<leader>gc": Commit
- "<leader>gp": Push
- "<leader>gd": View diff of current file
