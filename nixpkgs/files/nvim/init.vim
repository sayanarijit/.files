" A Few Notes
" ===========

" - I prefer a single file when it comes to configuration.
" - Although, I may consider refactoring it into multiple files when I convert it to `init.lua` (for LSP support).
" - I prefer not to learn external key mappings (e.g. plugins functionalities). I `WhichKey` them.
" - I also `WhichKey` some built-in key mappings that I only use occasionally.
" - I prefer arrow keys than hjkl because they work everywhere, not just terminal apps. Also, I have gaming experience with arrow keys.
" - I hate prompts.
" - I use small screen (13-14 inch) laptops, so I make heavy use of tabs and don't usually use splits.

set shell=/bin/sh
set rtp +=~/.vim
syntax on

"""<Plugins>"""
call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'  " Requirement for xplr.nvim
Plug 'mhartington/formatter.nvim'
" Plug 'sindrets/diffview.nvim'  "  Single tabpage interface to easily cycle through diffs for all modified files for any git rev.
Plug 'sayanarijit/xplr.vim'  " Rabbit hole warning. Don't go there.
Plug 'sayanarijit/exec-cursorline-insert-stdout.nvim'
Plug 'nvim-lua/telescope.nvim'  "  Find, Filter, Preview, Pick. All lua, all the time.
Plug 'nvim-telescope/telescope-media-files.nvim'  "  Telescope extension to preview media files using Ueberzug.
Plug 'fhill2/xplr.nvim'  "  WIP - neovim plugin - xplr in floating window with msgpack communication
Plug 'kosayoda/nvim-lightbulb'  "  VSCode bulb for neovim's built-in LSP
Plug 'nvim-lua/popup.nvim'
" Plug 'puremourning/vimspector'  "  vimspector - A multi-language debugging system for Vim
Plug 'windwp/nvim-ts-autotag'  "  Use treesitter to auto close and auto rename html tag
Plug 'dhruvasagar/vim-table-mode'  "  VIM Table Mode for instant table creation. 
" Plug 'Pocco81/AutoSave.nvim' " A NeoVim plugin for saving your work before the world collapses or you type :qa!
 Plug 'yuttie/comfortable-motion.vim'  "  Brings physics-based smooth scrolling to the Vim world!
