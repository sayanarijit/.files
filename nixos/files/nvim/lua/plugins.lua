-- -- Bootstrap lazy.nvim (not required because we install via nix)
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--   local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--   if vim.v.shell_error ~= 0 then
--     vim.api.nvim_echo({
--       { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--       { out, "WarningMsg" },
--       { "\nPress any key to exit..." },
--     }, true, {})
--     vim.fn.getchar()
--     os.exit(1)
--   end
-- end
-- vim.opt.rtp:prepend(lazypath)

-- -- Make sure to setup `mapleader` and `maplocalleader` before
-- -- loading lazy.nvim so that mappings are correct.
-- -- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

local vim = vim
local cmd = vim.cmd

-- Setup lazy.nvim
require("lazy").setup({
  spec = {

    -- --  Don't go there. It's a rabbithole.
    -- --  cmd: Xp
    -- use({
    --   "sayanarijit/xplr.vim",
    --   config = function()
    --     cmd([[
    --       let g:nnn#layout = { 'window': { 'width': 0.95, 'height': 0.95, 'highlight': 'Debug' } }
    --       let g:nnn#action = {
    --             \ '<c-t>': 'tab split',
    --             \ '<c-x>': 'split',
    --             \ '<c-v>': 'vsplit' }
    --       let g:nnn#replace_netrw = 1
    --     ]])
    --   end,
    -- })

    -- -- eyes Move faster with unique f/F indicators.
    -- { "jinh0/eyeliner.nvim" },

    -- Generate markdown table of contents
    {
      "richardbizik/nvim-toc",
      config = function()
        require("nvim-toc").setup({})
      end,
      ft = { "markdown" },
    },

    --  Switch between single-line and multiline forms of code
    { "AndrewRadev/splitjoin.vim" },

    { "sayanarijit/exec-cursorline-insert-stdout.nvim" },

    -- Find, Filter, Preview, Pick. All lua, all the time.
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "isak102/telescope-git-file-history.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "tpope/vim-fugitive" },
        -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
      config = function()
        local telescope = require("telescope")
        telescope.load_extension("ui-select")
        telescope.load_extension("git_file_history")
        -- telescope.load_extension("fzf")
      end,
    },

    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
      "xiyaowong/virtcolumn.nvim",
      config = function()
        vim.g.virtcolumn_char = "▕" -- char to display the line
        vim.g.virtcolumn_priority = 10 -- priority of extmark
      end,
    },

    --  Nvim Treesitter configurations and abstraction layer
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      dependencies = {
        {
          "nvim-treesitter/playground",
          opt = true,
          cmd = "TSHighlightCapturesUnderCursor",
        },
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-textsubjects",
        "windwp/nvim-ts-autotag",
        -- "David-Kunz/markid",
      },
      config = function()
        vim.opt.tags = ".vim/tags"
        vim.g.autotagTagsFile = ".vim/tags"

        local ensure_installed = "all"
        local sync_install = false

        -- Raspberry Pi
        if vim.loop.os_gethostname() == "kunai" then
          ensure_installed = {}
          sync_install = true
        end

        require("nvim-treesitter.configs").setup({
          ensure_installed = ensure_installed,
          sync_install = sync_install,
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
          -- textsubjects = {
          --   prev_selection = ",", -- (Optional) keymap to select the previous selection
          --   enable = true,
          --   keymaps = {
          --     ["."] = "textsubjects-smart",
          --     [";"] = "textsubjects-container-outer",
          --   },
          -- },
          -- markid = { enable = true },
        })
      end,
    },

    -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

    -- Brings physics-based smooth scrolling to the Vim world!
    -- use({ "yuttie/comfortable-motion.vim" })

    -- Smooth scrolling neovim plugin written in lua
    {
      "karb94/neoscroll.nvim",
      keys = { "<C-u>", "<C-d>", "gg", "G" },
      config = function()
        require("neoscroll").setup()
      end,
    },

    -- --  vimspector - A multi-language debugging system for Vim
    -- {
    --   "puremourning/vimspector",
    --   build = "python3 install_gadget.py --all",
    -- },

    --  Improved nginx vim plugin (incl. syntax highlighting)
    { "chr4/nginx.vim" },

    -- Markdown Vim Mode
    { "preservim/vim-markdown", dependencies = "godlygeek/tabular" },
    { "jghauser/follow-md-links.nvim" },

    -- A Neovim (lua) plugin for working with a markdown zettelkasten / wiki and mixing it with a journal, based on telescope.nvim
    {
      "nvim-telekasten/telekasten.nvim",
      config = function()
        require("telekasten").setup({
          home = vim.fn.expand("~/Documents/wiki"),
        })
      end,
    },

    -- -- A fast and lightweight Neovim lua plugin to keep an eye on where your cursor has jumped.
    -- {
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
    -- },

    -- Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
    -- cmd: OpenGithub
    {
      "tyru/open-browser-github.vim",
      dependencies = {
        "tyru/open-browser.vim",
      },
    },

    -- {
    --   "tzachar/cmp-tabnine",
    --   build = "./install.sh",
    --   dependencies = "hrsh7th/nvim-cmp",
    -- },

    -- {
    --     "williamboman/mason.nvim",
    --     dependencies = {
    --       "williamboman/mason-lspconfig.nvim",
    --       -- "williamboman/mason-tool-installer.nvim",
    --     },
    --     config = function()
    --       require("mason").setup()
    --     end,
    -- },

    -- Lightweight yet powerful formatter plugin for Neovim
    {
      "stevearc/conform.nvim",
      -- enabled = false,
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      config = function()
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
      end,
    },

    {
      "mfussenegger/nvim-lint",
      -- enabled = false,
      event = { "BufWritePost" },
      config = function()
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
      end,
    },

    -- Quickstart configurations for the Nvim completions
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        -- "hrsh7th/cmp-copilot",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        -- "lukas-reineke/lsp-format.nvim",
      },
      config = function()
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

        local handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {
              -- Disable virtual_text
              virtual_text = false,
            }
          ),
        }

        vim.lsp.config("*", {
          capabilities = capabilities,
          handlers = handlers,
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
      end,
    },

    {
      "kosayoda/nvim-lightbulb",
      config = function()
        local lightbulb = require("nvim-lightbulb")

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          pattern = "*",
          callback = lightbulb.update_lightbulb,
        })
      end,
    },
    --  Vim plugin that displays tags in a window, ordered by scope
    {
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
    },

    --  A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
    -- { "simrat39/symbols-outline.nvim" },

    --  A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
    -- { "airblade/vim-gitgutter" },

    -- Neovim plugin for GitHub Copilot
    {
      "github/copilot.vim",
      config = function()
        vim.g.copilot_filetypes = { VimspectorPrompt = false }
      end,
    },

    --  brain muscle // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
    {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup()
      end,
    },

    --  Vim syntax for TOML
    { "cespare/vim-toml" },

    -- fugitive.vim: A Git wrapper so awesome, it should be illegal
    -- { "tpope/vim-fugitive" },

    -- Run your tests at the speed of thought
    {
      "vim-test/vim-test",
      config = function()
        cmd([[
        let test#strategy = 'neovim'
        let test#python#runner = 'pytest'
      ]])
      end,
    },

    -- Vim syntax highlighting for Google's Protocol Buffers
    { "uarun/vim-protobuf" },

    -- quoting/parenthesizing made simple
    { "tpope/vim-surround" },

    -- Git commit message viewer
    -- use({ "rhysd/git-messenger.vim" })

    --  Vim configuration files for Nix http://nixos.org/nix
    { "LnL7/vim-nix" },

    -- -- Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination.
    {
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
    },

    --  link The fancy start screen for Vim.
    { "mhinz/vim-startify" },

    -- boom Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that
    -- displays a popup with possible keybindings of the command you started typing.
    {
      "folke/which-key.nvim",
      config = function()
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
          { "<space>lL", vim.diagnostic.goto_prev, desc = "prev diagnostic" },
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
          { "<space>ll", vim.diagnostic.goto_next, desc = "next diagnostic" },
          { "<space>lr", vim.lsp.buf.references, desc = "references" },
          { "<space>q", ":q<CR>", desc = "quit" },
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
      end,
    },

    --  Prisma 2 support for vim
    { "pantharshit00/vim-prisma" },

    --  A Vim plugin that provides GraphQL file detection, syntax highlighting, and indentation.
    { "jparise/vim-graphql" },

    -- --  Neovim extension for zk
    -- {
    --   "mickael-menu/zk-nvim",
    --   config = function()
    --     require("zk").setup({
    --       -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    --       -- it's recommended to use "telescope" or "fzf"
    --       picker = "telescope",
    --     })
    --   end,
    -- },

    { "tversteeg/registers.nvim" },

    -- -- Tools to help create flutter apps in neovim using the native lsp
    -- use({
    --   "akinsho/flutter-tools.nvim",
    --   dependencies = {
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
    -- }),

    -- -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    -- use({
    --   "hoob3rt/lualine.nvim",
    --   dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    --   config = function()
    --     require("lualine").setup()
    --   end,
    -- }),

    -- The fastest Neovim colorizer.
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    },

    -- Material colorscheme for NeoVim
    {
      "marko-cerovac/material.nvim",
      config = function()
        cmd([[
        let g:material_style = "darker"
        colorscheme material
      ]])
      end,
    },

    {
      "is0n/fm-nvim",
      config = function()
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
      end,
    },

    -- -- A dark and light Neovim theme written in Rust, inspired by IBM Carbon.
    -- use({
    --   "shaunsingh/oxocarbon.nvim",
    --   branch = "fennel",
    --   config = function()
    --     cmd([[colorscheme oxocarbon]])
    --   end,
    -- }),

    -- use({
    --   "xiyaowong/nvim-transparent",
    --   config = function()
    --     cmd([[:TransparentEnable]])
    --   end,
    -- }),
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
  default = { lazy = true },
})
