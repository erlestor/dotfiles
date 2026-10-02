-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-------------------------- SMART SPLITS WEZTERM AND TMUX --------------------------
-- doesnt even work aha. probably my tmux config or alacritty config tho

map("n", "<C-S-M-h>", require("smart-splits").resize_left)
map("n", "<C-S-M-j>", require("smart-splits").resize_down)
map("n", "<C-S-M-k>", require("smart-splits").resize_up)
map("n", "<C-S-M-l>", require("smart-splits").resize_right)
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

map("n", "<leader>rn", "<leader>cr", { desc = "Rename variable" })

-------------------------- HOVER AND DIAGNOSTICS --------------------------
map("n", "gh", function()
  require("noice.lsp").hover()
end, { desc = "Show signature. Type etc." })
map("n", "gl", vim.diagnostic.open_float)

-------------------------- EDITING --------------------------
-- stay centered when jumping half page with ctrl + d/u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- and when going next/previous search result
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

--  Paste over text without overriding register
map("x", "p", '"_dP', { desc = "Paste over text without overriding register by default" })

-- Disable macros
map("n", "q", "nop")
map("n", "Q", "nop")

-- simpler go to start or end of line
map("n", "H", "^")
map("n", "L", "$")

-- keep selection after indent so i can spam
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Smart insert in blank line (auto indent)
map("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })
map("n", "a", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "a"
  end
end, { expr = true })

-- Basically snippets
map("v", "<leader>lg", 'yoconsole.log("<esc>pa:", <esc>pa)<esc>', { desc = "Add console.log" })

-------------------------- BUFFERS --------------------------
map("n", "<leader>x", function()
  Snacks.bufdelete()
end, { desc = "Delete current buffer" })
-- map("n", "<leader>x", bufremove, { desc = "Delete current buffer" })
map("n", "<leader>bd", "<cmd>%bd<CR>", { desc = "Delete all buffers" })

-- Quit faster
map("n", "<leader>q", ":qa<CR>")

-------------------------- TELESCOPE --------------------------
map("n", "<leader>fl", require("telescope.builtin").resume, { desc = "telescope redo last search" })
map("n", "<leader>ff", LazyVim.pick("files", { root = false }), { desc = "Find Files (cwd)" })
map("n", "<leader>fw", LazyVim.pick("live_grep", { root = false }), { desc = "Grep (cwd)" })
map("v", "<leader>fw", function()
  vim.cmd('normal! "fy')
  require("telescope.builtin").live_grep({
    default_text = vim.fn.getreg('"f'),
    root = false,
  })
end, { desc = "Grep selection (cwd)" })
