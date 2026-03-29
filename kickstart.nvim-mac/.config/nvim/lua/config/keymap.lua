-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- vim.opt.hlsearch = true

-- required in which-key plugin spec in plugins/ui.lua as `require 'config.keymap'`
local wk = require 'which-key'

P = vim.print

vim.g['quarto_is_r_mode'] = nil
vim.g['reticulate_running'] = false

local nmap = function(key, effect, desc)
  vim.keymap.set('n', key, effect, { silent = true, noremap = true, desc = desc })
end

local vmap = function(key, effect, desc)
  vim.keymap.set('v', key, effect, { silent = true, noremap = true, desc = desc })
end

local imap = function(key, effect, desc)
  vim.keymap.set('i', key, effect, { silent = true, noremap = true, desc = desc })
end

local cmap = function(key, effect, desc)
  vim.keymap.set('c', key, effect, { silent = true, noremap = true, desc = desc })
end

-- Resize window using <shift> arrow keys
nmap('<S-Up>', '<cmd>resize +2<CR>', 'increase window height')
nmap('<S-Down>', '<cmd>resize -2<CR>', 'decrease window height')
nmap('<S-Left>', '<cmd>vertical resize -2<CR>', 'decrease window width')
nmap('<S-Right>', '<cmd>vertical resize +2<CR>', 'increase window width')

nmap('Q', '<Nop>', 'disable Q')

-- move in command line
cmap('<C-a>', '<Home>', 'go to line start')

-- exit insert mode with jk
imap('jk', '<esc>', 'exit insert mode')

-- exit terminal mode with jk
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'exit terminal mode' })

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
--- TODO: incorporate this into quarto-nvim plugin
--- such that QuartoRun functions get the same capabilities
--- TODO: figure out bracketed paste for reticulate python repl.
local function send_cell()
  if vim.b['quarto_is_r_mode'] == nil then
    vim.fn['slime#send_cell']()
    return
  end
  if vim.b['quarto_is_r_mode'] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require('otter.tools.functions').is_otter_language_context 'python'
    if is_python and not vim.b['reticulate_running'] then
      vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
      vim.b['reticulate_running'] = true
    end
    if not is_python and vim.b['reticulate_running'] then
      vim.fn['slime#send']('exit' .. '\r')
      vim.b['reticulate_running'] = false
    end
    vim.fn['slime#send_cell']()
  end
end

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
local slime_send_region_cmd = ':<C-u>call slime#send_op(visualmode(), 1)<CR>'
slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
local function send_region()
  -- if filetype is not quarto, just send_region
  if vim.bo.filetype ~= 'quarto' or vim.b['quarto_is_r_mode'] == nil then
    vim.cmd('normal' .. slime_send_region_cmd)
    return
  end
  if vim.b['quarto_is_r_mode'] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require('otter.tools.functions').is_otter_language_context 'python'
    if is_python and not vim.b['reticulate_running'] then
      vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
      vim.b['reticulate_running'] = true
    end
    if not is_python and vim.b['reticulate_running'] then
      vim.fn['slime#send']('exit' .. '\r')
      vim.b['reticulate_running'] = false
    end
    vim.cmd('normal' .. slime_send_region_cmd)
  end
end

vmap('>', '>gv', 'indent and reselect')
vmap('<', '<gv', 'dedent and reselect')

-- center after search and jumps
nmap('n', 'nzz', 'next match (centered)')
nmap('<c-d>', '<c-d>zz', 'scroll down (centered)')
nmap('<c-u>', '<c-u>zz', 'scroll up (centered)')

-- move between splits and tabs
nmap('<c-h>', '<c-w>h', 'window left')
nmap('<c-l>', '<c-w>l', 'window right')
nmap('<c-j>', '<c-w>j', 'window down')
nmap('<c-k>', '<c-w>k', 'window up')

-- Move between tabs, note bufferline uses bnext and bprev
-- nmap('H', '<cmd>tabprevious<cr>')
-- nmap('L', '<cmd>tabnext<cr>')
nmap('H', '<cmd>bprev<cr>', 'prev buffer')
nmap('L', '<cmd>bnext<cr>', 'next buffer')

local function toggle_light_dark_theme()
  if vim.o.background == 'light' then
    vim.o.background = 'dark'
  else
    vim.o.background = 'light'
  end
end

local is_code_chunk = function()
  local current, _ = require('otter.keeper').get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

local insert_r_chunk = function()
  insert_code_chunk 'r'
end

local insert_py_chunk = function()
  insert_code_chunk 'python'
end

local insert_bash_chunk = function()
  insert_code_chunk 'bash'
