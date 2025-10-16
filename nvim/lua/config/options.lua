-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

-- Disable prettier if not config file is found
vim.g.lazyvim_prettier_needs_config = false

-- relative line numbers as default
vim.opt.relativenumber = true

-- Reccommended by rmgatti/auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