" Plug 'karb94/neoscroll.nvim'  "  Smooth scrolling neovim plugin written in lua 
Plug 'tyru/open-browser.vim'  " Open URI with your favorite browser from your most favorite editor
Plug 'tyru/open-browser-github.vim'  " Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
" Plug 'ThePrimeagen/vim-be-good'  " A vim game :VimBeGood
Plug 'neovim/nvim-lsp'  "  Nvim LSP client configurations
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'  " Create your own textobjects using tree-sitter queries!
" Plug 'romgrk/nvim-treesitter-context'
" Plug 'nvim-treesitter/nvim-treesitter-refactor'  "  Refactor module for nvim-treesitter
" Plug 'nvim-treesitter/completion-treesitter'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  " Dark powered asynchronous completion framework for neovim/Vim8 
" Plug 'Shougo/deoplete-lsp'  "  LSP Completion source for deoplete 
" Plug 'nvim-lua/completion-nvim'  "  A async completion framework aims to provide completion to neovim's built in LSP written in Lua 
" Plug 'deoplete-plugins/deoplete-jedi'  "  deoplete.nvim source for Python
Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
" Plug 'liuchengxu/vista.vim'  "  Viewer & Finder for LSP symbols and tags 
" Plug 'vim-airline/vim-airline'  " make statusline awesome
" Plug 'hardcoreplayers/spaceline.vim'  " vim statusline like spacemacs
Plug 'hrsh7th/nvim-cmp'  "  Auto completion plugin for nvim that written in Lua.
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/cmp-cmdline'
" Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'saecki/crates.nvim'
Plug 'pelodelfuego/vim-swoop'
Plug 'windwp/nvim-spectre' "  Find the enemy and replace them with dark power. 
" Plug 'wsdjeg/FlyGrep.vim'  "  awesome grep on the fly
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'dstein64/nvim-scrollview'  " A Neovim plugin that displays interactive vertical scrollbars.
" Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'b3nj5m1n/kommentary' "  Neovim commenting plugin, written in lua. 
" Plug 'ggandor/lightspeed.nvim'  " Next-generation motion plugin with incremental input processing, allowing for unparalleled speed with near-zero cognitive effort
" Plug 'kien/ctrlp.vim'  " fuzzy search files
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}  " Intellisense and auto completion
Plug 'cespare/vim-toml'  "  Vim syntax for TOML
Plug 'craigemery/vim-autotag'  " Update tags
Plug 'tpope/vim-fugitive'  " Git integration
Plug 'janko-m/vim-test'  " Test runner
Plug 'uarun/vim-protobuf' "  Vim syntax highlighting for Google's Protocol Buffers 
" Plug 'benmills/vimux'  " Runs tests in new tmux window
Plug 'tpope/vim-surround'  " quoting/parenthesizing made simple
" Plug 'fatih/vim-go'  " Go development
" Plug 'rust-lang/rust.vim'  " Rust development
Plug 'rhysd/git-messenger.vim'  " Git commit message viewer
" Plug 'wellle/context.vim'  " Context of current buffer
Plug 'LnL7/vim-nix'  " Nix support
Plug 'evanleck/vim-svelte'  " Svelte support
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'  " Fuzzy finder vim support
Plug 'terryma/vim-expand-region'  " visually select increasingly larger regions of text
Plug 'rlane/pounce.nvim'  " Incremental fuzzy search motion plugin for Neovim
" Plug 'SirVer/ultisnips'  " The ultimate snippet solution for Vim
" Plug 'honza/vim-snippets'  " Snippets are separated from the engine
" Plug 'liuchengxu/vim-which-key'  " Vim plugin that shows keybindings in popup
Plug 'L3MON4D3/LuaSnip'  "  Snippet Engine for Neovim written in Lua.
Plug 'folke/which-key.nvim'  " vim-which-key but in Lua
Plug 'mhinz/vim-startify'  " The fancy start screen for Vim.
Plug 'pantharshit00/vim-prisma'  "  Prisma 2 support for vim 
Plug 'jparise/vim-graphql'  "  A Vim plugin that provides GraphQL file detection, syntax highlighting, and indentation.
" Plug 'unblevable/quick-scope'  " Lightning fast left-right movement in Vim
Plug 'mickael-menu/zk-nvim'
Plug 'vim-scripts/haproxy'  " syntax for haproxy
" Plug 'jeetsukumaran/vim-pythonsense'  " Motions for Python classes, methods, functions, and doc strings.
Plug 'andys8/vim-elm-syntax', { 'for': ['elm'] }  " Syntax highlighting for elm
Plug 'christoomey/vim-titlecase'  "  Teach Vim about titlecase, with support for motions and text objects 
" Plug 'Einenlum/yaml-revealer'  " A vim plugin to handle Yaml files
Plug 'jeetsukumaran/vim-indentwise'  " A Vim plugin for indent-level based motion.
Plug 'AndrewRadev/splitjoin.vim'  " Switch between single-line and multiline forms of code
" Plug 'junegunn/vim-peekaboo'  " / @ / CTRL-R 
Plug 'tversteeg/registers.nvim'
Plug 'lark-parser/vim-lark-syntax'  " Vim files needed to have syntax highlighting in python lark-parser files 
" Plug 'ap/vim-css-color'  "  Preview colours in source code while editing
" Plug 'scrooloose/nerdtree'  " Tree view for vim
Plug 'sbdchd/neoformat'  "  A (Neo)vim plugin for formatting code.
Plug 'akinsho/flutter-tools.nvim'  " Tools to help create flutter apps in neovim using the native lsp
" Plug 'hankchiutw/flutter-reload.vim'  " Reload flutter automatically when saving a dart file
Plug 'lifepillar/vim-solarized8'  " Light and dark theme
Plug 'joshdick/onedark.vim'  " Atom onedark theme
Plug 'rakr/vim-one'  " Adaptation of one-light and one-dark colorschemes for Vim
Plug 'KeitaNakamura/neodark.vim'  " A dark color scheme for vim
Plug 'morhetz/gruvbox'  " Retro groove color scheme for Vim
Plug 'marko-cerovac/material.nvim'  "   Material colorscheme for NeoVim
" Plug 'sayanarijit/vim-floaterm'  " 🌟 Use nvim/vim's builtin terminal in the floating/popup window
" Plug 'kamykn/spelunker.vim'  " Improved vim spelling plugin (with camel case support)!
Plug 'hoob3rt/lualine.nvim' "  A blazing fast and easy to configure neovim statusline plugin written in pure lua.
Plug 'norcalli/nvim-colorizer.lua'  "  The fastest Neovim colorizer.
Plug 'kyazdani42/nvim-web-devicons'  "  lua `fork` of vim-web-devicons for neovim 
Plug 'ryanoasis/vim-devicons'  " Adds file type icons to Vim plugins (should be at the bottom)
call plug#end()
"""</Plugins>"""


