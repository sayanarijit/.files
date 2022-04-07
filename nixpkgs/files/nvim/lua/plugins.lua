local use = require("packer").use

return require("packer").startup(function()
  --  Don't go there. It's a rabbithole.
  --  cmd: Xp
  use({
    "sayanarijit/xplr.vim",
    config = function()
      vim.cmd([[
        let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Debug' } }
        let g:nnn#action = {
              \ '<c-t>': 'tab split',
              \ '<c-x>': 'split',
              \ '<c-v>': 'vsplit' }
        let g:nnn#replace_netrw = 1
      ]])
    end,
  })

  -- Packer can manage itself
  use({
    "wbthomason/packer.nvim",
    opt = true,
    setup = function()
      vim.cmd([[
        augroup packer_user_config
          autocmd!
          autocmd BufWritePost plugins.lua source <afile> | PackerCompile
        augroup end
      ]])
    end,
  })

  -- Find, Filter, Preview, Pick. All lua, all the time.
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("telescope").setup()
    end,
  })

  -- VSCode bulb for neovim's built-in LSP.
  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.cmd([[
        autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
      ]])
    end,
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
        ensure_installed = "maintained",
        ignore_install = { "php" },
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

  -- Quickstart configurations for the Nvim LSP client
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/nvim-lsp-installer",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "saecki/crates.nvim",
      "L3MON4D3/LuaSnip",
      'lukas-reineke/lsp-format.nvim'
    },
    config = function()
      local util = require("util")

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

      local lspconfig = require("lspconfig")

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
        sumneko_lua = {},
        pylsp = {},
      }

      local on_attach = require"lsp-format".on_attach

      local options = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      util.setup(servers, options)

      -- for lsp, setup in pairs(servers) do
      --   setup.capabilities = capabilities
      --   lspconfig[lsp].setup(setup)
      -- end

      -- luasnip setup
      local luasnip = require("luasnip")

      luasnip.config.set_config({
        history = false,
        -- Update more often, :h events for more info.
        updateevents = "TextChanged,TextChangedI",
      })

      require("luasnip/loaders/from_vscode").load()

      --- <tab> to jump to next snippet's placeholder
      local function on_tab()
        return luasnip.jump(1) and "" or util.t("<Tab>")
      end

      --- <s-tab> to jump to next snippet's placeholder
      local function on_s_tab()
        return luasnip.jump(-1) and "" or util.t("<S-Tab>")
      end

      util.imap("<Tab>", on_tab, { expr = true })
      util.smap("<Tab>", on_tab, { expr = true })
      util.imap("<S-Tab>", on_s_tab, { expr = true })
      util.smap("<S-Tab>", on_s_tab, { expr = true })

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
            select = true,
          }),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "crates" },
          { name = "spell" },
          { name = "calc", keyword_length = 3 },
          { name = "emoji", ignored_filetypes = { "yml", "yaml", "json" } },
          { name = "luasnip" },
          -- { name = 'cmp-tabnine' },
          { name = "buffer", keyword_length = 3 },
        },
      })

      cmp.setup.cmdline(":", {
        sources = {
          { name = "cmdline" },
        },
      })
    end,
  })

  --  Vim plugin that displays tags in a window, ordered by scope
  use({
    "preservim/tagbar",
    config = function()
      vim.cmd([[
        nnoremap <silent> \\ :TagbarToggle<CR>
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
      vim.cmd([[
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

  --  Vim syntax highlighting and indentation for Svelte 3 components.
  use({ "evanleck/vim-svelte" })

  -- Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination.
  use({
    "terryma/vim-expand-region",
    config = function()
      vim.cmd([[
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
          c = { ":tabnew ~/.config/nixpkgs/files/nvim/init.lua<CR>", "neovim config" },
          h = { ":tabnew ~/.config/nixpkgs/home.nix<CR>", "home config" },
        },

        s = {
          name = "search",
          c = { ":Telescope git_commits<CR>", "commits" },
          C = { ":Telescope git_bcommits<CR>", "buffer commits" },
          f = {
            ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>",
            "files",
          },
          g = { ":Telescope git_files<CR>", "git files" },
          m = { ":Telescope marks<CR>", "marks" },
          M = {
            ":lua require('telescope').extensions.media_files.media_files()<CR>",
            "media",
          },
          ['"'] = { ":Telescope registers<CR>", "registers" },
          t = { ":Telescope live_grep<CR>", "grep text" },
          s = { ":Telescope spell_suggest<CR>", "grep text" },
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
          a = { ":Telescope lsp_code_actions<CR>", "code action" },
          d = {
            ":Telescope lsp_definitions<CR>",
            "definition",
          },
          h = { ":lua vim.lsp.buf.hover()<CR>", "hover" },
          i = { ":Telescope lsp_implementations()<CR>", "implementation" },
          r = { ":Telescope lsp_references<CR>", "references" },
          s = { ":Telescope lsp_document_symbols<CR>", "document symbols" },
          S = { ":Telescope lsp_workspace_symbols<CR>", "workspace symbols" },
        },

        q = { ":q<CR>", "quit" },

        w = { ":w<CR>", "write" },

        x = {
          name = "explore",
          p = { ":Xp %:p<CR>", "present directory" },
          w = { ":Xp<CR>", "working directory" },
          h = { ":Xp ~<CR>", "home directory" },
          ["/"] = { ":Xp /<CR>", "fs root" },
        },

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

  --  Neovim extension for zk 
  use({ "mickael-menu/zk-nvim", cinfig = function ()
    require("zk").setup({
      -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
      -- it's recommended to use "telescope" or "fzf"
      picker = "telescope",

    })
  end})

  use({ 'tversteeg/registers.nvim' })

  -- Tools to help create flutter apps in neovim using the native lsp
  use({ "akinsho/flutter-tools.nvim" , config = function ()
    vim.cmd[[autocmd BufWritePost *.dart silent execute '!kill -s USR1 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null']]
  end})

  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  use({
    "hoob3rt/lualine.nvim",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup()
    end
  })

  -- Adds file type icons to Vim plugins (should be at the bottom)
  use({ "ryanoasis/vim-devicons" })

  -- The fastest Neovim colorizer.
  use({ 'norcalli/nvim-colorizer.lua' })

  -- Material colorscheme for NeoVim
  use({ "marko-cerovac/material.nvim", config = function ()
    vim.cmd[[
      set guifont=FiraCode\ Nerd\ Font:h19
      set cursorline
      set cursorcolumn
      set colorcolumn=80
      set background=dark
      let g:airline_theme='material'
      let g:gruvbox_contrast_dark='soft'
      let g:material_style = "darker"
      highlight link CompeDocumentation NormalFloat
      colorscheme material
    ]]
  end})
end)
