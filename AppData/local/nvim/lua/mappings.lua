require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Ctrl+S to save no amtter the mode
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Shift + j/k to go to places down/up
map("n", "<S-j>", "5j")
map("n", "<S-k>", "5k")

-- signature (eg. see type of something in typescript with gh)
map("n", "gh", vim.lsp.buf.hover)

-- move selected lines up and down with shift + j/k
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- step centered when jumping half page with ctrl + d/u
-- or when going next/previous search result
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- paste over text without overriding register with deleted text
map("x", "<leader>p", '"_dP')

-- copy to clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- delete to clipboard
map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

-- q is used for macros, but since I haven't learned to use them it's just annoying
-- map("n", "q", "nop")
map("n", "Q", "nop")

-- replace each instance of the word you're on
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- show diagnostics (error) window
map("n", "gl", function()
	local bufnr, _ = vim.diagnostic.open_float()
	vim.api.nvim_buf_set_option(bufnr, "filetype", vim.o.filetype)
end)

-- open lazygit
map("n", "<leader>gg", ":LazyGit<CR>")

-- simpler go to start or end of line
map("n", "H", "^")
map("n", "L", "$")

-- Smart insert in blank line (auto indent)
map("n", "i", function()
	if #vim.fn.getline(".") == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true })

-- better indenting. keep selection after indent so i can spam
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Resize window using <ctrl> arrow keys
-- only works temporary. if i say hide a terminal it will reset in size
-- but to fix that i probably need a plugin
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- rename variable
map("n", "<leader>r", vim.lsp.buf.rename)

-- SMART SPLITS
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
-- dont know if i should use M or A for alt key
vim.keymap.set("n", "<C-S-A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<C-S-A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<C-S-A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<C-S-A-l>", require("smart-splits").resize_right)