"""<Custom settings>"""
" Basic config
let mapleader = ","  " Keep it at the top

set noautochdir  " Don't change directory when opening a file
set nu relativenumber  " No need to count lines from current position
set autoread  " Auto reload when file changes
set notagrelative  " Use full file path when generating tags
set showtabline=2  " Show tabname even if only one file is open
set scrolloff=5  " Keep some space while scrolling vertically
set splitbelow  " Opens new hsplits below the current window
set splitright  " Opens new vsplits right side of the current window
set lazyredraw  " Prevent screen flickering when opening vim inside vim
set nohlsearch  " Turn off search highlight
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes
filetype plugin indent on
set tabstop=4  " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab  " Convert tabs to spaces (I don't write golang anymore)
set smartindent
set inccommand=nosplit

" use 2 spaces for yaml & lua
autocmd FileType yaml,yml,json,lua,html,sql,js,ts,jsx,tsx,svelte,cjs,prisma,gql,graphql,dart setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab smarttab

" Enable spell checker for git commits and docs
autocmd FileType gitcommit,md,rst,txt setlocal spell

autocmd BufNewFile,BufRead *.graphql,*.gql setfiletype graphql

" Format on save

augroup Format
    autocmd!
    autocmd BufWritePost * FormatWrite
    autocmd BufWritePost *.dart silent execute '!kill -s USR1 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null'
augroup END

" Remap for rename current word
vnoremap <leader>r "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>
vnoremap <leader>R "hy:bufdo %s/<C-r>h/<C-r>h/gce<left><left><left><left>

" GUI features
set mouse=a  " Activate mouse support. Use + register for copy/paste.
" set clipboard+=unnamedplus  " Use clipboard for yanking and pasting

" Persistant undo history
set undofile
set undodir=/tmp/vimundo/

" NeoVim configuration
command Config :tabnew ~/.config/nixpkgs/files/nvim/init.vim

" Darwin configuration
command DarwinConfig :tabnew ~/.nixpkgs/darwin-configuration.nix
command HomeConfig :tabnew ~/.config/nixpkgs/home.nix

" tags
set tags=.vim/tags  " Where to store tags file
let g:autotagTagsFile = ".vim/tags"  " ^^
" let g:fzf_tags_command = 'ctags -R -f .vim/tags --exclude=.vim/*'

" Key mappings
inoremap <silent> <c-a> <ESC>I
inoremap <silent> <c-e> <ESC>A
inoremap <silent> <a-left> <c-left>
inoremap <silent> <a-right> <c-right>
nnoremap <silent> <a-left> :tabprevious<CR>
nnoremap <silent> <a-right> :tabnext<CR>
nnoremap <silent> <a-s-right> :tabm +1<CR>
nnoremap <silent> <a-s-left> :tabm -1<CR>

" The ultimate neovim key mappings I wish I came up with sooner.
" This let's us use `Y` as an alternative to `y` that uses the
" system clipboard instead of the regular registers.
nnoremap <silent> Y "+y
vnoremap <silent> Y "+y
nnoremap <silent> P "+P
vnoremap <silent> P "+P

" For terminal mode
tnoremap <c-\><c-\> <c-\><c-n>

" Terminal in a new tab
command TerminalTab :tabnew term://$SHELL

" Terminal in a horizontal split
command TerminalHSplit :split term://$SHELL

" Terminal in a vertical split
command TerminalVSplit :vsplit term://$SHELL

" Open all modified git files
command GitModified :args `git diff --name-only origin/master; git ls-files --other --exclude-standard` | argdo tabe

command ExecuteLine :lua require"exec-cursorline-insert-stdout".execute{prepare_for_next_command = true}

nnoremap <silent> X :ExecuteLine<CR>

" I forgot what it is
" autocmd QuickFixCmdPost *grep* cwindow
"""</Custom settings>"""

"""<Testing: vim-test>"""
let test#strategy = "neovim"
let test#python#runner = 'pytest'
"""</Testing>

"""<elm-vim>"""
let g:elm_setup_keybindings = 0
"""</elm-vim>"""

"""<Tagbar: tagbar>"""
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
" autocmd BufNewFile,BufRead * :call tagbar#autoopen()
"""</Tagbar>"""

"""<Tagbar: vista>"""
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
" let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" Update the vista on |TextChanged| and |TextChangedI|.
let g:vista_update_on_text_changed = 1

" nnoremap <silent> \\ :Vista!!<CR>
"""</Tagbar>

"""<Tree view: nerdtree>"""
" nnoremap <silent> // :NERDTreeToggle<CR>
"""</Tree view>"""

"""<Start page: Startify>"""
let g:startify_lists = [
	\ { 'type': 'commands',  'header': ['   Commands']       },
	\ { 'type': 'sessions',  'header': ['   Sessions']       },
	\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
	\ { 'type': 'files',     'header': ['   MRU']            },
	\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	\ ]

let g:startify_commands = [
	\ {'*': ['Git Modified Files', ':GitModified']},
	\ {'f': ['Search Files', ':Files .']},
	\ {'F': ['Search GitHub Files', ':GFiles']},
	\ {'T': ['Open Terminal', ':terminal $SHELL']},
	\ ]
"""</Start page>"""

"""<Expand Region: vim-expand-region>"""
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
"""</Expand Region>"""

"""<Fuzzy search: fzf>"""
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
"""</FUzzy search>"""

"""<File Manager: xplr>"""
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Debug' } }
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }
command NnnProjectRoot :NnnPicker `git rev-parse --show-toplevel`
let g:nnn#replace_netrw = 1
"""</File Manager>"""

