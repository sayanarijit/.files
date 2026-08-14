local vim = vim
local cmd = vim.cmd

local function gh(repo)
  return "https://github.com/" .. repo
end

local function cb(repo)
  return "https://codeberg.org/" .. repo
end

-- Setup lazy
vim.pack.add({
  -- --  Don't go there. It's a rabbithole.
  -- --  cmd: Xp
  -- gh("sayanarijit/xplr.vim"),

  -- -- eyes Move faster with unique f/F indicators.
  -- gh("jinh0/eyeliner.nvim"),

  -- Generate markdown table of contents
  gh("richardbizik/nvim-toc"),

  --  Switch between single-line and multiline forms of code
  gh("AndrewRadev/splitjoin.vim"),

  gh("sayanarijit/exec-cursorline-insert-stdout.nvim"),

  -- Find, Filter, Preview, Pick. All lua, all the time.
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-telescope/telescope-ui-select.nvim"),
  gh("isak102/telescope-git-file-history.nvim"),
  gh("tpope/vim-fugitive"),
  -- gh("nvim-telescope/telescope-fzf-native.nvim"),
  gh("nvim-telescope/telescope.nvim"),

  gh("nvim-tree/nvim-web-devicons"),
  gh("ibhagwan/fzf-lua"),

  gh("xiyaowong/virtcolumn.nvim"),

  -- --  Nvim Treesitter configurations and abstraction layer
  gh("nvim-treesitter/nvim-treesitter"),
  gh("nvim-treesitter/nvim-treesitter-textobjects"),
  -- gh("RRethy/nvim-treesitter-textsubjects"),
  gh("windwp/nvim-ts-autotag"),
  -- -- gh("David-Kunz/markid"),
  gh("JoosepAlviste/nvim-ts-context-commentstring"),

  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  gh("sindrets/diffview.nvim"),

  -- Brings physics-based smooth scrolling to the Vim world!
  -- gh("yuttie/comfortable-motion.vim"),

  -- Smooth scrolling neovim plugin written in lua
  gh("karb94/neoscroll.nvim"),

  -- --  vimspector - A multi-language debugging system for Vim
  -- gh("puremourning/vimspector"),

  --  Improved nginx vim plugin (incl. syntax highlighting)
  gh("chr4/nginx.vim"),

  -- Markdown Vim Mode
  gh("godlygeek/tabular"),
  gh("preservim/vim-markdown"),
  gh("jghauser/follow-md-links.nvim"),

  -- A Neovim (lua) plugin for working with a markdown zettelkasten / wiki and mixing it with a journal, based on telescope.nvim
  gh("nvim-telekasten/telekasten.nvim"),

  -- -- A fast and lightweight Neovim lua plugin to keep an eye on where your cursor has jumped.
  -- gh("edluffy/specs.nvim"),

  -- Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
  -- cmd: OpenGithub
  gh("tyru/open-browser.vim"),
  gh("tyru/open-browser-github.vim"),

  -- gh("tzachar/cmp-tabnine"),
  -- gh("williamboman/mason.nvim"),
  -- gh("williamboman/mason-lspconfig.nvim"),

  -- Lightweight yet powerful formatter plugin for Neovim
  gh("stevearc/conform.nvim"),

  gh("mfussenegger/nvim-lint"),

  -- Quickstart configurations for the Nvim completions
  gh("hrsh7th/nvim-cmp"),
  gh("hrsh7th/cmp-nvim-lsp"),
  gh("rafamadriz/friendly-snippets"),
  gh("hrsh7th/cmp-buffer"),
  -- gh("hrsh7th/cmp-copilot"),
  gh("hrsh7th/cmp-path"),
  gh("hrsh7th/cmp-calc"),
  gh("hrsh7th/cmp-emoji"),
  gh("hrsh7th/cmp-cmdline"),
  gh("saadparwaiz1/cmp_luasnip"),
  gh("L3MON4D3/LuaSnip"),
  -- gh("lukas-reineke/lsp-format.nvim"),
  gh("neovim/nvim-lspconfig"),

  gh("kosayoda/nvim-lightbulb"),

  --  Vim plugin that displays tags in a window, ordered by scope
  gh("preservim/tagbar"),

  --  A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
  -- gh("simrat39/symbols-outline.nvim"),

  --  A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
  -- gh("airblade/vim-gitgutter"),

  -- Neovim plugin for GitHub Copilot
  gh("github/copilot.vim"),

  -- --  brain muscle // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
  -- gh("numToStr/Comment.nvim"),

  --  Vim syntax for TOML
  gh("cespare/vim-toml"),

  -- Run your tests at the speed of thought
  gh("vim-test/vim-test"),

  -- Vim syntax highlighting for Google's Protocol Buffers
  gh("uarun/vim-protobuf"),

  -- quoting/parenthesizing made simple
  gh("tpope/vim-surround"),

  -- Git commit message viewer
  -- gh("rhysd/git-messenger.vim"),

  --  Vim configuration files for Nix http://nixos.org/nix
  gh("LnL7/vim-nix"),

  -- -- Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination.
  gh("terryma/vim-expand-region"),

  --  link The fancy start screen for Vim.
  gh("mhinz/vim-startify"),

  -- boom Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that
  -- displays a popup with possible keybindings of the command you started typing.
  gh("folke/which-key.nvim"),

  --  Prisma 2 support for vim
  gh("pantharshit00/vim-prisma"),

  --  A Vim plugin that provides GraphQL file detection, syntax highlighting, and indentation.
  gh("jparise/vim-graphql"),

  -- --  Neovim extension for zk
  -- gh("mickael-menu/zk-nvim"),

  cb("fosk/registers.nvim"),

  -- -- Tools to help create flutter apps in neovim using the native lsp
  -- gh("akinsho/flutter-tools.nvim"),

  -- -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  -- gh("hoob3rt/lualine.nvim"),

  -- The fastest Neovim colorizer.
  -- gh("norcalli/nvim-colorizer.lua"),

  -- Material colorscheme for NeoVim
  gh("marko-cerovac/material.nvim"),

  gh("is0n/fm-nvim"),

  -- -- A dark and light Neovim theme written in Rust, inspired by IBM Carbon.
  -- gh("shaunsingh/oxocarbon.nvim"),

  -- gh("xiyaowong/nvim-transparent"),
})

