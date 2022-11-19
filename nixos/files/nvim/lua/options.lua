local vim = vim
local cmd = vim.cmd
local indent = 2

vim.g.mapleader = "," -- The leader key (keep it at the top)
vim.opt.autowrite = true -- enable auto write
-- vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic
vim.opt.concealcursor = "n" -- Hide * markup for bold and italic
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
-- vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.cursorcolumn = true -- Enable highlighting of the current column
vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- TreeSitter folding
-- vim.opt.foldlevel = 6
-- vim.opt.foldmethod = "expr" -- TreeSitter folding
vim.opt.guifont = "FiraCode Nerd Font:h12"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "split" -- preview incremental substitute
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 999 -- Lines of context
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = indent -- Size of an indent
vim.opt.showmode = false -- dont show mode since we have a statusline
vim.opt.laststatus = 0 -- Hide statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = indent -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.undofile = true
vim.opt.undodir = "/tmp/vimundo"
vim.opt.updatetime = 300 -- save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.wrap = true -- Enable line wrap
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.hlsearch = false -- Turn off search highlight
vim.opt.autochdir = false -- Don't change directory when opening a file
vim.opt.autoread = true -- Auto reload when file changes
vim.opt.showtabline = 2 -- Show tabname even if only one file is open
vim.opt.lazyredraw = true -- Prevent screen flickering when opening vim inside vim
vim.opt.backup = false -- Do not old backup
vim.opt.writebackup = false -- Do not create backup
vim.opt.colorcolumn = "80,89" -- 80, 89 chars column length
vim.opt.background = "dark" -- Dark theme

-- vim.o.shortmess = "IToOlxfitn"
-- don't load the plugins below
vim.g.loaded_gzip = 1
vim.g.loaded_fzf = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.material_style = "darker"
vim.g.switchbuf = "newtab"

-- Use proper syntax highlighting in code blocks
local fences = {
  "lua",
  -- "vim",
  "json",
  "typescript",
  "javascript",
  "js=javascript",
  "ts=typescript",
  "shell=sh",
  "python",
  "sh",
  "console=sh",
}
vim.g.markdown_fenced_languages = fences

-- plasticboy/vim-markdown
vim.g.vim_markdown_folding_level = 10
vim.g.vim_markdown_fenced_languages = fences
vim.g.vim_markdown_folding_style_pythonic = 1
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_strikethrough = 1

-- Check if we need to reload the file when it changed
cmd("au FocusGained * :checktime")

-- show cursor line only in active window
-- cmd([[
--   autocmd InsertLeave,WinEnter * set cursorline cursorcolumn
--   autocmd InsertEnter,WinLeave * set nocursorline nocursorcolumn
-- ]])

-- go to last loc when opening a buffer
cmd([[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]])

-- Highlight on yank
cmd("au TextYankPost * lua vim.highlight.on_yank {}")

-- windows to close with "q"
cmd(
  [[autocmd FileType help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<CR>]]
)
cmd([[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]])

-- Rename
cmd([[
  " Remap for rename current word
  vnoremap <leader>r "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>
  vnoremap <leader>R "hy:bufdo %s/<C-r>h/<C-r>h/gce<left><left><left><left>
]])

-- Color Scheme
-- cmd([[
--   let g:transparent_enabled = v:true
--   set guifont=FiraCode\ Nerd\ Font:h19
--   set background=dark
--   highlight link CompeDocumentation NormalFloat
-- ]])
