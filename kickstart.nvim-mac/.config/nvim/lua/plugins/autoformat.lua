return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>ft',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]orma[t] buffer',
      },
    },
    enabled = true,
    config = function()
      require('conform').setup {
        notify_on_error = true,
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          quarto = { 'injected' },
        },
      }
      -- Customize injected formatters
      -- see https://github.com/jmbuhr/quarto-nvim-kickstarter/blob/382b050e13eada7180ad048842386be37e820660/lua/plugins/editing.lua#L29-L81
      require('conform').formatters.injected = {
        options = {
          ignore_errors = true,
          lang_to_ext = {
            bash = 'sh',
            r = 'r',
            python = 'py',
            markdown = 'md',
          },
          -- Map of treesitter language to formatters to use
          -- (defaults to the value from formatters_by_ft)
          lang_to_formatters = {},
        },
      }
    end,
  },
}
