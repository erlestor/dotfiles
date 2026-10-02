-- Omarchy default. Doesn't work on mac so.. fuck it. never used it either
require("config.remote_clipboard").setup()

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Disable prettier if not config file is found
vim.g.lazyvim_prettier_needs_config = false

-- relative line numbers as default
vim.opt.relativenumber = true

-- Reccommended by rmgatti/auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Always use cwd for lazyvim project detection
-- i guess since im aways opening projects in cwd it should be fine, but idk why i added this
-- maybe nuxt goto?
vim.g.root_spec = { "cwd" }
