local custom_theme = require("lualine.themes.ayu_mirage")
custom_theme.normal.c.bg = "NONE" -- Makes section c transparent in normal mode

return {
  { "mrjones2014/smart-splits.nvim" },
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      bypass_save_filetypes = { "neo-tree", "dashboard", "snacks_dashboard" },
      -- log_level = 'debug',
    },
  },
  -- pretty-ts-errors.lua
  -- sick. but doesn't work in vue files
  -- i can install render-markdown.nvim to make even more pretty
  -- {
  --   {
  --     "youyoumu/pretty-ts-errors.nvim",
  --     opts = {
  --       -- your configuration options
  --       auto_open = false,
  --     },
  --   },
  -- },
  {
    "erlestor/nuxt-goto.nvim",
    branch = "monorepo-support",
    ft = "vue",
    event = "BufEnter",
    -- Enable for dev
    -- "nuxt-goto.nvim",
    -- dir = "~/Documents/nuxt-goto.nvim",
    -- lazy = false,
  },
  -- Actual working auto indent with "o" and "enter"
  {
    "nmac427/guess-indent.nvim",
    event = "BufEnter",
    config = function()
      require("guess-indent").setup({})
    end,
  },
}
