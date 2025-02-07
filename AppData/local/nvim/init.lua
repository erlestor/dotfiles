-- disable netrw. recommended by nvim-tree for conflicts
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- sync terminal background color with neovim
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if not normal.bg then
			return
		end
		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
	end,
})

vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
	end,
})

-- restore cursor position on file open
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line > 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})

-- dunno
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
	},

	{ import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("options")
require("nvchad.autocmds")

vim.schedule(function()
	require("mappings")
end)

-- relative line numbers as default
vim.opt.relativenumber = true

-- override commentstring for typescript to add a space
vim.api.nvim_create_autocmd("FileType", {
	pattern = "typescript",
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

-- override nvim-tree cursor and cursorline highlight groups
-- this is kinda bad. CursorLine is the only thing that worked, but that is used elsewhere (probably)
vim.cmd([[
  "hi NvimTreeCursorLine guibg=#3a3a3a gui=NONE
  hi CursorLine guibg=#5a5a5a gui=NONE
  "hi NvimTreeCursor guifg=NONE guibg=NONE gui=NONE
]])

-- hide cursor in nvim-tree
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	pattern = "NvimTree*",
	callback = function()
		local def = vim.api.nvim_get_hl_by_name("Cursor", true)
		vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 100 }))
		vim.opt.guicursor:append("a:Cursor/lCursor")
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinClosed" }, {
	pattern = "NvimTree*",
	callback = function()
		local def = vim.api.nvim_get_hl_by_name("Cursor", true)
		vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 0 }))
		vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
	end,
})
