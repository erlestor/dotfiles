return {
  -- Disable plugins
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
  -- Configure existing plugins
  -- Try to do the bare minimum required. To rely on good defaults
  {
    "nvim-neo-tree/neo-tree.nvim",
    init = function() end,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        bind_to_cwd = false,
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
    opts = {
      options = {
        theme = "auto",
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
    -- This was my old options
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        ["*"] = {
          keys = {
            { "gd", false }, -- i have overwritten goto definition with nuxt_goto
            { "<S-k>", false }, -- i use gh instead for checking types
            {
              "<leader>rn",
              function()
                local inc_rename = require("inc_rename")
                return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
              end,
              expr = true,
              desc = "Rename (inc-rename.nvim)",
              has = "rename",
            },
          },
        },
        vtsls = {
          settings = {
            typescript = {
              tsserver = {
                -- if typescript is struggling in monorepos, try turning this number up
                -- allthough if the lsp needs so much ram for one project, something's broken
                maxTsServerMemory = 8192,
              },
            },
          },
        },
      },
    },
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
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = { enable = false }, -- I use guess-indent.nvim instead
      -- NOTE: always search for lazy extra before adding parsers here
      ensure_installed = {
        "scss",
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      search = {
        multi_window = false,
        -- max_length = 2,
        -- incremental = true,
      },
      highlight = {
        backdrop = false,
        matches = true,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = function()
      return {
        { "<S-j>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
        { "<S-k>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "onedarkpro",
  --   },
  -- },
}
