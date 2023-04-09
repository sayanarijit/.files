_G.vim = vim
_G.cmd = vim.cmd

require("packer").startup(function(use)
  -- Packer can manage itself
  use({
    "wbthomason/packer.nvim",
    opt = true,
    config = function()
      cmd([[
        augroup packer_user_config
          autocmd!
          autocmd BufWritePost plugins.lua source <afile> | PackerCompile
        augroup end
      ]])
    end,
  })

  --  Don't go there. It's a rabbithole.
  --  cmd: Xp
  use({
    "sayanarijit/xplr.vim",
    config = function()
      cmd([[
        let g:nnn#layout = { 'window': { 'width': 0.95, 'height': 0.95, 'highlight': 'Debug' } }
        let g:nnn#action = {
              \ '<c-t>': 'tab split',
              \ '<c-x>': 'split',
              \ '<c-v>': 'vsplit' }
        let g:nnn#replace_netrw = 1
      ]])
    end,
  })

  -- eyes Move faster with unique f/F indicators.
  use({ "jinh0/eyeliner.nvim" })

  --  Switch between single-line and multiline forms of code
  use({ "AndrewRadev/splitjoin.vim" })

  use({ "sayanarijit/exec-cursorline-insert-stdout.nvim" })

  -- Find, Filter, Preview, Pick. All lua, all the time.
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("ui-select")
      -- telescope.load_extension("fzf")
    end,
  })

  use({
    "ibhagwan/fzf-lua",
    -- optional for icon support
    requires = { "nvim-tree/nvim-web-devicons" },
  })

  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local nls = require("null-ls")
      nls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
          nls.builtins.formatting.stylua.with({
            extra_args = {
              "--indent-width",
              "2",
              "--indent-type",
              "Spaces",
              "--column-width",
              "89",
              "--quote-style",
              "AutoPreferDouble",
            },
          }),
          nls.builtins.formatting.rustfmt,
          nls.builtins.formatting.markdownlint,
          nls.builtins.formatting.nixpkgs_fmt,
          nls.builtins.formatting.dart_format,
          nls.builtins.formatting.elm_format,
          nls.builtins.formatting.prettierd.with({
            "--tab-width",
            "2",
            "--double-quote",
          }),
          nls.builtins.formatting.isort,
          nls.builtins.formatting.black,
          nls.builtins.formatting.taplo,
          nls.builtins.formatting.shfmt,
        },
        on_attach = function(_)
          vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.null_ls_format_if_enabled()
            augroup END
          ]])
        end,
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".nvim.settings.json",
          ".git"
        ),
      })

      nls.enabled = true
      local toggle_formatters = function()
        nls.enabled = not nls.enabled
        nls.toggle({ methods = nls.methods.FORMATTING })
      end

      vim.lsp.buf.null_ls_format_if_enabled = function()
        if nls.enabled then
          vim.lsp.buf.formatting_seq_sync()
        end
      end

      vim.api.nvim_create_user_command("NullLsToggle", toggle_formatters, {})
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  --  Nvim Treesitter configurations and abstraction layer
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      {
        "nvim-treesitter/playground",
        opt = true,
        cmd = "TSHighlightCapturesUnderCursor",
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      vim.opt.tags = ".vim/tags"
      vim.g.autotagTagsFile = ".vim/tags"

      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        sync_install = false,
        ignore_install = {
          "php",
          "phpdoc",
          "norg",
          "swift",
          "pascal",
          "grammer.js",
        },
        autotag = {
          enable = true,
        },
        highlight = {
          enable = false, -- Makes nvim slow
        },
        incremental_selection = {
          enable = true,
        },
        indent = {
          enable = false,
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
          },
        },
      })
    end,
  })

  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

  -- Brings physics-based smooth scrolling to the Vim world!
  -- use({ "yuttie/comfortable-motion.vim" })

  -- Smooth scrolling neovim plugin written in lua
  use({
    "karb94/neoscroll.nvim",
    keys = { "<C-u>", "<C-d>", "gg", "G" },
    config = function()
      require("neoscroll").setup()
    end,
  })

  -- --  vimspector - A multi-language debugging system for Vim
  -- use({
  --   "puremourning/vimspector",
  --   run = "python3 install_gadget.py --all",
  -- })

  --  Improved nginx vim plugin (incl. syntax highlighting)
  use({ "chr4/nginx.vim" })

  -- Markdown Vim Mode
  use({ "preservim/vim-markdown", requires = "godlygeek/tabular" })

  -- -- A fast and lightweight Neovim lua plugin to keep an eye on where your cursor has jumped.
  -- use({
  --   "edluffy/specs.nvim",
  --   after = "neoscroll.nvim",
  --   config = function()
  --     require("specs").setup({
  --       show_jumps = true,
  --       min_jump = 30,
  --       popup = {
  --         delay_ms = 0, -- delay before popup displays
  --         inc_ms = 10, -- time increments used for fade/resize effects
  --         blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
  --         width = 10,
  --         winhl = "PMenu",

  --         -- linear_fader ▁▂▂▃▃▄▄▅▅▆▆▇▇██
  --         -- exp_fader ▁▁▁▁▂▂▂▃▃▃▄▄▅▆▇
  --         -- pulse_fader ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁
  --         -- empty_fader ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
  --         fader = require("specs").linear_fader,

  --         -- shrink_resizer ░░▒▒▓█████▓▒▒░░
  --         -- slide_resizer ████▓▓▓▒▒▒▒░░░░
  --         -- empty_resizer ███████████████
  --         resizer = require("specs").shrink_resizer,
  --       },
  --       ignore_filetypes = {},
  --       ignore_buftypes = {
  --         nofile = true,
  --       },
  --     })
  --   end,
  -- })

  -- Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
  -- cmd: OpenGithub
  use({
    "tyru/open-browser-github.vim",
    requires = {
      "tyru/open-browser.vim",
    },
  })

  -- use({
  --   "tzachar/cmp-tabnine",
  --   run = "./install.sh",
  --   requires = "hrsh7th/nvim-cmp",
  -- })

  -- Quickstart configurations for the Nvim LSP client
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-copilot",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      -- "lukas-reineke/lsp-format.nvim",
      "kosayoda/nvim-lightbulb",
    },
    config = function()
      -- Add additional capabilities supported by nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
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
            ["rust-analyzer"] = { cargo = { loadOutDirsFromCheck = true } },
          },
        },
        yamlls = {},
        jsonls = {},
        vimls = {},
        rnix = {},
        tsserver = {},
        dartls = {},
        prismals = {},
        graphql = {},
        lua_ls = {},
        pyright = {},
        volar = {},
        clangd = {},
      }

      local on_attach = function(client)
        -- Formatting is doce by null-ls
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
      end

      local handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics,
          {
            -- Disable virtual_text
            virtual_text = false,
          }
        ),
      }

      -- local util = require("util")
      -- util.setup(servers, options)
      local lspconfig = require("lspconfig")
      for lsp, setup in pairs(servers) do
        setup.capabilities = capabilities
        setup.on_attach = on_attach
        setup.handlers = handlers
        lspconfig[lsp].setup(setup)
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

      cmd([[
        autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
      ]])
    end,
  })

  --  Vim plugin that displays tags in a window, ordered by scope
  use({
    "preservim/tagbar",
    config = function()
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
    end,
  })

  --  A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
  -- use({ "simrat39/symbols-outline.nvim" })

  --  A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
  use({ "airblade/vim-gitgutter" })

  -- Neovim plugin for GitHub Copilot
  use({
    "github/copilot.vim",
    config = function()
      vim.g.copilot_filetypes = { VimspectorPrompt = false }
    end,
  })

  --  brain muscle // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
  use({
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("Comment").setup()
    end,
  })

  --  Vim syntax for TOML
  use({ "cespare/vim-toml" })

  -- fugitive.vim: A Git wrapper so awesome, it should be illegal
  use({ "tpope/vim-fugitive" })

  -- Run your tests at the speed of thought
  use({
    "vim-test/vim-test",
    config = function()
      cmd([[
        let test#strategy = 'neovim'
        let test#python#runner = 'pytest'
      ]])
    end,
  })

  -- Easily speed up your neovim startup time!
  use({ "nathom/filetype.nvim" })

  -- Vim syntax highlighting for Google's Protocol Buffers
  use({ "uarun/vim-protobuf" })

  -- quoting/parenthesizing made simple
  use({ "tpope/vim-surround" })

  -- Git commit message viewer
  use({ "rhysd/git-messenger.vim" })

  --  Vim configuration files for Nix http://nixos.org/nix
  use({ "LnL7/vim-nix" })

  -- Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination.
  use({
    "terryma/vim-expand-region",
    config = function()
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
    end,
  })

  --  link The fancy start screen for Vim.
  use({ "mhinz/vim-startify" })

  -- boom Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
  use({
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")

      local wk_options = { prefix = "<space>" }
      local wk_mappings = {
        a = {
          name = "action",
          o = {
            name = "open",
            t = { ":tabnew<CR>", "tab" },
          },
        },
        c = {
          name = "config",
          c = {
            ":tabnew ~/.files/nixos/configuration.nix<CR>",
            "nixos config",
          },
          h = { ":tabnew ~/.files/nixos/home.nix<CR>", "home config" },
        },
        s = {
          name = "search",
          c = { ":FzfLua git_commits<CR>", "commits" },
          C = { ":FzfLua git_bcommits<CR>", "buffer commits" },
          f = { ":FzfLua files<CR>", "files" },
          g = { ":FzfLua git_files<CR>", "git files" },
          m = { ":FzfLua marks<CR>", "marks" },
          ['"'] = { ":FzfLua registers<CR>", "registers" },
          t = { ":FzfLua live_grep<CR>", "grep text" },
          s = { ":FzfLua spell_suggest<CR>", "grep text" },
        },
        S = {
          name = "split join",
          s = { ":SplitjoinSplit<CR>", "split" },
          j = { ":SplitjoinJoin<CR>", "join" },
        },
        g = {
          name = "git",
          a = { ":Git add %<CR>", "add current" },
          A = { ":Git add .<CR>", "add all" },
          b = { ":Git blame<CR>", "blame" },
          B = { ":GBrowse<CR>", "browse" },
          c = { ":Git commit<CR>", "commit" },
          d = { ":DiffviewOpen<CR>", "diff" },
          D = { ":Gdiffsplit<CR>", "diff split" },
          s = { ":Gstatus<CR>", "status" },
          h = { ":GitGutterLineHighlightsToggle<CR>", "highlight hunks" },
          H = { "<Plug>(GitGutterPreviewHunk)<CR>", "preview hunk" },
          j = { "<Plug>(GitGutterNextHunk)<CR>", "next hunk" },
          k = { "<Plug>(GitGutterPrevHunk)<CR>", "prev hunk" },
          m = { "<Plug>(git-messenger)<CR>", "show commit message " },
          l = { ":Git log<CR>", "log " },
          p = { ":Git push<CR>", "push " },
          P = { ":Git pull<CR>", "pull " },
          r = { ":GRemove<CR>", "remove " },
          u = { "<Plug>(GitGutterUndoHunk)<CR>", "undo hunk " },
          o = { ":OpenGithubFile<CR>", "open github " },
        },
        l = {
          name = "lsp",
          R = { ":LspRestart<CR>", "restart" },
          a = { vim.lsp.buf.code_action, "code action" },
          c = { vim.lsp.buf.rename, "rename" },
          d = { vim.lsp.buf.definition, "definition" },
          h = { vim.lsp.buf.hover, "hover" },
          i = { vim.lsp.buf.implementation, "implementation" },
          l = { vim.diagnostic.goto_next, "next diagnostic" },
          L = { vim.diagnostic.goto_prev, "prev diagnostic" },
          r = { vim.lsp.buf.references, "references" },
          s = { vim.lsp.buf.document_symbols, "document symbols" },
          S = { vim.lsp.buf.workspace_symbols, "workspace symbols" },
        },
        q = { ":q<CR>", "quit" },
        w = { ":w<CR>", "write" },
        x = {
          name = "explore",
          p = { ":Xp %:p<CR>", "present directory" },
          w = { ":Xp<CR>", "working directory" },
          ["/"] = { ":Xp /<CR>", "fs root" },
        },
        X = { require("exec-cursorline-insert-stdout").execute, "execute line" },
        Z = {
          name = "zk",
          Z = { ":ZkCd<CR>", "cd" },
          n = { ":ZkNotes<CR>", "notes" },
          b = { ":ZkBacklinks<CR>", "backlinks" },
          l = { ":ZkLinks<CR>", "links" },
        },
      }

      wk.register(wk_mappings, wk_options)
      vim.api.nvim_command("set timeoutlen=0")
    end,
  })

  --  Prisma 2 support for vim
  use({ "pantharshit00/vim-prisma" })

  --  A Vim plugin that provides GraphQL file detection, syntax highlighting, and indentation.
  use({ "jparise/vim-graphql" })

  -- --  Neovim extension for zk
  -- use({
  --   "mickael-menu/zk-nvim",
  --   cinfig = function()
  --     require("zk").setup({
  --       -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  --       -- it's recommended to use "telescope" or "fzf"
  --       picker = "telescope",
  --     })
  --   end,
  -- })

  use({ "tversteeg/registers.nvim" })

  -- -- Tools to help create flutter apps in neovim using the native lsp
  -- use({
  --   "akinsho/flutter-tools.nvim",
  --   requires = {
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = function()
  --     require("flutter-tools").setup()
  --     require("telescope").load_extension("flutter")
  --     cmd(
  --       [[autocmd BufWritePost *.dart silent execute '!kill -s USR1 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null']]
  --     )
  --   end,
  -- })

  -- -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  -- use({
  --   "hoob3rt/lualine.nvim",
  --   requires = { "kyazdani42/nvim-web-devicons", opt = true },
  --   config = function()
  --     require("lualine").setup()
  --   end,
  -- })

  -- The fastest Neovim colorizer.
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })

  -- Material colorscheme for NeoVim
  use({
    "marko-cerovac/material.nvim",
    config = function()
      cmd([[
        let g:material_style = "darker"
        colorscheme material
      ]])
    end,
  })

  -- -- A dark and light Neovim theme written in Rust, inspired by IBM Carbon.
  -- use({
  --   "shaunsingh/oxocarbon.nvim",
  --   branch = "fennel",
  --   config = function()
  --     cmd([[colorscheme oxocarbon]])
  --   end,
  -- })

  -- use({
  --   "xiyaowong/nvim-transparent",
  --   config = function()
  --     cmd([[:TransparentEnable]])
  --   end,
  -- })
end)
