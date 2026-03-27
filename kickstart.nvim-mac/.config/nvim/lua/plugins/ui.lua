return {
  {
    'Bekaboo/dropbar.nvim',
    dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' },
    config = function()
      vim.opt.winbar = nil
      vim.keymap.set('n', '<leader>ls', require('dropbar.api').pick, { desc = '[s]ymbols' })
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
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
          float = { enable = false },
        },
        filters = {
          dotfiles = true,
          custom = { '_freeze', 'docs', '.*logs.*' },
        },
        filesystem_watchers = {
          ignore_dirs = { 'code', 'data', '.*log.*', '^_.+', '\\..+' },
        },
        update_focused_file = { enable = false },
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
        diagnostics = { enable = true },
      }
    end,
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    opts = {
      view_options = { show_hidden = true },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          icons_enabled = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } }, -- relative path
          lualine_x = {
            {
              function()
                local clients = vim.lsp.get_clients { bufnr = 0 }
                if #clients == 0 then return '' end
                local names = {}
                for _, c in ipairs(clients) do
                  table.insert(names, c.name)
                end
                return ' ' .. table.concat(names, ', ')
              end,
            },
            'encoding',
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'location' },
        },
      }
    end,
  },

  {
    'nvim-zh/colorful-winsep.nvim',
    event = { 'WinLeave' },
    config = function()
      require('colorful-winsep').setup {
        highlight = '#cba6f7',
        interval = 30,
        no_exec_files = { 'TelescopePrompt', 'mason', 'lazy', 'NvimTree', 'noice' },
      }
    end,
  },

  {
    'OXY2DEV/markview.nvim',
    lazy = true,
    ft = { 'markdown', 'rmd', 'quarto' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      norg = { enable = false },
      preview = { icon_provider = 'devicons' },
      markdown = {
        headings = {
          enable = true,
          heading_1 = { icon = '󰲡 ' },
          heading_2 = { icon = '󰲣 ' },
          heading_3 = { icon = '󰲥 ' },
          heading_4 = { icon = '󰲧 ' },
          heading_5 = { icon = '󰲩 ' },
          heading_6 = { icon = '󰲫 ' },
        },
        code_blocks = { label_direction = 'left' },
        list_items = { enable = false },
        metadata_minus = { enable = true },
        reference_definitions = { enable = true },
      },
      markdown_inline = {
        footnotes = { enable = false },
      },
    },
  },

  {
    'akinsho/toggleterm.nvim',
    opts = {},
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' },
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
          view = 'cmdline_popup',
        },
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
          },
          hover = {
            enabled = true,
            silent = false,
            view = 'hover',
          },
        },
        presets = {
          bottom_search = false,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
      }
    end,
  },

  ui = {
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
