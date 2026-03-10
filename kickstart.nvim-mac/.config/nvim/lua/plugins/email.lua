return {
  {
    'yousefakbar/notmuch.nvim',
    enabled = false,
    config = function()
        -- Configuration goes here
        local opts = {}
        require('notmuch').setup(opts)
    end,
  },
  {
    'knownasnaffy/himalaya.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      icons_enabled = true,
      wrap_folder_navigation = true,
    },
  },
}
