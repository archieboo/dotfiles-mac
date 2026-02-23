-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
local options = {
  incsearch = true, -- make search act like search in modern browsers
  inccommand = 'split', -- shows the effects of a command incrementally, as you type
  backup = false, -- creates a backup file
  breakindent = true, -- visually indent wrapped lines
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard. Remove this option if you want your OS clipboard to remain independent. See `:help 'clipboard'`
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { 'menuone', 'noselect' }, -- how to show autocomplete menu, mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  encoding = 'utf-8', -- the encoding written to a file
  -- fileencodings = {'utf-8', 'gbk', 'gbk2312', 'cp936'}, -- the encoding written to a file
  fileencoding = 'utf-8', -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = 'a', -- allow the mouse to be used in neovim
  mousefocus = true, -- automatically focus the neovim window on hover
  pumheight = 10, -- pop up menu height
  showmode = false, -- Don't show the mode, since it's already in the status line
  showtabline = 1, -- always show tabs
  smartcase = true, -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds), decreased to display which-key popup sooner
  undofile = true, -- enable persistent undo
  updatetime = 250, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  laststatus = 3, -- always show the status line
  showcmd = true, -- display incomplete commands
  ruler = true, -- show the cursor position all the time
  relativenumber = false, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = 'yes:1', -- always show the sign column, otherwise it would shift the text each time
  wrap = true, -- display lines as one long line
  linebreak = true, -- wrap lines at convenient points (not breaking words)
  scrolloff = 8, -- Minimal number of screen lines to keep above and below the cursor.
  sidescrolloff = 0, -- Minimal number of screen columns to keep to the left and right of the cursor.
  title = true, -- set the title of window to the value of the titlestring
  winbar = '%f', -- display the filename in the window titlebar
  list = true, -- sets how nvim display white spaces, see :help 'list' and :help 'listchars'
  listchars = { tab = '» ', trail = '·', nbsp = '␣' }, -- sets the characters to be displayed with 'list' option
  spell = false, -- turn off spell checking
  spelllang = { 'en_us', 'fr' },
}

-- Tell Neovim exactly where the two files are
-- Since they are in ~/.config/nvim/spell:
local spell_dir = vim.fn.expand('~/.config/nvim/spell')

vim.opt.spellfile = {
  spell_dir .. '/en.utf-8.add',
  spell_dir .. '/fr.utf-8.add'
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- don't ask about existing swap files
vim.opt.shortmess:append 'A'

-- fold based on treesitter
vim.opt.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99 -- open all folds by default

-- diagnostics
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
}