"""<Snippets: Ultisnips>"""
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"""</Snippets>"""

"""<Colorizer>"""
set termguicolors
" lua require'colorizer'.setup()
"""</Colorizer>"""

"""<Bufferline>"""
" lua require'bufferline'.setup()
"""</Bufferline>"""


"""<VimWiki>"""
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
"""</VimWiki>"""

"""<Smooth scrolling>"""
" let g:SimpleSmoothScrollDelay=3
"""</Smooth scrolling>"""

"""<Language server and auto completion>"""
" let g:python3_host_prog = '/home/sayanarijit/.nix-profile/bin/python3'

if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')

    lua require'lspconfig'.pylsp.setup{}
endif

set completeopt=menu,menuone,noselect,noinsert

"" deoplete-jedi
let g:deoplete#sources#jedi#python_path = '/home/sayanarijit/.nix-profile/bin/python3'

"" diagnostic-nvim
let g:diagnostic_enable_virtual_text = 0

"" completion-nvim
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_chain_complete_list = {
    \'default' : [
    \    {'complete_items': ['lsp', 'snippet', 'path']},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
    \}
let g:completion_matching_ignore_case = 1
" autocmd BufEnter * lua require'completion'.on_attach()

"" deoplete-lsp
let g:deoplete#enable_at_startup = 1

"" nvim-lightbulb
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

"" pounce
nmap s <cmd>Pounce<CR>
vmap s <cmd>Pounce<CR>
omap gs <cmd>Pounce<CR>  " 's' is used by vim-surround

"" language servers are installed with nix-darwin
:lua << EOF
-- vim.lsp.set_log_level("debug")

-- require'neoscroll'.setup()

require('telescope').load_extension('media_files')

require("zk").setup()

require'pounce'.setup{
  accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
  debug = false,
}

require'lspconfig'.html.setup{
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
}
require'lspconfig'.elmls.setup{}
require'lspconfig'.svelte.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.rust_analyzer.setup{
    settings = {
        ["rust-analyzer"] =  { cargo = { loadOutDirsFromCheck = true } },
    },
}
-- require'lspconfig'.rls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.rnix.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.dartls.setup{}
require'lspconfig'.prismals.setup{}
require'lspconfig'.graphql.setup{}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/home/sayanarijit/Documents/GitHub/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require'nvim-treesitter.configs'.setup{
  ensure_installed="maintained",
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
}

require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})
require('kommentary.config').use_extended_mappings()
require('lualine').setup{theme = 'material-nvim'}

require("flutter-tools").setup {}
require("luasnip.loaders.from_vscode").lazy_load()

