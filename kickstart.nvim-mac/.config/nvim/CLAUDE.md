# Neovim Configuration

## Goal

Personal Neovim config based on kickstart.nvim, tailored for data science work (Python, R, Quarto).

Becautious, avoid changes that may break nvim or change existing behavior. If certain modification requires change of exhisting nvim behavior, ask for permission first. 

## Directory Structure

```
init.lua
lua/
  config/
    global.lua
    lazy.lua
    keymap.lua
    autocommands.lua
  plugins/
    autocomplete.lua
    autoformat.lua
    colorthemes.lua
    editing.lua
    git.lua
    lsp.lua
    obsidian.lua
    quarto.lua
    sessions.lua
    telescope.lua
    tree-sitter.lua
    ui.lua
    welcome.lua
    which-key.lua
  kickstart/plugins/
    autopairs.lua
    debug.lua
    gitsigns.lua
    indent_line.lua
    lint.lua
    neo-tree.lua
  custom/plugins/
    init.lua
  misc/
    style.lua
ftplugin/
  bash.lua
  markdown.lua
  python.lua
  quarto.lua
  r.lua
  sh.lua
```

## Conventions

- **Plugin manager**: lazy.nvim. All plugins go in `lua/plugins/*.lua`.
- **Keymaps**: Defined in `lua/config/keymap.lua` using `which-key` `wk.add()`. Leader is `<Space>`.
- **Settings**: Global vim options go in `lua/config/global.lua`.
- **Autocommands**: Go in `lua/config/autocommands.lua`.
- **Filetype overrides**: Go in `ftplugin/<filetype>.lua`.
- **Indentation**: 2 spaces (enforced by stylua for Lua files).
- **No backup/swap files**; persistent undo enabled.
- **Folds**: Treesitter-based (`foldmethod=expr`), all open by default (`foldlevel=99`).

## Key Leader Groups

| Prefix | Group |
|--------|-------|
| `<leader>b` | Toggle file tree (nvim-tree) |
| `<leader>c` | Code / cell / chunk (terminals, REPL) |
| `<leader>f` | Find (Telescope) |
| `<leader>l` | Language / LSP |
| `<leader>o` | Otter & code chunks |
| `<leader>q` | Quarto |
| `<leader>t` | Toggle terminal |
| `<leader>v` | Vim meta (lazy, mason, colorscheme, vimrc) |
| `<leader>w` | Window management |
| `<leader>x` | Extra utilities |

## LSP Servers (auto-installed via Mason)

`lua_ls`, `bashls`, `cssls`, `html`, `pyright`, `r_language_server` (and others in `lsp.lua`).

## Quarto / Data Science Workflow


- `<leader>qp` — Quarto preview
- `<leader><cr>` — Run current code cell (via vim-slime)
- `<cr>` (visual) — Send selected region to REPL
- `<m-i>` / `<m-I>` — Insert R / Python code chunk
- `[[` / `]]` — Jump between code chunks
- `<leader>ci/cp/cr` — Open ipython / python / R terminal in vsplit

## IGNORE

- Ignore any files outside of `./lua/` unless specifically asked or a specific  step requires you to access files outside of it. 
