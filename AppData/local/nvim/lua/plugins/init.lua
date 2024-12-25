return {
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
				"tsx",
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
	{
		"catgoose/vue-goto-definition.nvim",
		event = "BufReadPre",
		opts = {
			filters = {
				auto_imports = true,
				auto_components = true,
				import_same_file = true,
				declaration = true,
				duplicate_filename = true,
			},
			filetypes = { "vue", "typescript" },
			detection = {
				nuxt = function()
					return vim.fn.glob(".nuxt/") ~= ""
				end,
				vue3 = function()
					return vim.fn.filereadable("vite.config.ts") == 1 or vim.fn.filereadable("src/App.vue") == 1
				end,
				priority = { "nuxt", "vue3" },
			},
			lsp = {
				override_definition = true, -- override vim.lsp.buf.definition
			},
			debounce = 200,
		},
	},

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
	-- {
	-- 	"folke/todo-comments.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	opts = {
	-- 		-- your configuration comes here
	-- 		-- or leave it empty to use the default settings
	-- 		-- refer to the configuration section below
	-- 	},
	-- },
}
