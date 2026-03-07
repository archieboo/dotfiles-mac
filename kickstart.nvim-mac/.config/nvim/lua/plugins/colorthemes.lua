return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    -- vim.cmd.colorscheme 'tokyonight-moon'

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=italic'
    -- local colors = require('tokyonight.colors').setup()
    -- end,
    config = function()
      require('tokyonight').setup {
        transparent = true,
      }
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    enabled = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
        vim.api.nvim_set_hl(0, 'NotifyBackground', { bg = '#ace1af' }),
        custom_highlights = function(colors)
          return {
            -- Comment = { fg = '#7b7974' },
          }
        end,
      }
    end,
  },
  {
    'olimorris/onedarkpro.nvim',
    enabled = true,
    -- init = function()
    --   vim.cmd.colorscheme 'onedark_vivid'
    -- end,
    config = function()
      require('onedarkpro').setup {
        colors = {
          -- red = '#f46f2a',
          cursorline = '#564760',
        },
        highlights = {
          Comment = { italic = true },
        },
        options = {
          cursorline = true,
          transparency = true,
          lualine_transparency = true,
          highlight_inactive_windows = true,
        },
        styles = {
          types = 'italic',
        },
      }
    end,
  },
  {
    'sainnhe/gruvbox-material',
    enabled = true,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_transparent_background = 2
      vim.g.gruvbox_material_dim_inactive_windows = 1
    end,
  },
  { 'projekt0n/github-nvim-theme', enabled = true },
  { 
    'rose-pine/neovim', 
    name = 'rose-pine',
    enabled = true,
    config = function()
      require('rose-pine').setup {
      }
    end,
  },
  { -- display color codes in the editor
    'NvChad/nvim-colorizer.lua',
    enabled = true,
    config = function()
      require('colorizer').setup {
        options = {
          parsers = {
            rgb = true; -- #RGB hex codes.
            hex = true; -- #RRGGBB hex codes.
            hsl = true; -- hsl() and hsla() functions.
            names = true; -- "Name" codes like Blue or BlueViolet.
            css = true; -- Enable all CSS features: rgb_fn, hsl_fn, names
            css_fn = true; -- Enable all CSS *functions*: rgb(), hsl(), etc.
            scss = true; -- Enable scss color function parsing.
          },
        },
      }
    end,
  },
}
