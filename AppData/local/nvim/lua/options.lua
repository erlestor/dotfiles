require("nvchad.options")

local o = vim.o

-- o.cursorlineopt = "both" -- to enable cursorline in editor!
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- relative line numbers as default
vim.opt.relativenumber = true
