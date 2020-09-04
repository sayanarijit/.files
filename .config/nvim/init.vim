syntax on
set shell=/bin/sh
set rtp +=~/.vim


"""<Plugins>"""
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lsp'  "  Nvim LSP client configurations
Plug 'nvim-lua/completion-nvim'  "  A async completion framework aims to provide completion to neovim's built in LSP written in Lua
Plug 'nvim-lua/diagnostic-nvim'  "  A wrapper for neovim built in LSP diagnosis config 
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  " Dark powered asynchronous completion framework for neovim/Vim8 
" Plug 'Shougo/deoplete-lsp'  "  LSP Completion source for deoplete 
" Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
Plug 'liuchengxu/vista.vim'  "  Viewer & Finder for LSP symbols and tags 
Plug 'vim-airline/vim-airline'  " make statusline awesome
" Plug 'hardcoreplayers/spaceline.vim'  " vim statusline like spacemacs
Plug 'wsdjeg/FlyGrep.vim'  " awesome grep on the fly
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'ncm2/ncm2-path'  " filepath completion
" Plug 'kien/ctrlp.vim'  " fuzzy search files
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}  " Intellisense and auto completion
Plug 'craigemery/vim-autotag'  " Update tags
Plug 'tpope/vim-fugitive'  " Git integration
Plug 'janko-m/vim-test'  " Test runner
" Plug 'benmills/vimux'  " Runs tests in new tmux window
Plug 'easymotion/vim-easymotion'  " Quick movement
Plug 'tpope/vim-surround'  " quoting/parenthesizing made simple
" Plug 'fatih/vim-go'  " Go development
" Plug 'rust-lang/rust.vim'  " Rust development
Plug 'rhysd/git-messenger.vim'  " Git commit message viewer
" Plug 'wellle/context.vim'  " Context of current buffer
Plug 'LnL7/vim-nix'  " Nix support
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
Plug 'junegunn/fzf.vim'  " Fuzzy finder vim support
Plug 'terryma/vim-expand-region'  " visually select increasingly larger regions of text
Plug 'mcchrish/nnn.vim'  " The missing terminal file manager for X
Plug 'SirVer/ultisnips'  " The ultimate snippet solution for Vim
Plug 'honza/vim-snippets'  " Snippets are separated from the engine
Plug 'liuchengxu/vim-which-key',  " Vim plugin that shows keybindings in popup
Plug 'mhinz/vim-startify'  " The fancy start screen for Vim.
Plug 'unblevable/quick-scope'  " Lightning fast left-right movement in Vim
Plug 'vim-scripts/haproxy'  " syntax for haproxy
" Plug 'jeetsukumaran/vim-pythonsense'  " Motions for Python classes, methods, functions, and doc strings.
Plug 'andys8/vim-elm-syntax', { 'for': ['elm'] }  " Syntax highlighting for elm
Plug 'Einenlum/yaml-revealer'  " A vim plugin to handle Yaml files
Plug 'jeetsukumaran/vim-indentwise'  " A Vim plugin for indent-level based motion.
Plug 'AndrewRadev/splitjoin.vim'  " Switch between single-line and multiline forms of code
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " Semantic Highlighting for Python in Neovim
Plug 'junegunn/vim-peekaboo'  " / @ / CTRL-R 
Plug 'ap/vim-css-color'  "  Preview colours in source code while editing
" Plug 'scrooloose/nerdtree'  " Tree view for vim
" Plug 'lifepillar/vim-solarized8'  " Light and dark theme
" Plug 'joshdick/onedark.vim'  " Atom onedark theme
" Plug 'rakr/vim-one'  " Adaptation of one-light and one-dark colorschemes for Vim
Plug 'KeitaNakamura/neodark.vim'  " A dark color scheme for vim
" Plug 'morhetz/gruvbox'  " Retro groove color scheme for Vim
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
set expandtab  " Convert tabs to spaces (I don't write golang anymore)
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Remap for rename current word
vnoremap <leader>r "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>

" GUI features
set mouse=a  " By default mouse is activated
" set clipboard+=unnamedplus  " Use clipboard for yanking and pasting

" Persistant undo history
set undofile
set undodir=/tmp/vimundo/

" code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" NeoVim configuration
command Config :tabnew ~/.config/nvim/init.vim

" tags
set tags=.vim/tags  " Where to store tags file
let g:autotagTagsFile=".vim/tags"  " ^^
let g:fzf_tags_command = 'ctags -R -f .vim/tags --exclude=.vim/*'

" Key mappings
inoremap <silent> <c-a> <ESC>I
inoremap <silent> <c-e> <ESC>A
nnoremap <silent> <a-left> :tabprevious<CR>
nnoremap <silent> <a-right> :tabnext<CR>
nnoremap <silent> <a-s-right> :tabm +1<CR>
nnoremap <silent> <a-s-left> :tabm -1<CR>

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

" Markdown
autocmd FileType md setlocal ts=2 sts=2 sw=2 expandtab

