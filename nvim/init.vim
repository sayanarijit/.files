syntax on
set shell=/bin/sh
set rtp +=~/.vim


"""<Plugins>"""
call plug#begin('~/.vim/plugged')
Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
Plug 'vim-airline/vim-airline'  " make statusline awesome
Plug 'wsdjeg/FlyGrep.vim'  " awesome grep on the fly
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'ncm2/ncm2-path'  " filepath completion
" Plug 'kien/ctrlp.vim'  " fuzzy search files
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}  " Intellisense and auto completion
Plug 'craigemery/vim-autotag'  " Update tags
Plug 'tpope/vim-fugitive'  " Git integration
Plug 'janko-m/vim-test'  " Test runner
" Plug 'benmills/vimux'  " Runs tests in new tmux window
Plug 'easymotion/vim-easymotion'  " Quick movement
Plug 'terryma/vim-multiple-cursors'  " Use multiple cursors
Plug 'tpope/vim-surround'  " quoting/parenthesizing made simple
Plug 'fatih/vim-go'  " Go development
Plug 'rust-lang/rust.vim'  " Rust development
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
Plug 'jeetsukumaran/vim-pythonsense'  " Motions for Python classes, methods, functions, and doc strings.
" Plug 'lotabout/skim.vim'
" Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
" Plug 'scrooloose/nerdtree'  " Tree view for vim
" Plug 'lifepillar/vim-solarized8'  " Light and dark theme
" Plug 'joshdick/onedark.vim'  " Atom onedark theme
" Plug 'rakr/vim-one'  " Adaptation of one-light and one-dark colorschemes for Vim
Plug 'KeitaNakamura/neodark.vim'  " A dark color scheme for vim
" Plug 'morhetz/gruvbox'  " Retro groove color scheme for Vim
call plug#end()
"""</Plugins>"""


"""<Custom settings>"""
" Basic config
set noautochdir  " Don't change directory when opening a file
set nu relativenumber  " No need to count lines from current position
set autoread  " Auto reload when file changes
set notagrelative  " Use full file path when generating tags
set showtabline=2  " Show tabname even if only one file is open
set scrolloff=5  " Keep some space while scrolling vertically
set splitbelow  " Opens new hsplits below the current window
set splitright  " Opens new vsplits right side of the current window

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
command Config :tabnew ~/.files/nvim/init.vim

" tags
set tags=.vim/tags  " Where to store tags file
let g:autotagTagsFile=".vim/tags"  " ^^
let g:fzf_tags_command = 'ctags -R -f .vim/tags --exclude=.vim/*'

" Key mappings
let mapleader = ","
inoremap <silent> <c-a> <ESC>I
inoremap <silent> <c-e> <ESC>A
nnoremap <silent> <a-left> :tabprevious<CR>
nnoremap <silent> <a-right> :tabnext<CR>

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

" Python development
command SetupPythonProject :exec(":!pip install pynvim pylint mypy autopep8 black")

" JavaScript development
autocmd FileType js setlocal ts=4 sts=4 sw=4 expandtab

" YAML development
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

" I forgot what it is
autocmd QuickFixCmdPost *grep* cwindow

" HTML and HTML templates
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType pt setlocal ts=2 sts=2 sw=2 expandtab
"""</Custom settings>"""

"""<Testing: vim-test>"""
let test#strategy = "neovim"
let test#python#runner = 'pytest'
"""</Testing>

"""<Auto completion: coc.nvim>"""

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
vnoremap <leader>r "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>
""""</Auto completion>"""


"""<Tagbar: tagbar>"""
nnoremap <silent> \\ :TagbarToggle<CR>
" autocmd BufNewFile,BufRead * :call tagbar#autoopen()
"""</Tagbar>"""

"""<Tree view: nerdtree>"""
" nnoremap <silent> // :NERDTreeToggle<CR>
"""</Tree view>"""

"""<Rust Development>"""
" autocmd BufWritePost *.rs :RustFmt
"""</Rust Development>"""

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

"""<Auto completion: coc>"""
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

set statusline+=%{StatusDiagnostic()}
"""</Auto completion>"""


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

let g:which_key_map.a.p = {
	\ 'name' : '+project',
	\ 'G' : [':GitModified', 'git modified files'],
	\ }

let g:which_key_map.a.p.s = {
	\ 'name' : '+setup',
	\ 'p' : [':SetupPythonProject', 'python'],
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
	\ 'o' : [':CocConfig', 'coc config'],
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
      \ 'f' : [':Files .'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
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
      \ '.' : [':CocConfig'                          , 'config'],
      \ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
      \ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
      \ 'b' : [':CocNext'                            , 'next action'],
      \ 'B' : [':CocPrev'                            , 'prev action'],
      \ 'c' : [':CocList commands'                   , 'commands'],
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
      \ 'e' : [':CocList extensions'                 , 'extensions'],
      \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
      \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
      \ 'h' : ['K'                                   , 'help'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
      \ 'm' : [':CocList marketplace'                , 'marketplace'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
      \ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],
      \ 'O' : [':CocList outline'                    , 'outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'r' : ['<Plug>(coc-references)'              , 'references'],
      \ 's' : [':CocList -I symbols'                 , 'symbols'],
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'u' : [':CocListResume'                      , 'resume list'],
      \ 'U' : [':CocUpdate'                          , 'update CoC'],
      \ 'z' : [':CocDisable'                         , 'disable CoC'],
      \ 'Z' : [':CocEnable'                          , 'enable CoC'],
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

"""<Theme>"""
set cursorline
set cursorcolumn
set background=dark
colorscheme neodark
let g:airline_theme='neodark'
"""</Theme>"""
