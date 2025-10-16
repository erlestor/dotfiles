local custom_theme = require("lualine.themes.ayu_mirage")
custom_theme.normal.c.bg = "NONE" -- Makes section c transparent in normal mode

return {
  -- Configure existing plugins
  -- I try to do the bare minimum required. To rely on good defaults
  {
    "nvim-neo-tree/neo-tree.nvim",
    init = function() end,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = true,
          bind_to_cwd = true,
        },
      },
      window = {
        width = 35,
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
            hl.blend = 100
            vim.api.nvim_set_hl(0, "Cursor", hl)
            vim.opt.guicursor:append("a:Cursor/lCursor")
            vim.cmd("hi NeoTreeCursorLine guibg=#494D59 gui=NONE")
          end,
        },
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
            hl.blend = 0
            vim.api.nvim_set_hl(0, "Cursor", hl)
            vim.opt.guicursor:remove("a:Cursor/lCursor")
          end,
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    -- enabled = false,
    opts = {
      options = {
        theme = "auto",
        -- theme = custom_theme,
      },
      sections = {
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    -- I downgraded vue-language-server with:
    -- :MasonInstall vue-language-server@2.2.8
    -- before it was: vue-language-server 3.1.0.
    -- and that fixed my lsp crashing in deploii repo
    ---@class PluginLspOpts
    -- opts = {
    --   servers = {
    --     vtsls = {
    --       settings = {
    --         typescript = {
    --           tsserver = {
    --             -- if typescript is struggling in monorepos
    --             -- try turning this number up
    --             -- allthough if the lsp needs so much ram for one project, something's broken
    --             maxTsServerMemory = 8192,
    --           },
    --         },
    --       },
    --     },
    --   },
    -- },
    -- THIS WORKS BUT WITH ERROR
    opts = function(_, opts)
      -- opts.servers.vtsls.settings.typescript.tsserver.maxTsServerMemory = 8192
      table.insert(opts.servers.vtsls.settings.typescript, { tsserver = { maxTsServerMemory = 8192 } })
      opts.inlay_hints.enabled = false

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "gd", false }
      -- another bind for <leader>cr
      keys[#keys + 1] = {
        "<leader>rn",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename (inc-rename.nvim)",
        has = "rename",
      }
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        -- inc_rename = true, -- enables an input dialog for inc-rename.nvim
        -- lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      views = {
        hover = {
          border = {
            style = "rounded", -- Other options: "none", "single", "double", "rounded", "solid", "shadow"
            padding = { 0, 0 },
          },
          position = { row = 2 },
        },
        popup = {
          border = {
            style = "rounded", -- Other options: "none", "single", "double", "rounded", "solid", "shadow"
            padding = { 0, 0 },
          },
          position = { row = 2 },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        -- winblend = 0,
      },
    },
  },
  {
    "render-markdown.nvim",
    enabled = false,
  },
  -- Add new plugins
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
}