-- Plugin Configurations

-- --  Don't go there. It's a rabbithole.
-- --  cmd: Xp
-- cmd([[
--   let g:nnn#layout = { 'window': { 'width': 0.95, 'height': 0.95, 'highlight': 'Debug' } }
--   let g:nnn#action = {
--         \ '<c-t>': 'tab split',
--         \ '<c-x>': 'split',
--         \ '<c-v>': 'vsplit' }
--   let g:nnn#replace_netrw = 1
-- ]])

-- Generate markdown table of contents
require("nvim-toc").setup({})

-- Find, Filter, Preview, Pick. All lua, all the time.
local telescope = require("telescope")
telescope.load_extension("ui-select")
telescope.load_extension("git_file_history")
-- telescope.load_extension("fzf")

-- virtcolumn
vim.g.virtcolumn_char = "▕" -- char to display the line
vim.g.virtcolumn_priority = 10 -- priority of extmark

--  Nvim Treesitter configurations and abstraction layer
vim.opt.tags = ".vim/tags"
vim.g.autotagTagsFile = ".vim/tags"

-- require("nvim-treesitter").install({
--   "stable",
-- })

-- Smooth scrolling neovim plugin written in lua
require("neoscroll").setup()

-- A Neovim (lua) plugin for working with a markdown zettelkasten / wiki and mixing it with a journal, based on telescope.nvim
require("telekasten").setup({
  home = vim.fn.expand("~/Documents/wiki"),
})

-- -- A fast and lightweight Neovim lua plugin to keep an eye on where your cursor has jumped.
-- require("specs").setup({
--   show_jumps = true,
--   min_jump = 30,
--   popup = {
--     delay_ms = 0, -- delay before popup displays
--     inc_ms = 10, -- time increments used for fade/resize effects
--     blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
--     width = 10,
--     winhl = "PMenu",
--     fader = require("specs").linear_fader,
--     resizer = require("specs").shrink_resizer,
--   },
--   ignore_filetypes = {},
--   ignore_buftypes = {
--     nofile = true,
--   },
-- })

