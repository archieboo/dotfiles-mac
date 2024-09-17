return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'NeogitOrg/neogit',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
    lazy = true,
    keys = {
      { '<leader>gg', ':Neogit<cr>', desc = 'neo[g]it' },
    },
    config = function()
      require('neogit').setup {
        disable_commit_confirmation = false,
        integrations = {
          diffview = true,
        },
      }
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    enabled = false,
    init = function()
      require('git-conflict').setup {
        default_mappings = false,
        disable_diagnostics = true,
      }
    end,
    keys = {
      { '<leader>gco', ':GitConflictChooseOurs<cr>' },
      { '<leader>gct', ':GitConflictChooseTheirs<cr>' },
      { '<leader>gcb', ':GitConflictChooseBoth<cr>' },
      { '<leader>gc0', ':GitConflictChooseNone<cr>' },
      { ']x', ':GitConflictNextConflict<cr>' },
      { '[x', ':GitConflictPrevConflict<cr>' },
    },
    {
      'f-person/git-blame.nvim',
      init = function()
        require('gitblame').setup {
          enabled = false,
        }
        vim.g.gitblame_display_virtual_text = 1
        -- vim.g.gitblame_enabled = 0
      end,
    },
  },
}
