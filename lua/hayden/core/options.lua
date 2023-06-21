local opt = vim.opt
opt.relativenumber = true
opt.number = true

-- tabs and indentations
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- this just matches the dash as part of the word for commands using 'w' and 'W'
-- useful for renaming files and writing really shitty Python
opt.iskeyword:append("-")
