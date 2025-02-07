return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- only modules listed here are actually loaded
			notifier = {},
			lazygit = {
				os = {
					-- the default just doesn't work on windows smh
					editCommand = 'cmd /c if "%NVIM%"=="" (nvim -- %s) else (nvim --server %NVIM% --remote-send q && nvim --server %NVIM% --remote-tab %s)',
				},
			},
		},
		keys = {
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
					-- Snacks.lazygit.open()
				end,
				desc = "Lazygit",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("configs.conform"),
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"vue",
				"dockerfile",
				"python",
				"json",
				"yaml",
				"toml",
				"tsx",
				"regex",
				"bash",
				"markdown",
				"markdown_inline",
			},
		},
	},
	{
		"ggandor/leap.nvim",
		event = "VimEnter",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				filters = {
					git_ignored = false,
					dotfiles = false,
					custom = { "^.git$" },
				},
				renderer = {
					root_folder_label = function(_)
						return "  .."
					end,
				},
				view = {
					cursorline = true,
				},
			})
		end,
	},
	-- renaming doesn't work rn
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		dependencies = "nvim-treesiter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({
				enable_close_on_slash = false,
			})
		end,
	},
	-- only some functions are working :(
	{
		"dinhhuy258/git.nvim",
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- to switch panes seamlessly between wezterm and neovim
	{ "mrjones2014/smart-splits.nvim", event = "VimEnter" },
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<C-y>",
					},
				},
			})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "doom",
				config = {
					center = {
						{
							icon = " ",
							desc = "Find File",
							key = "f",
							key_hl = "Number",
							key_format = " %s",
							action = "Telescope find_files",
						},
						{
							icon = " ",
							desc = "Find Text",
							key = "w",
							key_hl = "Number",
							key_format = " %s",
							action = "Telescope live_grep",
						},
						{
							icon = " ",
							desc = "New File",
							key = "n",
							key_hl = "Number",
							key_format = " %s",
							action = "ene | startinsert",
						},
						{
							icon = " ",
							desc = "Restore Session",
							key = "r",
							key_hl = "Number",
							key_format = " %s",
							action = "SessionRestore",
						},
						{
							icon = " ",
							desc = "Browse Sessions",
							key = "s",
							key_hl = "Number",
							key_format = " %s",
							action = "SessionSearch",
						},
						{
							icon = "󰒲 ",
							desc = "Lazy",
							key = "l",
							key_hl = "Number",
							key_format = " %s",
							action = "Lazy",
						},
						{
							icon = " ",
							desc = "Quit",
							key = "q",
							key_hl = "Number",
							key_format = " %s",
							action = "qa",
						},
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		},
	},
}
