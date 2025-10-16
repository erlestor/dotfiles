-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- SMART SPLITS WEZTERM
map("n", "<A-h>", require("smart-splits").resize_left)
map("n", "<A-j>", require("smart-splits").resize_down)
map("n", "<A-k>", require("smart-splits").resize_up)
map("n", "<A-l>", require("smart-splits").resize_right)
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

-- VIBE CODE start
-- It's suprisingly fast. Because it always reaches the limit
-- Move current buffer to first position
function MoveBufferToFirst()
  -- Keep moving previous until we reach the beginning
  local i = 0
  while i < 50 do
    vim.cmd("BufferLineMovePrev")
    -- Check if we can still move previous (you might need to adjust this condition)
    local success = pcall(vim.cmd, "BufferLineMovePrev")
    if not success then
      break
    end
    i = i + 1
  end
  if i == 49 then
    vim.cmd("echo Moving buffer failed")
  end
end

-- Move current buffer to second position
function MoveBufferToSecond()
  -- First move to first position
  MoveBufferToFirst()
  -- Then move next once to get to second position
  vim.cmd("BufferLineMoveNext")
end

-- Move current buffer to last position
function MoveBufferToLast()
  -- Keep moving next until we reach the end
  local i = 0
  while i < 50 do
    vim.cmd("BufferLineMoveNext")
    -- Check if we can still move next (you might need to adjust this condition)
    local success = pcall(vim.cmd, "BufferLineMoveNext")
    if not success then
      break
    end
    i = i + 1
  end
  if i == 49 then
    vim.cmd("echo Moving buffer failed")
  end
end

-- Move current buffer to second-to-last position
function MoveBufferToSecondLast()
  -- First move to last position
  MoveBufferToLast()
  -- Then move previous once to get to second-to-last position
  vim.cmd("BufferLineMovePrev")
end
-- VIBE CODE end

-- HARPOON
local harpoon = require("harpoon")
-- vim.keymap.set("n", "<C-j>", function()
vim.keymap.set("n", "<Leader>j", function()
  harpoon:list():select(1)
  MoveBufferToFirst()
end)
vim.keymap.set("n", "<Leader>k", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<Leader>l", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<Leader>ø", function()
  harpoon:list():select(4)
end)

-- Better binds for hover and diagnostics
map("n", "gh", function()
  require("noice.lsp").hover()
end, { desc = "Show signature. Type etc." })
map("n", "gl", vim.diagnostic.open_float)

-- stay centered when jumping half page with ctrl + d/u
-- or when going next/previous search result
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", '"_dP', { desc = "Paste over text without overriding register" })

-- q is used for macros, but since I haven't learned to use them it's just annoying
map("n", "q", "nop")
map("n", "Q", "nop")

-- simpler go to start or end of line
-- TODO: add these somehow. Right now tabs are used by shift+hl
-- map("n", "H", "^")
-- map("n", "L", "$")

-- better indenting. keep selection after indent so i can spam
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

-- COPILOT
-- TODO: add these for whatever autocomplete lazyvim useses
-- map("n", "<leader>ct", require("copilot.suggestion").toggle_auto_trigger, { desc = "copilot toggle suggestions" })
-- map("n", "<leader>cc", ":CopilotChatOpen<CR>", { desc = "Copilot open chat" })

-- Buffers
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Delete current buffer" })
map("n", "<leader>bd", "<cmd>%bd<CR>", { desc = "Delete all buffers" })

-- Quit faster
map("n", "<leader>q", ":qa<CR>")

-- Basically snippets
map("v", "<leader>lg", 'yoconsole.log("<esc>pa:", <esc>pa)<esc>', { desc = "Add console.log" })

-- TELESCOPE
map("n", "<leader>fl", require("telescope.builtin").resume, { desc = "telescope redo last search" })
map("n", "<leader>fw", LazyVim.pick("live_grep"), { desc = "Grep (Root Dir)" })
map("v", "<leader>fw", function()
  vim.cmd('normal! "fy')
  require("telescope.builtin").live_grep({
    default_text = vim.fn.getreg('"f'),
  })
end, { desc = "Grep selection (Root Dir)" })