-- Lightweight yet powerful formatter plugin for Neovim
local prettier = { "prettierd", "prettier", stop_after_first = true }
local prettier_args = {
  "--trailing-comma",
  "all",
  "--tab-width",
  "2",
}
require("conform").setup({
  formatters_by_ft = {
    javascript = prettier,
    typescript = prettier,
    vue = prettier,
    html = prettier,
    css = prettier,
    json = prettier,
    yaml = prettier,
    markdown = prettier,
    lua = { "stylua" },
    rust = { "rustfmt" },
    nix = { "alejandra" },
    toml = { "taplo" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    terraform = { "terraform_fmt" },
    python = {
      "ruff_format", -- format
      "ruff_organize_imports", -- organize imports
      "ruff_fix", -- fix lints
    },
  },
  format_on_save = {
    lsp_format = "fallback",
  },
  formatters = {
    stylua = {
      prepend_args = {
        "--indent-width",
        "2",
        "--indent-type",
        "Spaces",
        "--column-width",
        "89",
        "--quote-style",
        "AutoPreferDouble",
      },
    },
    -- prettierd = {
    --   -- prepend_args = prettier_args,
    -- },
    prettier = {
      prepend_args = prettier_args,
    },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- nvim-lint
local lint = require("lint")
lint.linters_by_ft = {
  python = { "ruff" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  lua = { "luacheck" },
  html = { "htmlhint" },
  css = { "stylelint" },
  yaml = { "yamllint" },
  terraform = { "tfsec", "tflint", "terraform_validate" },
  -- markdown = { "vale" },
  sql = { "sqruff" },
}

lint.linters.ruff.args = {
  "--max-line-length=88",
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()

    -- -- You can call `try_lint` with a linter name or a list of names to always
    -- -- run specific linters, independent of the `linters_by_ft` configuration
    -- require("lint").try_lint("cspell")
  end,
})

-- Quickstart configurations for the Nvim completions & LSP
local servers = {
  html = {
    cmd = { "html-languageserver", "--stdio" },
    filttypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
    },
    settings = {},
  },
  elmls = {},
  svelte = {},
  dockerls = {},
  cssls = {},
  bashls = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { loadOutDirsFromCheck = true },
        procMacro = { enable = true },
      },
    },
  },
  -- yamlls = {},
  -- helm_ls = {},
  jsonls = {},
  vimls = {},
  ts_ls = {},
  dartls = {},
  prismals = {},
  graphql = {},
  lua_ls = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  },
  -- ty = {},  -- A little broken atm
  -- volar = {},
  pyrefly = {},
  clangd = {},
  terraformls = {},
  tflint = {},
  vale_ls = {},
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local on_attach = require("lsp-format").on_attach
local root_markers = { ".git", ".jj", ".venv" }

-- local handlers = {  TODO - FIX ME
--   ["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     {
--       -- Disable virtual_text
--       virtual_text = false,
--     }
--   ),
-- }

vim.lsp.config("*", {
  capabilities = capabilities,
  -- handlers = handlers,
  root_markers = root_markers,
  -- on_attach = on_attach,
})

for lsp, config in pairs(servers) do
  vim.lsp.config(lsp, config)
  vim.lsp.enable(lsp)
end

-- luasnip setup
local luasnip = require("luasnip")

luasnip.config.set_config({
  history = false,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0
--       and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
--       :sub(col, col)
--       :match("%s")
--       == nil
-- end

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<down>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- elseif luasnip.expand_or_jumpable() then
        --   luasnip.expand_or_jump()
        -- elseif has_words_before() then
        --   cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if luasnip.jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    ["<Tab>"] = {},
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    ["<S-Tab>"] = {},
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    -- { name = "cmp_tabnine" },
    -- { name = "copilot" },
    { name = "spell" },
    { name = "calc", keyword_length = 3 },
    { name = "emoji", ignored_filetypes = { "yml", "yaml", "json" } },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 3 },
  },
})

cmp.setup.cmdline(":", {
  sources = {
    { name = "cmdline" },
  },
})

-- nvim-lightbulb
local lightbulb = require("nvim-lightbulb")

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = lightbulb.update_lightbulb,
})

