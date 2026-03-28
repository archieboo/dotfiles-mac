return {
  { -- Autoformat
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        notify_on_error = false,
        -- format_on_save = {
        --   timeout_ms = 500,
        --   lsp_format = 'fallback',
        -- },
        formatters_by_ft = {
          lua    = { 'mystylua' },
          python = { 'isort', 'black' },
          r      = { 'styler' },   -- requires R package: install.packages('styler')
          sh     = { 'shfmt' },
          quarto = { 'injected' }, -- formats each embedded chunk in its own language
        },
        formatters = {
          mystylua = {
            command = 'stylua',
            args = { '--indent-type', 'Spaces', '--indent-width', '2', '-' },
          },
        },
      }
      -- injected: formats embedded code blocks in qmd by language
      -- lang_to_ext maps treesitter language names to file extensions
      -- so formatters can identify the language from the temp filename
      require('conform').formatters.injected = {
        options = {
          lang_to_ext = {
            bash   = 'sh',
            python = 'py',
            r      = 'r',
          },
        },
      }
    end,
  },
}
