return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        transparent = true,
        on_colors = function(_) end,
        on_highlights = function(_, _) end,
      }
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
    config = function()
      vim.api.nvim_set_hl(0, 'NotifyBackground', { bg = '#ace1af' })
      require('catppuccin').setup {
        flavour = 'macchiato',
        transparent_background = true,
        styles = {
          comments = { 'italic' },
          keywords = { 'italic' },
        },
        custom_highlights = function(colors)
          return {
            CursorLine = { bg = colors.surface0 },
          }
        end,
      }
    end,
  },

  { 'projekt0n/github-nvim-theme' },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },

  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        options = {
          parsers = {
            rgb = true,
            hex = true,
            hsl = true,
            names = true,
            css = true,
            css_fn = true,
            scss = true,
          },
        },
      }
    end,
  },
}
