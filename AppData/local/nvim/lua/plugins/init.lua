return {
	-- UI Enhancements
	{
		"willothy/flatten.nvim",
		config = true,
		lazy = false,
		priority = 1001,
		opts = {
			integrations = {
				wezterm = true,
			},
			window = { open = "smart" },
			hooks = {
				pre_open = function()
					-- Check if the lazygit window is open and close it
					local lazygit_buf = vim.fn.bufnr("lazygit")
					if lazygit_buf ~= -1 then
						-- avoids notifications but has weird effects
						-- require("snacks.lazygit")()
						vim.api.nvim_buf_delete(lazygit_buf, { force = true })
					end
				end,
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {
			"willothy/flatten.nvim",
		},
		---@type snacks.Config
		opts = {
			notifier = {},
			lazygit = {
				configure = true,
				config = {
					os = { editPreset = "" },
				},
			},
		},
		keys = {
			{
				"<leader>nd",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<leader>nn",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification history",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
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

	-- LSP and Autocompletion
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"hrsh7th/cmp-cmdline",
				event = "CmdlineEnter",
				config = function()
					local cmp = require("cmp")

					cmp.setup.cmdline("/", {
						mapping = cmp.mapping.preset.cmdline(),
						sources = {
							{ name = "buffer" },
						},
					})

					cmp.setup.cmdline(":", {
						mapping = cmp.mapping.preset.cmdline(),
						sources = cmp.config.sources({
							{ name = "path" },
						}, {
							{
								name = "cmdline",
								option = {
									ignore_cmds = { "Man", "!" },
								},
							},
						}),
					})
				end,
			},
		},
	},

	-- Treesitter and Syntax Highlighting
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
		"windwp/nvim-ts-autotag",
		lazy = false,
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({
				enable_close_on_slash = false,
			})
		end,
	},

	-- Utility Plugins
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("configs.conform"),
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
				update_focused_file = { enable = true, exclude = false },
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		event = "VimEnter",
	},
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
		"rmagatti/auto-session",
		lazy = false,
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		},
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.splitjoin",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.splitjoin").setup()
		end,
	},
	{
		"filipdutescu/renamer.nvim",
		event = "BufEnter",
		branch = "master",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("renamer").setup()
		end,
	},
	{
		-- testing custom nuxt-goto plugin
		-- dir = "~/Documents/Koding/neovim-plugins/nuxt-goto.nvim",
		"erlestor/nuxt-goto.nvim",
		branch = "monorepo-support",
		ft = "vue",
		event = "BufEnter",
		opts = {
			check_directories = { "/apps/web" },
		},
	},

	-- Copilot
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
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		opts = {},
	},
}
