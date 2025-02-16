require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save with CTRL+S" })

-- Shift + j/k to go to places down/up
map("n", "<S-j>", "5j")
map("n", "<S-k>", "5k")

map("n", "gh", vim.lsp.buf.hover, { desc = "Show signature. Type etc." })

map("n", "gl", function()
	local bufnr, _ = vim.diagnostic.open_float()
	vim.api.nvim_buf_set_option(bufnr, "filetype", vim.o.filetype)
end, { desc = "Show diagnostic" })

-- move selected lines up and down with shift + j/k
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- stay centered when jumping half page with ctrl + d/u
-- or when going next/previous search result
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", '"_dP', { desc = "Paste over text without overriding register" })
-- these are currently done by default
-- copy to clipboard
map("n", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copy to clipboard" })
-- delete to clipboard
map("n", "<leader>d", '"_d', { desc = "Delete to clipboard" })
map("v", "<leader>d", '"_d', { desc = "Delete to clipboard" })

-- q is used for macros, but since I haven't learned to use them it's just annoying
map("n", "q", "nop")
map("n", "Q", "nop")

map(
	"n",
	"<leader>s",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "Replace each instane of the current word" }
)

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

-- SMART SPLITS
-- moving between splits
map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)
map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
-- resizing splits
map("n", "<C-S-A-h>", require("smart-splits").resize_left)
map("n", "<C-S-A-j>", require("smart-splits").resize_down)
map("n", "<C-S-A-k>", require("smart-splits").resize_up)
map("n", "<C-S-A-l>", require("smart-splits").resize_right)

-- TELESCOPE
map("n", "<leader>fl", require("telescope.builtin").resume, { desc = "telescope redo last search" })

-- COPILOT
map("n", "<leader>ct", require("copilot.suggestion").toggle_auto_trigger, { desc = "copilot toggle suggestions" })

-- COPILOT CHAT
map("n", "<leader>cc", ":CopilotChatOpen<CR>", { desc = "Copilot open chat" })

-- Buffers and dashboard
map("n", "<leader>bd", ":%bd<CR>", { desc = "Delete all buffers" })
map("n", "<leader>dd", ":Dashboard<CR>", { desc = "Open dashboard" })
map("n", "<leader>db", function()
	vim.cmd("%bd")
	vim.cmd("Dashboard")
end, { desc = "Delete buffers and open dashboard" })