end

-- normal mode
wk.add({
  { '<c-LeftMouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', desc = 'go to definition' },
  { '<c-q>', '<cmd>q<cr>', desc = 'close buffer' },
  { '<cm-i>', insert_py_chunk, desc = 'python code chunk' },
  { '<esc>', '<cmd>noh<cr>', desc = 'remove search highlight' },
  { '<m-I>', insert_py_chunk, desc = 'python code chunk' },
  { '<m-i>', insert_r_chunk, desc = 'r code chunk' },
  { '[q', ':silent cprev<cr>', desc = '[q]uickfix prev' },
  { ']q', ':silent cnext<cr>', desc = '[q]uickfix next' },
  { 'gN', 'Nzzzv', desc = 'center search' },
  { 'gf', ':e <cfile><CR>', desc = 'edit file' },
  { 'gl', '<c-]>', desc = 'open help link' },
  { 'n', 'nzzzv', desc = 'center search' },
  { 'z?', ':setlocal spell!<cr>', desc = 'toggle [z]pellcheck' },
  { 'zl', ':Telescope spell_suggest<cr>', desc = '[l]ist spelling suggestions' },
  { '<c-s>', ':Telescope session-lens<cr>', desc = 'session [s]earch' },
}, { mode = 'n', silent = true })

-- visual mode
wk.add {
  mode = { 'v' },
  { '.', ':norm .<cr>', desc = 'repeat last normal mode command' },
  { '<M-j>', ":m'>+<cr>`<my`>mzgv`yo`z", desc = 'move line down' },
  { '<M-k>', ":m'<-2<cr>`>my`<mzgv`yo`z", desc = 'move line up' },
  {
    '<cr>',
    function()
      if vim.bo.filetype == 'qf' or vim.bo.filetype == 'quickfix' then
        vim.cmd 'cnext'
      else
        send_region()
      end
    end,
    desc = 'run code region or jump to Quickfix',
  },
  -- { "q", ":norm @q<cr>", desc = "repat q macro" },
}

-- visual with <leader>
wk.add({
  { '<leader>d', '"_d', desc = 'delete without overwriting reg', mode = 'v' },
  { '<leader>p', '"_dP', desc = 'replace without overwriting reg', mode = 'v' },
}, { mode = 'v', prefix = '<leader>' })

-- insert mode
wk.add({
  mode = { 'i' },
  { '<c-x><c-x>', '<c-x><c-o>', desc = 'omnifunc completion' },
  { '<cm-i>', insert_py_chunk, desc = 'python code chunk' },
  { '<m-->', ' <- ', desc = 'assign' },
  { '<m-I>', insert_py_chunk, desc = 'python code chunk' },
  { '<m-i>', insert_r_chunk, desc = 'r code chunk' },
  { '<m-m>', ' |>', desc = 'pipe' },
}, { mode = 'i' })

local function new_terminal(lang)
  vim.cmd('vsplit term://' .. lang)
end

local function new_terminal_python()
  new_terminal 'python'
  vim.cmd 'sleep 100m'
  vim.cmd 'normal! G' -- move to end of terminal
end

local function new_terminal_r()
  new_terminal 'R --no-save'
  vim.cmd 'sleep 100m'
  vim.cmd 'normal! G' -- move to end of terminal
end

local function new_terminal_ipython()
  new_terminal 'ipython --no-confirm-exit'
  vim.cmd 'sleep 100m'
  vim.cmd 'normal! G' -- move to end of terminal
end

local function new_terminal_shell()
  new_terminal '$SHELL'
  vim.cmd 'sleep 100m'
  vim.cmd 'normal! G' -- move to end of terminal
end

local function goto_next_code_chunk()
  local pattern = '^```%{%w+%}'
  local current_line = vim.fn.line '.'
  local last_line = vim.fn.line '$'
  for i = current_line + 1, last_line do
    local line_content = vim.fn.getline(i)
    if line_content:match(pattern) then
      vim.cmd('normal! ' .. i + 1 .. 'G')
      return
    end
  end
end

local function goto_previous_code_chunk()
  local pattern = '^```%{%w+%}'
  local current_line = vim.fn.line '.'
  for i = current_line - 1, 1, -1 do
    local line_content = vim.fn.getline(i)
    if line_content:match(pattern) then
      vim.cmd('normal! ' .. i .. 'G')
      return
    end
  end
end

vim.keymap.set('n', '[[', goto_previous_code_chunk, { noremap = true, silent = true, desc = 'prev code chunk' })
vim.keymap.set('n', ']]', goto_next_code_chunk, { noremap = true, silent = true, desc = 'next code chunk' })

