return {
  {
    'stevearc/aerial.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      -- per-filetype backends:
      --   markdown/quarto: aerial's built-in markdown backend (headings only)
      --   python/r: lsp for functions and classes
      --   bash/sh: treesitter for functions
      backends = {
        ['_'] = { 'lsp', 'treesitter' },
        markdown = { 'markdown' },
        quarto = { 'treesitter' },
        sh = { 'treesitter' },
        bash = { 'treesitter' },
      },
    },
    config = function(_, opts)
      require('aerial').setup(opts)
      require('telescope').load_extension 'aerial'
    end,
  },
}