-- require("flutter-tools").setup {
--   ui = {
--     -- the border type to use for all floating windows, the same options/formats
--     -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
--     border = "rounded",
--   },
--   decorations = {
--     statusline = {
--       -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
--       -- this will show the current version of the flutter app from the pubspec.yaml file
--       app_version = false,
--       -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
--       -- this will show the currently running device if an application was started with a specific
--       -- device
--       device = false,
--     }
--   },
--   debugger = { -- integrate with nvim dap + install dart code debugger
--     enabled = false,
--   },
--   -- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
--   flutter_lookup_cmd = "dirname $(which flutter)", -- example "dirname $(which flutter)" or "asdf where flutter"
--   -- fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
--   widget_guides = {
--     enabled = false,
--   },
--   closing_tags = {
--     highlight = "ErrorMsg", -- highlight for the closing tag
--     prefix = ">", -- character to use for close tag e.g. > Widget
--     enabled = true -- set to false to disable
--   },
--   dev_log = {
--     open_cmd = "tabedit", -- command to use to open the log buffer
--   },
--   dev_tools = {
--     autostart = true, -- autostart devtools server if not detected
--     auto_open_browser = true, -- Automatically opens devtools in the browser
--   },
--   outline = {
--     open_cmd = "30vnew", -- command to use to open the outline buffer
--     auto_open = true -- if true this will open the outline automatically when it is first populated
--   },
--   --lsp = {
--   --  on_attach = my_custom_on_attach,
--   --  capabilities = my_custom_capabilities -- e.g. lsp_status capabilities
--   --  --- OR you can specify a function to deactivate or change or control how the config is created
--   --  capabilities = function(config)
--   --    config.specificThingIDontWant = false
--   --    return config
--   --  end,
--   --  settings = {
--   --    showTodos = true,
--   --    completeFunctionCalls = true,
--   --    analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
--   --  }
--   --}
-- }

-- local cb = require'diffview.config'.diffview_callback

-- require('diffview').setup {
--   diff_binaries = false,    -- Show diffs for binaries
--   file_panel = {
--     width = 35,
--     use_icons = true        -- Requires nvim-web-devicons
--   },
--   key_bindings = {
--     -- The `view` bindings are active in the diff buffers, only when the current
--     -- tabpage is a Diffview.
--     view = {
--       ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file 
--       ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
--       ["<leader>e"] = cb("focus_files"),        -- Bring focus to the files panel
--       ["<leader>b"] = cb("toggle_files"),       -- Toggle the files panel.
--     },
--     file_panel = {
--       ["j"]         = cb("next_entry"),         -- Bring the cursor to the next file entry
--       ["<down>"]    = cb("next_entry"),
--       ["k"]         = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
--       ["<up>"]      = cb("prev_entry"),
--       ["<cr>"]      = cb("select_entry"),       -- Open the diff for the selected entry.
--       ["o"]         = cb("select_entry"),
--       ["R"]         = cb("refresh_files"),      -- Update stats and entries in the file list.
--       ["<tab>"]     = cb("select_next_entry"),
--       ["<s-tab>"]   = cb("select_prev_entry"),
--       ["<leader>e"] = cb("focus_files"),
--       ["<leader>b"] = cb("toggle_files"),
--     }
--   }
-- }

-- require('compe').setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'enable';
--   throttle_time = 80;
--   source_timeout = 200;
--   resolve_timeout = 800;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--   documentation = true;
-- 
--   source = {
--     path = true;
--     buffer = true;
--     calc = true;
--     nvim_lsp = true;
--     nvim_lua = true;
--     vsnip = true;
--     ultisnips = true;
--   };
-- }

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noselect,noinsert",
  },
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "crates" },
    { name = 'spell' },
    { name = 'calc', keyword_length = 3 },
    { name = 'emoji', ignored_filetypes = { "yml", "yaml", "json" } },
    { name = 'luasnip' },
    -- { name = 'cmp-tabnine' },
    { name = 'buffer', keyword_length = 3 },
  })
})

cmp.setup.cmdline(':', {
    sources = {
        { name = "cmdline" },
    }
})

-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' },
--   }
-- })

local wk = require("which-key")