-- tagbar
cmd([[
  nnoremap <silent> \\ :TagbarToggle<CR>
  let g:tagbar_type_dart = { 'ctagsbin': '~/.pub-cache/bin/dart_ctags' }
  let g:tagbar_type_elm = {
            \   'ctagstype':'elm'
            \ , 'kinds':['h:header', 'i:import', 't:type', 'f:function', 'e:exposing']
            \ , 'sro':'&&&'
            \ , 'kind2scope':{ 'h':'header', 'i':'import'}
            \ , 'sort':0
            \ , 'ctagsbin':'~/.local/bin/elmtags.py'
            \ , 'ctagsargs': ''
          \ }
]])

-- copilot
vim.g.copilot_filetypes = { VimspectorPrompt = false }

-- -- Comment.nvim
-- local ft = require("Comment.ft")
-- ft.nix = { "#%s", "/*%s*/" }
-- ft.kdl = ft.get("rust")

-- ts_context_commentstring
require("ts_context_commentstring").setup({
  enable_autocmd = false,
})
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
      and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end

-- require("Comment").setup({
--   pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
-- })

-- vim-test
cmd([[
  let test#strategy = 'neovim'
  let test#python#runner = 'pytest'
]])

-- vim-expand-region
cmd([[
  let g:expand_region_text_objects = {
    \ 'iw'  :0,
    \ 'aw'  :0,
    \ 'iW'  :0,
    \ 'V'  :1,
    \ 'it'  :1,
    \ 'at'  :1,
    \ 'if'  :1,
    \ 'af'  :1,
    \ 'ic'  :1,
    \ 'ac'  :1,
    \ 'ip'  :1,
    \ 'ap'  :1,
    \ 'i"'  :1,
    \ 'a"'  :1,
    \ 'i''' :1,
    \ 'a''' :1,
    \ 'i]'  :1,
    \ 'a]'  :1,
    \ 'i)'  :1,
    \ 'a)'  :1,
    \ 'i}'  :1,
    \ 'a}'  :1,
    \ 'i>'  :1,
    \ 'a>'  :1,
    \ 'i`'  :1,
    \ 'a`'  :1,
    \ }
]])

