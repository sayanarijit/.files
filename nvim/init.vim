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
Plug 'wellle/context.vim'  " Context of current buffer
Plug 'SidOfc/mkdx'  " Some goodies for documentation
Plug 'LnL7/vim-nix'  " Nix support
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
Plug 'junegunn/fzf.vim'  " Fuzzy finder vim support
Plug 'terryma/vim-expand-region'  " visually select increasingly larger regions of text
Plug 'mcchrish/nnn.vim'  " The missing terminal file manager for X
Plug 'SirVer/ultisnips'  " The ultimate snippet solution for Vim
Plug 'honza/vim-snippets' " Snippets are separated from the engine
" Plug 'lotabout/skim.vim'
" Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
" Plug 'scrooloose/nerdtree'  " Tree view for vim
" Plug 'lifepillar/vim-solarized8'  " Light and dark theme
" Plug 'joshdick/onedark.vim'  " Atom onedark theme
" Plug 'rakr/vim-one'  " Adaptation of one-light and one-dark colorschemes for Vim
Plug 'KeitaNakamura/neodark.vim'  " A dark color scheme for vim
" Plug 'morhetz/gruvbox' " Retro groove color scheme for Vim
call plug#end()
"""</Plugins>"""


"""<Custom settings>"""
" Basic config
set nu relativenumber  " No need to count lines from current position
set autoread  " Auto reload when file changes
set notagrelative  " Use full file path when generating tags
set showtabline=2  " Show tabname even if only one file is open
set scrolloff=5  " Keep some space while scrolling vertically

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
set tags=.vscode/tags  " Where to store tags file
let g:autotagTagsFile=".vscode/tags"  " ^^
let g:fzf_tags_command = 'ctags -R -f .vscode/tags --exclude=.vscode/*'

" Key mappings
let mapleader = ","
nnoremap <silent> <c-a> ^
nnoremap <silent> <c-e> $
inoremap <silent> <c-a> <ESC>I
inoremap <silent> <c-e> <ESC>A
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>W :wall<CR>
nnoremap <silent> <leader>q gg:q<CR>
nnoremap <silent> <leader>Q :qall<CR>
nnoremap <silent> <leader>t :NnnPicker '%:p:h'<CR>
nnoremap <silent> <leader>T :NnnPicker<CR>
nnoremap <silent> <c-up> :tp<CR>
nnoremap <silent> <c-down> :tn<CR>
nnoremap <silent> <s-up> {
nnoremap <silent> <s-down> }
inoremap <silent> <s-up> <ESC>{i
inoremap <silent> <s-down> <ESC>}i
nnoremap <silent> <c-s-up> <c-u>
nnoremap <silent> <c-s-down> <c-d>
nnoremap <silent> <a-left> :tabprevious<CR>
nnoremap <silent> <a-right> :tabnext<CR>
nnoremap gD :tab split<CR>:exec("tjump ".expand("<cword>"))<CR>
inoremap <a-left> <esc>vb
inoremap <a-right> <esc>ve
inoremap <c-s> <esc>:w<CR>
inoremap <a-s-left> <esc>vb
inoremap <a-s-right> <esc><right>ve
nnoremap <a-s-left> vb
nnoremap <a-s-right> ve
nnoremap <leader>m :set mouse=""<CR>
nnoremap <leader>M :set mouse=a<CR>
nnoremap <leader>s :set spell<CR>
nnoremap <leader>S :set nospell<CR>
nnoremap O }i

" Python development
command Python :exec(":!pip install pynvim pylint mypy autopep8 black")

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
let test#strategy = "basic"
let test#python#runner = 'pytest'
"""</Testing>


"""<Searching: fzf>"""
nnoremap <c-t> :Tags<cr>
nnoremap <c-p> :GFiles<cr>
nnoremap <c-f> :Files<cr>
nnoremap <c-l> :Lines<cr>
nnoremap <c-g> :Rg<cr>
"""</Searching>"""

"""<Auto completion: coc.nvim>"""

" let g:coc_force_debug = 1

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

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

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

" Remap for format selected region
xmap <neader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"""</Auto completion>"""


"""<Tagbar: tagbar>"""
nnoremap <silent> \\ :TagbarToggle<CR>
autocmd BufNewFile,BufRead * :call tagbar#autoopen()
"""</Tagbar>"""


"""</Syntax check: syntastic>"""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes':   [],'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"""</Syntax check>"""


"""<Tree view: nerdtree>"""
" nnoremap <silent> // :NERDTreeToggle<CR>
"""</Tree view>"""

"""<Rust Development>"""
autocmd BufWritePost *.rs :RustFmt
"""</Rust Development>"""


"""<Quick movements: easymotion>"""
let g:EasyMotion_keys='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~!@#$%^&*()_+[]{}|;:",./<>?'
let g:EasyMotion_smartcase = 1
map f <Plug>(easymotion-prefix)w
nmap f <Plug>(easymotion-prefix)w
map F <Plug>(easymotion-prefix)b
nmap F <Plug>(easymotion-prefix)b
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


"""<Git commit message: git-messanger>"""
nmap <Leader>gm <Plug>(git-messenger)
"""</Git commit message>"""


"""<Documentation: mkdx>"""
let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }
let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
                                       " plugin which unfortunately interferes with mkdx list indentation.
"""</Documentation>"""


"""<Expand Region: vim-expand-region>"""
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'V'  :1,
      \ 'is'  :1,
      \ 'ip'  :1,
      \ 'it'  :1,
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
"""</File Manager>"""

"""<Snippets: Ultisnips>"""
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"""</Snippets>"""

"""<Theme>"""
set cursorline
set cursorcolumn
set background=dark
colorscheme neodark
let g:airline_theme='neodark'
"""</Theme>"""