local wk_options = { prefix = "<space>" }
local wk_mappings = {
    a = {
        name = "action",
        o = {
            name = "open",
            t = { ":tabnew<CR>", "tab" },
            G = { ":GitModified<CR>", "git modified files" },
        },
        t = {
            name = "terminal",
            t = { ":TerminalTab<CR>", "new tab" },
            h = { ":TerminalHSplit<CR>", "horizontal split" },
            v = { ":TerminalVSplit<CR>", "vertical split" },
        },
        w = {
            name = "writing",
            t = { "<Plug>Titlecase<CR>", "title case" },
            T = { "<Plug>TitlecaseLine<CR>", "title case line" },
        },
    },

    c = {
        name = "config",
        c = { ":Config<CR>", "neovim config" },
        h = { ":HomeConfig<CR>", "home config" },
    },

    s = {
        name = "search",
        c = { ":Telescope git_commits<CR>", "commits" },
        C = { ":Telescope git_bcommits<CR>", "buffer commits" },
        f = { ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", "files" },
        g = { ":Telescope git_files<CR>", "git files" },
        m = { ":Telescope marks<CR>", "marks" },
        M = { ":lua require('telescope').extensions.media_files.media_files()<CR>", "media" },
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
        G = { ":GitModified<CR>", "" },
        G = { ":GitModified<CR>"                      , "edit modified" },
        s = { ":Gstatus<CR>"                          , "status" },
        h = { ":GitGutterLineHighlightsToggle<CR>"    , "highlight hunks" },
        H = { "<Plug>(GitGutterPreviewHunk)<CR>"      , "preview hunk" },
        j = { "<Plug>(GitGutterNextHunk)<CR>"         , "next hunk" },
        k = { "<Plug>(GitGutterPrevHunk)<CR>"         , "prev hunk" },
        m = { "<Plug>(git-messenger)<CR>"             , "show commit message "},
        l = { ":Git log<CR>"                          , "log "},
        p = { ":Git push<CR>"                         , "push "},
        P = { ":Git pull<CR>"                         , "pull "},
        r = { ":GRemove<CR>"                          , "remove "},
        u = { "<Plug>(GitGutterUndoHunk)<CR>"         , "undo hunk "},
        o = { ":OpenGithubFile<CR>"                   , "open github "},
    },

    l = {
        name = "lsp",
        R = { ":LspRestart<CR>"                         , "restart" },
        a = { ":Telescope lsp_code_actions<CR>"         , "code action" },
        d = { ":Telescope lsp_definitions<CR>"                         , "definition" },
        F = { ":Format<CR>"                             , "format" },
        h = { ":Hover<CR>"                              , "hover" },
        i = { ":Implementation<CR>"                     , "implementation" },
        l = { ":NextDiagnostic<CR>"                     , "next diagnostic" },
        L = { ":PrevDiagnostic<CR>"                     , "prev diagnostic" },
        r = { ":Telescope lsp_references<CR>"           , "references" },
        s = { ":Telescope lsp_document_symbols<CR>"     , "document symbols" },
        S = { ":Telescope lsp_workspace_symbols<CR>"    , "workspace symbols" },
        t = { ":TypeDefinition<CR>"                     , "type definition" },
    },

    q = { ":q<CR>", "quit" },

    w = { ":w<CR>", "write" },

    x = {
        name = "explore",
        p = { ":NnnPicker %:p<CR>", "present directory" },
        w = { ":NnnPicker<CR>", "working directory" },
        g = { ":NnnProjectRoot<CR>", "git project root" },
        h = { ":NnnPicker ~<CR>", "home directory" },
        ["/"] = { ":NnnPicker /<CR>", "fs root" },
    },
}

wk.register(wk_mappings, wk_options)
vim.api.nvim_command("set timeoutlen=0")


local prettierconfig = {
   function()
      return {
        exe = "prettier",
        args = {"--tab-width", "2", "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
        stdin = true
      }
    end
}

require('formatter').setup({
  logging = false,
  filetype = {
    nix = {
      -- nix
      function()
        return {
          exe = "nixfmt",
          args = {},
          stdin = true
        }
      end
    },
    prisma = {
      -- prisma
      function()
        return {
          exe = "yarn run prisma format",
          args = {},
          stdin = false
        }
      end
    },
    sql = {
      -- sql
      function()
        return {
          exe = "sql-formatter",
          args = {"-u"},
          stdin = true
        }
      end
    },
    dart = {
      -- dart
      function()
        return {
          exe = "dart",
          args = {"format", "-o", "show"},
          stdin = true
        }
      end
    },
    elm = {
      -- elm-format
      function()
        return {
          exe = "elm-format",
          args = {"--yes", "--stdin"},
          stdin = true
        }
      end
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true
        }
      end
    },
    lua = {
        -- stylua
        function()
          return {
            exe = "stylua",
            args = {"--indent-width", 2, "--indent-type", "Spaces", "--column-width", 80, "--quote-style", "AutoPreferDouble", "-"},
            stdin = true
          }
        end
    },
    toml = {
        -- toml-fmt
        function()
          return {
            exe = "toml-fmt",
            stdin = true
          }
        end
    },
    nunjucks = prettierconfig,
    njk = prettierconfig,
    javascript = prettierconfig,
    typescriptreact = prettierconfig,
    typescript = prettierconfig,
    svelte = prettierconfig,
    js = prettierconfig,
    graphql = prettierconfig,
    cjs = prettierconfig,
    html = prettierconfig,
    css = prettierconfig,
    scss = prettierconfig,
    less = prettierconfig,
    json = prettierconfig,
    graphql = prettierconfig,
    markdown = prettierconfig,
    yaml = prettierconfig,
  }
})



require("xplr").setup({
    ui = {
      border = {
        style = "single",
        highlight = "FloatBorder",
      },
      position = "30%",

      size = {
        width = "40%",
        height = "60%",
      },
    },
  previewer = {
    split = true,
    split_percent = 0.5,
    ui = {
      border = {
        style = "single",
        highlight = "FloatBorder",
      },
      position = { row = "1%", col = "99%" },
      relative = "editor", -- editor only supported for now
      size = {
        width = "30%",
        height = "99%",
      },
    },
  },
 xplr = {
    open_selection = {
      enabled = true,
      mode = "action",
      key = "o",
    },
    preview = {
      enabled = true,
      mode = "action",
      key = "i",
      fifo_path = "/tmp/nvim-xplr.fifo",
    },
    set_nvim_cwd = {
      enabled = true,
      mode = "action",
      key = "j",
    },
    set_xplr_cwd = {
      enabled = true,
      mode = "action",
      key = "h",
    },
}})

local opts = { noremap = true, silent = true }
local nvim_set_keymap = vim.api.nvim_set_keymap
local mappings = require("xplr.mappings")
local set_keymap = mappings.set_keymap
local on_previewer_set_keymap = mappings.on_previewer_set_keymap



nvim_set_keymap("n", "<space>xx", '<Cmd>lua require"xplr".open()<CR>', opts) -- open/focus cycle
set_keymap("t", "<space>xx", '<Cmd>lua require"xplr".focus()<CR>', opts) -- open/focus cycle

nvim_set_keymap("n", "<space>xc", '<Cmd>lua require"xplr".close()<CR>', opts)
set_keymap("t", "<space>xc", '<Cmd>lua require"xplr".close()<CR>', opts)

nvim_set_keymap("n", "<space>xv", '<Cmd>lua require"xplr".toggle()<CR>', opts)
set_keymap("t", "<space>xv", '<Cmd>lua require"xplr".toggle()<CR>', opts)

on_previewer_set_keymap("t", "<space>xb", '<Cmd>lua require"xplr.actions".scroll_previewer_up()<CR>', opts)
on_previewer_set_keymap("t", "<space>xn", '<Cmd>lua require"xplr.actions".scroll_previewer_down()<CR>', opts)


-- require("autosave").setup{
--   enabled = true,
--   execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
--   events = {"InsertLeave", "TextChanged"},
--   conditions = {
--     exists = true,
--     filename_is_not = {},
--     filetype_is_not = {},
--     modifiable = true
--   },
--   write_all_buffers = false,
--   on_off_commands = true,
--   clean_command_line_interval = 0,
--   debounce_delay = 135
-- }


-- require'lightspeed'.setup {
--   jump_to_first_match = true,
--   jump_on_partial_input_safety_timeout = 400,
--   exit_after_idle_msecs = { labeled = 1500, unlabeled = 1000 },
--   highlight_unique_chars = true,
--   grey_out_search_area = true,
--   match_only_the_start_of_same_char_seqs = true,
--   limit_ft_matches = 4,
--   x_mode_prefix_key = '<c-x>',
--   substitute_chars = { ['\r'] = '¬' },
--   instant_repeat_fwd_key = nil,
--   instant_repeat_bwd_key = nil,
--   -- If no values are given, these will be set at runtime,
--   -- based on `jump_to_first_match`.
--   labels = nil,
--   cycle_group_fwd_key = nil,
--   cycle_group_bwd_key = nil,
-- }

EOF

"" code folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

command Declaration :lua vim.lsp.buf.declaration()
command Definition :lua vim.lsp.buf.definition()
command Hover :lua vim.lsp.buf.hover()
command Implementation :lua vim.lsp.buf.implementation()
command SignatureHelp :lua vim.lsp.buf.signature_help()
command TypeDefinition :lua vim.lsp.buf.type_definition()
command References :lua vim.lsp.buf.references()
command DocumentSymbol :lua vim.lsp.buf.document_symbol()
command WorkspaceSymbol :lua vim.lsp.buf.workspace_symbol()
command Format :lua vim.lsp.buf.formatting_sync(nil, 1000)
command PrevDiagnostic :lua vim.lsp.diagnostic.goto_prev()
command NextDiagnostic :lua vim.lsp.diagnostic.goto_next()
command CodeAction :lua vim.lsp.buf.code_action()

"""</Language server and auto completion>"""

"""<Terminal: floatterm>"""
let g:floaterm_shell = 'zsh'
autocmd User Startified setlocal buflisted
function s:floatermSettings()
    setlocal number relativenumber
    " https://github.com/voldikss/vim-floaterm/issues/63#issuecomment-602187396
    " tnoremap <buffer> <c-t> <cmd>let g:floaterm_open_command = 'tabedit' \| call feedkeys("l", "i")<CR>
    " tnoremap <buffer> <c-o> <cmd>let g:floaterm_open_command = 'edit'    \| call feedkeys("l", "i")<CR>
    " tnoremap <buffer> <c-v> <cmd>let g:floaterm_open_command = 'vsplit'  \| call feedkeys("l", "i")<CR>
    " tnoremap <buffer> <c-s> <cmd>let g:floaterm_open_command = 'split'  \| call feedkeys("l", "i")<CR>
    " tnoremap <buffer> <esc> q
endfunction

autocmd FileType floaterm call s:floatermSettings()
let g:floaterm_height = 0.9
let g:floaterm_width = 0.9
" let g:floaterm_winblend = 20
let g:floaterm_autoinsert = v:true

"""</Terminal>"""


"""<Spellcheck: spelunker>"""
" set nospell
" Enable spelunker.vim. (default: 1)
" 1: enable
" 0: disable
" let g:enable_spelunker_vim = 1

" Enable spelunker.vim on readonly files or buffer. (default: 0)
" 1: enable
" 0: disable
" let g:enable_spelunker_vim_on_readonly = 0

" Check spelling for words longer than set characters. (default: 4)
" let g:spelunker_target_min_char_len = 4

" Max amount of word suggestions. (default: 15)
" let g:spelunker_max_suggest_words = 15

" Max amount of highlighted words in buffer. (default: 100)
" let g:spelunker_max_hi_words_each_buf = 100

" Spellcheck type: (default: 1)
" 1: File is checked for spelling mistakes when opening and saving. This
" may take a bit of time on large files.
" 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
" depends on the setting of CursorHold `set updatetime=1000`.
" let g:spelunker_check_type = 1

" Highlight type: (default: 1)
" 1: Highlight all types (SpellBad, SpellCap, SpellRare, SpellLocal).
" 2: Highlight only SpellBad.
" FYI: https://vim-jp.org/vimdoc-en/spell.html#spell-quickstart
" let g:spelunker_highlight_type = 1

" Option to disable word checking.
" Disable URI checking. (default: 0)
" let g:spelunker_disable_uri_checking = 1

" Disable email-like words checking. (default: 0)
" let g:spelunker_disable_email_checking = 1

" Disable account name checking, e.g. @foobar, foobar@. (default: 0)
" NOTE: Spell checking is also disabled for JAVA annotations.
" let g:spelunker_disable_account_name_checking = 1

" Disable acronym checking. (default: 0)
" let g:spelunker_disable_acronym_checking = 1

" Disable checking words in backtick/backquote. (default: 0)
" let g:spelunker_disable_backquoted_checking = 1

" Disable default autogroup. (default: 0)
" let g:spelunker_disable_auto_group = 1

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
" augroup spelunker
"   autocmd!
"   " Setting for g:spelunker_check_type = 1:
"   autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md call spelunker#check()

"   " Setting for g:spelunker_check_type = 2:
"   autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md call spelunker#check_displayed_words()
" augroup END

" Override highlight group name of incorrectly spelled words. (default:
" 'SpelunkerSpellBad')
" let g:spelunker_spell_bad_group = 'SpelunkerSpellBad'

" Override highlight group name of complex or compound words. (default:
" 'SpelunkerComplexOrCompoundWord')
" let g:spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'

" Override highlight setting.
" highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
" highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE
"""</Spellcheck>"""

"""<Debug: vimspector>"""
let g:vimspector_enable_mappings = 'HUMAN'
"""</Debug>"""

"""<Theme>"""
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
"""</Theme>"""