-- WhichKey
local wk = require("which-key")
local execline = require("exec-cursorline-insert-stdout")
local wk_options = { prefix = "<space>", delay = 0 }
local wk_mappings = {
  { "<space>S", group = "split join" },
  { "<space>Sj", ":SplitjoinJoin<CR>", desc = "join" },
  { "<space>Ss", ":SplitjoinSplit<CR>", desc = "split" },
  { "<space>X", execline.execute, desc = "exec line" },
  { "<space>a", group = "action" },
  { "<space>ao", group = "open" },
  { "<space>aot", ":tabnew<CR>", desc = "tab" },
  { "<space>at", ":TOC<CR>", desc = "table of contents" },
  { "<space>c", group = "config" },
  { "<space>cc", ":tabnew ~/.files/nixos/settings.nix<CR>", desc = "nix cfg" },
  { "<space>cn", ":Xplr ~/.files/nixos/files/nvim/lua/<CR>", desc = "nvim cfg" },
  -- {
  --   "<space>cs",
  --   ":tabnew ~/.files/nixos/files/waybar/config.jsonc<CR>",
  --   desc = "statusbar cfg",
  -- },
  {
    "<space>cw",
    ":tabnew  ~/.files/nixos/files/niri/config.kdl<CR>",
    desc = "wm cfg",
  },
  { "<space>g", group = "git" },
  { "<space>gA", ":Git add .<CR>", desc = "add all" },
  { "<space>gB", ":GBrowse<CR>", desc = "browse" },
  { "<space>gD", ":Gdiffsplit<CR>", desc = "diff split" },
  { "<space>gH", "<Plug>(GitGutterPreviewHunk)<CR>", desc = "preview hunk" },
  { "<space>gP", ":Git pull<CR>", desc = "pull " },
  { "<space>ga", ":Git add %<CR>", desc = "add current" },
  { "<space>gb", ":Git blame<CR>", desc = "blame" },
  { "<space>gc", ":Git commit<CR>", desc = "commit" },
  { "<space>gd", ":DiffviewOpen<CR>", desc = "diff" },
  { "<space>gh", ":GitGutterLineHighlightsToggle<CR>", desc = "hl hunks" },
  { "<space>gj", "<Plug>(GitGutterNextHunk)<CR>", desc = "next hunk" },
  { "<space>gk", "<Plug>(GitGutterPrevHunk)<CR>", desc = "prev hunk" },
  { "<space>gl", ":Git log<CR>", desc = "log " },
  { "<space>gm", "<Plug>(git-messenger)<CR>", desc = "show commit message " },
  { "<space>go", ":OpenGithubFile<CR>", desc = "open github " },
  { "<space>gp", ":Git push<CR>", desc = "push " },
  { "<space>gr", ":GRemove<CR>", desc = "remove " },
  { "<space>gs", ":Gstatus<CR>", desc = "status" },
  { "<space>gu", "<Plug>(GitGutterUndoHunk)<CR>", desc = "undo hunk " },
  { "<space>l", group = "lsp" },
  { "<space>lR", ":LspRestart<CR>", desc = "restart" },
  { "<space>lS", vim.lsp.buf.workspace_symbols, desc = "workspace symbols" },
  { "<space>ls", vim.lsp.buf.document_symbols, desc = "document symbols" },
  {
    "<space>lL",
    function()
      vim.diagnostic.jump({ count = -1 })
      vim.diagnostic.open_float()
    end,
    desc = "prev diagnostic",
  },
  { "<space>la", vim.lsp.buf.code_action, desc = "code action" },
  { "<space>lc", vim.lsp.buf.rename, desc = "rename" },
  { "<space>ld", vim.lsp.buf.definition, desc = "definition" },
  {
    "<space>lh",
    function()
      vim.lsp.buf.hover({ border = "single" })
    end,
    desc = "hover",
  },
  { "<space>li", vim.lsp.buf.implementation, desc = "implementation" },
  {
    "<space>ll",
    function()
      vim.diagnostic.jump({ count = 1 })
      vim.diagnostic.open_float()
    end,
    desc = "next diagnostic",
  },
  { "<space>lr", vim.lsp.buf.references, desc = "references" },
  { "<space>q", ":q<CR>", desc = "quit" },
  { "<space>p", group = "plugins" },
  { "<space>pu", vim.pack.update, desc = "update plugins" },
  { "<space>s", group = "search" },
  { '<space>s"', ":FzfLua registers<CR>", desc = "registers" },
  { "<space>sC", ":FzfLua git_bcommits<CR>", desc = "buffer commits" },
  { "<space>sc", ":FzfLua git_commits<CR>", desc = "commits" },
  { "<space>sf", ":FzfLua files<CR>", desc = "files" },
  { "<space>sg", ":FzfLua git_files<CR>", desc = "git files" },
  { "<space>sm", ":FzfLua marks<CR>", desc = "marks" },
  { "<space>ss", ":FzfLua spell_suggest<CR>", desc = "grep text" },
  { "<space>st", ":FzfLua live_grep<CR>", desc = "grep text" },
  { "<space>sh", ":Telescope git_file_history<CR>", desc = "git file hist" },
  { "<space>w", ":w<CR>", desc = "write" },
  { "<space>W", ":noa w<CR>", desc = "write w/o format" },
  { "<space>x", group = "explore" },
  { "<space>x/", ":Xplr /<CR>", desc = "fs root" },
  { "<space>xp", ":Xplr '%:p'<CR>", desc = "present directory" },
  { "<space>xw", ":Xplr<CR>", desc = "working directory" },
}

wk.add(wk_mappings, wk_options)

-- --  Neovim extension for zk
-- require("zk").setup({
--   picker = "telescope",
-- })

-- -- Tools to help create flutter apps in neovim using the native lsp
-- require("flutter-tools").setup()
-- require("telescope").load_extension("flutter")
-- cmd(
--   [[autocmd BufWritePost *.dart silent execute '!kill -s USR1 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null']]
-- )

-- -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
-- require("lualine").setup()

-- colorizer
-- require("colorizer").setup()

-- material
cmd([[
  let g:material_style = "darker"
  colorscheme material
]])

-- fm-nvim
require("fm-nvim").setup({
  default = "float",
  ui = {
    float = {
      height = 0.9,
      width = 0.9,
    },
  },
  cmds = {
    xplr_cmd = "xplr",
  },
})

-- -- A dark and light Neovim theme written in Rust, inspired by IBM Carbon.
-- cmd([[colorscheme oxocarbon]])

-- cmd([[:TransparentEnable]])