" JavaScript development
autocmd FileType js setlocal ts=4 sts=4 sw=4 expandtab

" YAML development
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

" I forgot what it is
autocmd QuickFixCmdPost *grep* cwindow

" Elm
autocmd FileType md setlocal ts=2 sts=2 sw=2 expandtab

" HTML and HTML templates
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType pt setlocal ts=2 sts=2 sw=2 expandtab
"""</Custom settings>"""

"""<Testing: vim-test>"""
let test#strategy = "neovim"
let test#python#runner = 'pytest'
"""</Testing>

"""<elm-vim>"""
let g:elm_setup_keybindings = 0
"""</elm-vim>"""

"""<Tagbar: tagbar>"""
" nnoremap <silent> \\ :TagbarToggle<CR>
" let g:tagbar_type_elm = {
"           \   'ctagstype':'elm'
"           \ , 'kinds':['h:header', 'i:import', 't:type', 'f:function', 'e:exposing']
"           \ , 'sro':'&&&'
"           \ , 'kind2scope':{ 'h':'header', 'i':'import'}
"           \ , 'sort':0
"           \ , 'ctagsbin':'~/.bin/elmtags.py'
"           \ , 'ctagsargs': ''
"           \ }
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
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" Update the vista on |TextChanged| and |TextChangedI|.
let g:vista_update_on_text_changed = 1

nnoremap <silent> \\ :Vista!!<CR>
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
	\ {'f': ['Search Files', ':Files']},
	\ {'F': ['Search GitHub Files', ':GFiles']},
	\ {'T': ['Open Terminal', ':terminal $SHELL']},
	\ ]
"""</Start page>"""

"""<Quick movements: easymotion>"""
let g:EasyMotion_keys='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~!@#$%^&*()_+[]{}|;:",./<>?'
let g:EasyMotion_smartcase = 1
"""</Quick movements>"""


"""<Expand Region: vim-expand-region>"""
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'V'  :1,
      \ 'it'  :1,
      \ 'if'  :1,
      \ 'ic'  :1,
      \ 'ip'  :1,
      \ 'i"'  :1,
      \ 'i''' :1,
      \ 'i]'  :1,
      \ 'i)'  :1,
      \ 'i}'  :1,
      \ 'i>'  :1,
      \ 'i`'  :1,
      \ }
"""</Expand Region>"""

"""<Fuzzy search: fzf>"""
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
"""</FUzzy search>"""

"""<File Manager: nnn>"""
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Debug' } }
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }
let g:nnn#command = 'nnn -d'
command NnnProjectRoot :NnnPicker `git rev-parse --show-toplevel`
"""</File Manager>"""

"""<Snippets: Ultisnips>"""
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"""</Snippets>"""

"""<Keybindings Helper: WhichKey>"""
  
" Map leader to which_key
nnoremap <silent> <space> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <space> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}

" a is for actions (custom)
let g:which_key_map.a = {
	\ 'name' : '+actions',
	\ }

let g:which_key_map.a.o = {
	\ 'name' : '+open',
	\ 't' : [':tabnew', 'tab'],
	\ 'G' : [':GitModified', 'git modified files'],
	\ }

let g:which_key_map.a.t = {
	\ 'name' : '+terminal',
	\ 't' : [':TerminalTab', 'new tab'],
	\ 'h' : [':TerminalHSplit', 'horizontal split'],
	\ 'v' : [':TerminalVSplit', 'vertical split'],
	\ }

let g:which_key_map.a.w = {
	\ 'name' : '+write',
	\ 'w' : [':w', 'current file'],
	\ 'W' : [':w!', 'current file forced'],
	\ 'a' : [':wall', 'all files'],
	\ 'A' : [':wall!', 'all files forced'],
	\ }

let g:which_key_map.a.q = {
	\ 'name' : '+quit',
	\ 'q' : [':q', 'current file'],
	\ 'Q' : [':q!', 'current file forced'],
	\ 'a' : [':qall', 'all files'],
	\ 'A' : [':qall!', 'all files forced'],
	\ }

let g:which_key_map.a.x = {
	\ 'name' : '+write & quit',
	\ 'x' : [':wq', 'current file'],
	\ 'X' : [':wq!', 'current file forced'],
	\ 'a' : [':wqall', 'all files'],
	\ 'A' : [':wqall!', 'all files forced'],
	\ }

let g:which_key_map.a.s = {
	\ 'name' : '+splitjoin',
	\ 's' : ['gS', 'split line'],
	\ 'j' : ['gJ', 'join lines'],
	\ }

" f for find word
let g:which_key_map.f = {
	\ 'name' : '+find',
	\ '1' : ['<Plug>(easymotion-overwin-f)', 'find by 1 char'],
	\ '2' : ['<Plug>(easymotion-overwin-f2)', 'find by 2 chars'],
	\ }


" w for window
let g:which_key_map.w = {
	\ 'name' : '+window',
	\ 'f' : ['Windows', 'find'],
	\ }

let g:which_key_map.w.s = {
	\ 'name' : '+split',
	\ 'h' : ['<C-W>s', 'split horizontally'],
	\ 'v' : ['<C-W>v', 'split vertically']
	\ }

let g:which_key_map.w.m = {
	\ 'name' : '+manage',
	\ 'h' : ['<c-w>_', 'max height'],
	\ 'w' : ['<c-w>|', 'max width'],
	\ 'o' : ['<c-w>o', 'close others'],
	\ 't' : ['<c-w>T', 'move to new tab'],
	\ 'r' : ['<c-w>=', 'reset'],
	\ }

let g:which_key_map.w.g = {
	\ 'name' : '+goto',
	\ 'h' : ['<c-w>h', 'left'],
	\ 'j' : ['<c-w>j', 'down'],
	\ 'k' : ['<c-w>k', 'up'],
	\ 'l' : ['<c-w>l', 'right'],
	\ }

" c for config
let g:which_key_map.c = {
	\ 'name' : '+config' ,
	\ 'c' : [':Config', 'neovim config'],
	\ }

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files .'      , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'v' : [':Vista finder! ctags' , 'symbols'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add %'                        , 'add current'],
      \ 'A' : [':Git add .'                        , 'add all'],
      \ 'b' : [':Git blame'                        , 'blame'],
      \ 'B' : [':GBrowse'                          , 'browse'],
      \ 'c' : [':Git commit'                       , 'commit'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      \ 'G' : [':GitModified'                      , 'edit modified'],
      \ 's' : [':Gstatus'                          , 'status'],
      \ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks'],
      \ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk'],
      \ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk'],
      \ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk'],
      \ 'm' : ['<Plug>(git-messenger)'             , 'show commit message'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'p' : [':Git push'                         , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'r' : [':GRemove'                          , 'remove'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk'],
      \ }

" l is for language server protocol
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ 'd' : [':Definition'                         , 'definition'],
      \ 'D' : [':Declaration'                        , 'declaration'],
      \ 'F' : [':Format'                             , 'format'],
      \ 'h' : [':Hover'                              , 'hover'],
      \ 'i' : [':Implementation'                     , 'implementation'],
      \ 'l' : [':NextDiagnostic'                     , 'next diagnostic'],
      \ 'L' : [':PrevDiagnostic'                     , 'prev diagnostic'],
      \ 'I' : [':OpenDiagnostic'                     , 'diagnostics'],
      \ 'r' : [':References'                         , 'references'],
      \ 's' : [':DocumentSymbol'                     , 'document symbols'],
      \ 'S' : [':WorkspaceSymbol'                    , 'workspace symbols'],
      \ 't' : [':TypeDefinition'                     , 'type definition'],
      \ }

" t is for test
let g:which_key_map.t = {
	\ 'name' : '+test',
	\ }

let g:which_key_map.t.t = {
	\ 'name' : '+nearest',
	\ 't' : [':TestNearest', 'test normally'],
	\ 'p' : [':TestNearest --pdb', 'test with pdb'],
	\ }

let g:which_key_map.t.f = {
	\ 'name' : '+file',
	\ 't' : [':TestFile', 'test normally'],
	\ 'p' : [':TestFile --pdb', 'test with pdb'],
	\ }

" v for vista
let g:which_key_map.v = {
	\ 'name' : '+vista',
	\ 'v' : [':Vista!!', 'toggle window'],
	\ 'f' : [':Vista finder', 'find symbol'],
	\ 'F' : [':Vista finder! ctags', 'find symbol recursive'],
	\ }

" x for explore
let g:which_key_map.x = {
	\ 'name' : '+explore',
	\ 'p' : [':NnnPicker %:p:h', 'present directory'],
	\ 'w' : [':NnnPicker', 'working directory'],
	\ 'g' : [':NnnProjectRoot', 'git project root'],
	\ 'h' : [':NnnPicker ~', 'home directory'],
	\ '/' : [':NnnPicker /', 'fs root'],
	\ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
"""</Keybindings Helper>"""

"""<Language server and auto completion>"""
set completeopt=menuone,noinsert
let g:python3_host_prog = '/run/current-system/sw/bin/python3'

"" diagnostic-nvim
let g:diagnostic_enable_virtual_text = 0

"" completion-nvim
let g:completion_enable_snippet = 'UltiSnips'
autocmd BufEnter * lua require'completion'.on_attach()

"" deoplete-lsp
" let g:deoplete#enable_at_startup = 1

"" language servers are installed with nix-darwin
:lua << EOF
require'nvim_lsp'.pyls.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.html.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.elmls.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.dockerls.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.cssls.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.diagnosticls.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.bashls.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.rust_analyzer.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.yamlls.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.jsonls.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.vimls.setup{on_attach=require'diagnostic'.on_attach}
EOF

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

nnoremap <silent> K     <cmd>Hover<CR>
"""</Language server and auto completion>"""

"""<Theme>"""
set cursorline
set cursorcolumn
set background=dark
colorscheme neodark
let g:airline_theme='neodark'
"""</Theme>"""
