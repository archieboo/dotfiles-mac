return {
  { 'numToStr/Comment.nvim', opts = {} },

  { -- or show symbols in the current file as breadcrumbs
    'Bekaboo/dropbar.nvim',
    enabled = true,
    -- enabled = function()
    --   return vim.fn.has 'nvim-0.10' == 1
    -- end,
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      -- turn off global option for windowline
      vim.opt.winbar = nil
      vim.keymap.set('n', '<leader>ls', require('dropbar.api').pick, { desc = '[s]ymbols' })
    end,
  },
  { -- filetree
    'nvim-tree/nvim-tree.lua',
    enabled = true,
    keys = {
      { '<leader>b', ':NvimTreeToggle<cr>', desc = 'toggle nvim-tree' },
    },
    config = function()
      require('nvim-tree').setup {
        disable_netrw = true,
        renderer = {
          symlink_destination = false,
        },
        view = {
          float = {
            enable = false,
          },
        },
        filters = {
          dotfiles = true,
          custom = {
            '_freeze',
            'docs',
            '.*logs.*',
          },
        },
        filesystem_watchers = {
          ignore_dirs = {
            'code',
            'data',
            '.*log.*',
            '^_.+',
            '\\..+',
          },
        },
        update_focused_file = {
          enable = false,
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
        diagnostics = {
          enable = true,
        },
      }
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'echasnovski/mini.icons' },
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    opts = {
      options = {
        theme = 'auto',
        icons_enabled = true,
      },
    },
  },
  { -- make window bordoers colorful
    'nvim-zh/colorful-winsep.nvim',
    enabled = false,
    event = { 'WinLeave' },
    config = function()
      require('colorful-winsep').setup()
    end,
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = true, -- Recommended
    ft = { 'markdown', 'rmd', 'quarto' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    code_blocks = {
      style = 'minimal',
      icons = true,
      position = nil,
      min_width = 80,

      pad_amount = 1,
      pad_char = ' ',

      language_direction = 'left',
      language_names = {},

      hl = 'CursorLine',

      sign = true,
      sign_hl = nil,
    },
  },
  { -- fancier terminal
    'akinsho/toggleterm.nvim',
    opts = {},
    -- config = function()
    -- local trim_spaces = true
    -- vim.keymap.set('v', '<leader>tl', function()
    --   require('toggleterm').send_lines_to_terminal('single_line', trim_spaces, { args = vim.v.count })
    -- end)
    -- vim.keymap.set('v', '<leader>tb', function()
    --   require('toggleterm').send_lines_to_terminal('visual_selection', trim_spaces, { args = vim.v.count })
    -- end)
    -- end,
  },
  {
    'folke/noice.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      { 'MunifTanjim/nui.nvim', module = 'nui' },
      { 'rcarriga/nvim-notify', module = 'notify' },
    },
    config = function()
      require('noice').setup {
        routes = {
          {
            view = 'notify',
            filter = { event = 'msg_showmode' },
          },
        },
        background_colour = '#ace1af',
        cmdline = {
          enabled = true,
          view = 'cmdline_popup',
        },
        messages = {
          enabled = true,
        },
        popupmenu = {
          enabled = true,
        },
        notify = {
          enabled = true,
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          -- command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  -- UI configuration as a separate table inside the returned table
  ui = {
    -- If you are using a Nerd Font, set icons to an empty table to use the default lazy.nvim Nerd Font icons
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}
