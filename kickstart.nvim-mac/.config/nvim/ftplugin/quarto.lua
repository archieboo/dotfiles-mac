-- local api = vim.api
-- local ts = vim.treesitter
--
-- vim.b.slime_cell_delimiter = '```'
-- vim.b['quarto_is_r_mode'] = nil
-- vim.b['reticulate_running'] = false
--
-- -- wrap text, but by word no character
-- -- indent the wrappped line
-- vim.wo.wrap = true
-- vim.wo.linebreak = true
-- vim.wo.breakindent = true
-- vim.wo.showbreak = '|'
--
-- -- don't run vim ftplugin on top
-- vim.api.nvim_buf_set_var(0, 'did_ftplugin', true)
--
-- -- markdown vs. quarto hacks
-- local ns = vim.api.nvim_create_namespace 'QuartoHighlight'
-- vim.api.nvim_set_hl(ns, '@markup.strikethrough', { strikethrough = false })
-- vim.api.nvim_set_hl(ns, '@markup.doublestrikethrough', { strikethrough = true })
-- vim.api.nvim_win_set_hl_ns(0, ns)
--
-- -- ts based code chunk highlighting uses a change
-- -- only availabl in nvim >= 0.10
-- if vim.fn.has 'nvim-0.10.0' == 0 then
--   return
-- end

-- -- highlight code cells similar to
-- -- 'lukas-reineke/headlines.nvim'
-- -- (disabled in lua/plugins/ui.lua)
-- local buf = api.nvim_get_current_buf()
--
-- local parsername = 'markdown'
-- local parser = ts.get_parser(buf, parsername)
-- local tsquery = '(fenced_code_block)@codecell'

-- -- vim.api.nvim_set_hl(0, '@markup.codecell', { bg = '#000055' })
-- vim.api.nvim_set_hl(0, '@markup.codecell', {
--   link = 'CursorLine',
-- })

-- local function clear_all()
--   local all = api.nvim_buf_get_extmarks(buf, ns, 0, -1, {})
--   for _, mark in ipairs(all) do
--     vim.api.nvim_buf_del_extmark(buf, ns, mark[1])
--   end
-- end

-- local function highlight_range(from, to)
--   for i = from, to do
--     vim.api.nvim_buf_set_extmark(buf, ns, i, 0, {
--       hl_eol = true,
--       line_hl_group = '@markup.codecell',
--     })
--   end
-- end

-- local function highlight_cells()
--   clear_all()
--
--   local query = ts.query.parse(parsername, tsquery)
--   local tree = parser:parse()
--   local root = tree[1]:root()
--   for _, match, _ in query:iter_matches(root, buf, 0, -1, { all = true }) do
--     for _, nodes in pairs(match) do
--       for _, node in ipairs(nodes) do
--         local start_line, _, end_line, _ = node:range()
--         pcall(highlight_range, start_line, end_line - 1)
--       end
--     end
--   end
-- end

-- highlight_cells()
--
-- vim.api.nvim_create_autocmd({ 'ModeChanged', 'BufWrite' }, {
--   group = vim.api.nvim_create_augroup('QuartoCellHighlight', { clear = true }),
--   buffer = buf,
--   callback = highlight_cells,
-- })


-- redone by gpt
local api = vim.api
local ts = vim.treesitter

-- Set the cell delimiter for quarto
vim.b.slime_cell_delimiter = '```'

-- Define a namespace for custom highlights
local ns = vim.api.nvim_create_namespace 'QuartoHighlight'

-- Set the highlight for code cells (you can adjust the background color here)
vim.api.nvim_set_hl(0, '@markup.codecell', {
  bg = '#232333', -- Set your desired background color for code cells
  fg = '#d8dee9', -- Optional: Set foreground color (text color)
})

-- Only continue if running Neovim 0.10 or higher
if vim.fn.has 'nvim-0.10.0' == 0 then
  return
end

-- Get the current buffer and set up Tree-sitter for markdown
local buf = api.nvim_get_current_buf()
local parsername = 'markdown'
local parser = ts.get_parser(buf, parsername)
local tsquery = '(fenced_code_block)@codecell'

-- Function to clear all previous highlights
local function clear_all()
  local all = api.nvim_buf_get_extmarks(buf, ns, 0, -1, {})
  for _, mark in ipairs(all) do
    vim.api.nvim_buf_del_extmark(buf, ns, mark[1])
  end
end

-- Function to highlight a range of lines for code cells
local function highlight_range(from, to)
  for i = from, to do
    vim.api.nvim_buf_set_extmark(buf, ns, i, 0, {
      hl_eol = true, -- Highlight the entire line
      line_hl_group = '@markup.codecell', -- Use the code cell highlight group
    })
  end
end

-- Function to find and highlight code cells in the buffer
local function highlight_cells()
  clear_all()

  -- Parse the buffer with Tree-sitter and find fenced code blocks
  local query = ts.query.parse(parsername, tsquery)
  local tree = parser:parse()
  local root = tree[1]:root()

  for _, match, _ in query:iter_matches(root, buf, 0, -1, { all = true }) do
    for _, nodes in pairs(match) do
      for _, node in ipairs(nodes) do
        local start_line, _, end_line, _ = node:range()
        pcall(highlight_range, start_line, end_line - 1)
      end
    end
  end
end

-- Call the highlight_cells function to highlight the code cells
highlight_cells()

-- Automatically re-apply highlighting on ModeChanged and BufWrite events
vim.api.nvim_create_autocmd({ 'ModeChanged', 'BufWrite' }, {
  group = vim.api.nvim_create_augroup('QuartoCellHighlight', { clear = true }),
  buffer = buf,
  callback = highlight_cells,
})
