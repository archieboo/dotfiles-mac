return {
  -- disables hungry features for files larget than 2MB
  { 'LunarVim/bigfile.nvim' },

  { 'numToStr/Comment.nvim', opts = {} },
  { -- format things as tables
    'godlygeek/tabular',
    cmd = { 'Tabularize' },
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      { ']t', function() require('todo-comments').jump_next() end, desc = 'next [t]odo comment' },
      { '[t', function() require('todo-comments').jump_prev() end, desc = 'previous [t]odo comment' },
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      require('mini.cursorword').setup()
    end,
  },
  { -- Add/change/delete surrounding delimiter pairs
    -- ys{motion}{char}  add surround:    word   →(ysiw))→ (word),   word  →(ysiw")→ "word"
    -- ds{char}          delete surround: (word) →(ds))→   word,   "word" →(ds")→   word
    -- cs{old}{new}      change surround: (word) →(cs)")→ "word",  'word' →(cs'`)→  `word`
    -- note: visual mode S conflicts with flash.nvim treesitter jump
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers',
          separator_style = 'thin',
          indicator = {
            icon = ' 🌈',
            style = 'icon',
          },
        },
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {}
      require('nvim-autopairs').remove_rule '`'
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require('ibl').setup {
        indent = { highlight = highlight },
        scope = { highlight = highlight },
      }
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require 'illuminate'
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,             desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end,        desc = 'Flash Treesitter' },
      { 'r', mode = 'o',               function() require('flash').remote() end,             desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' },      function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' },        function() require('flash').toggle() end,            desc = 'Toggle Flash Search' },
    },
  },
  {
    'derektata/lorem.nvim',
    cmd = { 'Lorem' },
    config = function()
      require('lorem').opts {
        sentenceLength = 'mixedLong',
        comma_chance = 0.2,
        max_commas_per_sentence = 2,
      }
    end,
  },
}
