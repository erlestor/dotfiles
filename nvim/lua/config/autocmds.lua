-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Bind go-to-definition with correct options for nuxt-goto.nvim
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- the buffer where the lsp attached
    ---@type number
    local buffer = args.buf

    --set keybind for go to definition
    local opts = { noremap = true, silent = true, buffer = buffer }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end,
})

-- Disable spellchecking
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = false
  end,
})
