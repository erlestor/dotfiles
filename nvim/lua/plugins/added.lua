local custom_theme = require("lualine.themes.ayu_mirage")
custom_theme.normal.c.bg = "NONE" -- Makes section c transparent in normal mode

-- NOTE: remember to set lazy load settings

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
