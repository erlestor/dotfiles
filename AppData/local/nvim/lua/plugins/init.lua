return {
	-- customize plugins
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
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
		version = "*", -- for stability?
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- customize config here
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				filters = {
					git_ignored = false,
					dotfiles = false,
					custom = {},
				},
				renderer = {
					root_folder_label = function(_)
						return "  .."
					end,
				},
			})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	-- doesn't work. if it works these are all defaults and can be deleted
	-- {
	-- 	"catgoose/vue-goto-definition.nvim",
	-- 	event = "BufReadPre",
	-- 	opts = {
	-- 		filters = {
	-- 			auto_imports = true,
	-- 			auto_components = true,
	-- 			import_same_file = true,
	-- 			declaration = true,
	-- 			duplicate_filename = true,
	-- 		},
	-- 		filetypes = { "vue", "typescript" },
	-- 		detection = {
	-- 			nuxt = function()
	-- 				return vim.fn.glob(".nuxt/") ~= ""
	-- 			end,
	-- 			vue3 = function()
	-- 				return vim.fn.filereadable("vite.config.ts") == 1 or vim.fn.filereadable("src/App.vue") == 1
	-- 			end,
	-- 			priority = { "nuxt", "vue3" },
	-- 		},
	-- 		lsp = {
	-- 			override_definition = true, -- override vim.lsp.buf.definition
	-- 		},
	-- 		debounce = 200,
	-- 	},
	-- },
	-- also doesn't work
	-- {
	-- 	"rushjs1/nuxt-goto.nvim",
	-- 	ft = "vue",
	-- },
	{
		"rmagatti/auto-session",
		lazy = false,
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},
	-- i think this works out of the box so im super confused
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
	},
	-- doesnt work rn
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
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	-- dont think this shit works
	-- {
	--   "nmac427/guess-indent.nvim",
	--   config = function()
	--     require("guess-indent").setup {}
	--   end,
	-- },
	-- markdown preview
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- smart splits. to switch panes seamlessly between wezterm and neovim
	{ "mrjones2014/smart-splits.nvim", event = "VimEnter" },
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},
	-- TODO highlighter
	-- Didnt work
	-- TODO: hei
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	-- noice.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
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
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},
	-- copilot.lua
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					keymap = {
						accept = "<C-y>",
					},
				},
			})
		end,
	},
}