-- send code with Enter and leader Enter
-- vmap('<cr>', '<Plug>SlimeRegionSend')
-- nmap('<leader><cr>', '<Plug>SlimeSendCell')

-- normal mode with <leader>
wk.add({
  { '<leader><cr>', send_cell, desc = 'run code cell' },

  { '<leader>c', group = '[c]ode / [c]ell / [c]hunk' },
  { '<leader>ci', new_terminal_ipython, desc = 'new [i]python terminal' },
  { '<leader>cn', new_terminal_shell, desc = '[n]ew terminal with shell (vsplit)' },
  {
    '<leader>cN',
    function()
      vim.cmd 'split term://$SHELL'
      vim.cmd 'sleep 100m'
      vim.cmd 'normal! G' -- move to end of terminal
    end,
    desc = '[N]ew terminal with shell (hsplit)',
  },
  { '<leader>cp', new_terminal_python, desc = 'new [p]ython terminal' },
  { '<leader>cr', new_terminal_r, desc = 'new [R] terminal' },
  { '<leader>d', group = '[d]ebug' },
  { '<leader>dt', group = '[t]est' },
  { '<leader>e', group = '[e]dit' },

  { '<leader>f', group = '[f]ind (telescope)' },
  { '<leader>fa', '<cmd>Telescope aerial<cr>', desc = '[a]erial symbols' },
  { '<leader>fM', '<cmd>Telescope man_pages<cr>', desc = '[M]an pages' },
  { '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'current [b]uffer fuzzy find' },
  { '<leader>fc', '<cmd>Telescope git_commits<cr>', desc = 'git [c]ommits' },
  { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = '[d]iagnostics' },
  { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[f]iles' },
  { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = '[g]rep' },
  { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = '[h]elp' },
  { '<leader>fj', '<cmd>Telescope jumplist<cr>', desc = '[j]umplist' },
  { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = '[k]eymaps' },
  { '<leader>fl', '<cmd>Telescope loclist<cr>', desc = '[l]oclist' },
  { '<leader>fm', '<cmd>Telescope marks<cr>', desc = '[m]arks' },
  { '<leader>fo', function() require('telescope.builtin').live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end, desc = '[o]pen files grep' },
  { '<leader>fq', '<cmd>Telescope quickfix<cr>', desc = '[q]uickfix' },
  { '<leader>fr', '<cmd>Telescope resume<cr>', desc = '[r]esume' },
  { '<leader>fs', '<cmd>Telescope builtin<cr>', desc = '[s]elect telescope' },
  { '<leader>fu', '<cmd>Telescope buffers<cr>', desc = 'b[u]ffers' },
  { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'current [w]ord' },
  { '<leader>f.', '<cmd>Telescope oldfiles<cr>', desc = 'recent [.] files' },

  -- LSP keys
  { '<leader>l', group = '[l]anguage/lsp' },
  { '<leader>la', ':Lspsaga code_action<cr>', desc = 'code [a]ction' },
  { '<leader>ld', group = '[d]iagnostics' },
  {
    '<leader>ldt',
    function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end,
    desc = '[t]oggle diagnostic',
  },
  { '<leader>ldn', ':Lspsaga diagnostic_jump_next<cr>', desc = 'jump to [n]ext diagnostic' },
  { '<leader>ldp', ':Lspsaga diagnostic_jump_prev<cr>', desc = 'jump to [p]revious diagnostic' },
  { '<leader>lds', ':Lspsaga show_line_diagnostics<cr>', desc = '[s]how line diagnostics' },
  { '<leader>lp', ':Lspsaga peek_definition<cr>', desc = '[p]eek definition' },
  { '<leader>lR', ':Lspsaga rename<cr>', desc = '[R]ename' },
  { '<leader>lf', ':Lspsaga finder<cr>', desc = '[f]ind symbols' }, -- doesn't work in quarto
  { '<leader>lr',
    function()
      require('telescope.builtin').lsp_references()
    end, desc = 'go to [r]eferences' },
  { '<leader>lo', ':Trouble symbols<cr>', desc = 'symbols [o]utline in buffer' },
  { mode = { 'n', 'v' }, '<leader>lF', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end, desc = '[F]ormat code' },

  { '<leader>o', group = '[o]tter & c[o]de' },
  { '<leader>ob', insert_bash_chunk, desc = '[b]ash code chunk' },
  { '<leader>oc', 'O# %%<cr>', desc = 'magic [c]omment code chunk # %%' },
  { '<leader>op', insert_py_chunk, desc = '[p]ython code chunk' },
  { '<leader>or', insert_r_chunk, desc = '[r] code chunk' },
  { '<leader>ol', '<cmd>Oil --float<cr>', desc = '[o]pen oi[l]' },

  { '<leader>q', group = '[q]uarto' },
  { '<leader>qa', ':QuartoActivate<cr>', desc = '[a]ctivate' },
  { '<leader>qh', ':QuartoHelp ', desc = '[h]elp' },
  { '<leader>qp', ":lua require'quarto'.quartoPreview()<cr>", desc = '[p]review' },
  { '<leader>qq', ":lua require'quarto'.quartoClosePreview()<cr>", desc = '[q]uiet preview' },
  { '<leader>qr', group = '[r]un' },
  { '<leader>qra', ':QuartoSendAll<cr>', desc = 'run [a]ll' },
  { '<leader>qrb', ':QuartoSendBelow<cr>', desc = 'run [b]elow' },
  { '<leader>qrr', ':QuartoSendAbove<cr>', desc = 'to cu[r]sor' },

  { '<leader>t', group = '[t]oggle terminal' },
  { '<leader>tf', ':ToggleTerm direction=float<cr>', desc = '[f]loat terminal' },
  { '<leader>to', ':ToggleTerm direction=horizontal<cr>', desc = 'h[o]rizontal terminal' },
  { '<leader>tv', ':ToggleTerm direction=vertical size=80<cr>', desc = '[v]ertical terminal' },
  { '<leader>tt', ':ToggleTerm<cr>', desc = '[t]erminal [t]oggle' },
  { '<leader>ts', ':TermSelect<cr>', desc = '[t]erminal [s]elect' },

  { '<leader>mt', ':Markview toggleAll<cr>', desc = '[m]arkview [t]oggle all' },


  { '<leader>v', group = '[v]im' },
  { '<leader>vc', function() require('telescope.builtin').colorscheme { enable_preview = true, ignore_builtins = true } end, desc = '[c]olortheme' },
  { '<leader>vh', ':execute "h " . expand("<cword>")<cr>', desc = 'vim [h]elp for current word' },
  { '<leader>vl', ':Lazy<cr>', desc = '[l]azy package manager' },
  { '<leader>vm', ':Mason<cr>', desc = '[m]ason software installer' },
  { '<leader>vs', ':e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>', desc = '[s]ettings, edit vimrc' },
  { '<leader>vt', toggle_light_dark_theme, desc = '[t]oggle light/dark theme' },

  { '<leader>w', group = '[w]indow' },
  { '<leader>wd', vim.diagnostic.open_float, desc = 'show [d]iagnostics under cursor' },
  { '<leader>wh', '<C-w>h', desc = 'move [h] left' },
  { '<leader>wj', '<C-w>j', desc = 'move [j] down' },
  { '<leader>wk', '<C-w>k', desc = 'move [k] up' },
  { '<leader>wl', '<C-w>l', desc = 'move [l] right' },
  { '<leader>ws', '<cmd>split<cr>', desc = '[s]plit' },
  { '<leader>wv', '<cmd>vsplit<cr>', desc = '[v]split' },
  { '<leader>ww', '<C-w>w', desc = 'move to [w]indow' },
  { '<leader>wq', '<cmd>q<cr>', desc = '[q]uit' },
  { '<leader>wr', '<cmd>only<cr>', desc = '[r]emove other windows' },
  { '<leader>wt', '<cmd>tabnew<cr>', desc = '[t]abnew' },
  { '<leader>wT', '<cmd>tabclose<cr>', desc = '[T]abclose' },
  { '<leader>w+', '<cmd>resize +5<CR>', desc = 'increase window height' },
  { '<leader>w-', '<cmd>resize -5<CR>', desc = 'decrease window height' },
  { '<leader>w<', '<cmd>vertical resize -5<CR>', desc = 'decrease window width' },
  { '<leader>w>', '<cmd>vertical resize +5<CR>', desc = 'increase window width' },
  { '<leader>w=', '<C-w>=', desc = 'equalize window sizes' },
  { '<leader>w|', '<cmd>resize |<CR>', desc = 'maximize window height' },
  { '<leader>w_', '<cmd>resize _<CR>', desc = 'maximize window width' },

  { '<leader>x', group = 'e[x]tra' },
  { mode = {'n'}, '<leader>xp', ':LoremIpsum paragraphs 2<cr>', desc = 'Generate 2 [p]argraphs'},
  { '<leader>xz', ':source $MYVIMRC<cr>', desc = '[z]ource' },
}, { mode = 'n', prefix = '<leader>' })
