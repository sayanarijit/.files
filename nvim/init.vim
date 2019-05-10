syntax on
set shell=/bin/sh


"""<Plugins>"""
call plug#begin('~/.vim/plugged')
Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
Plug 'vim-airline/vim-airline'  " make statusline awesome
Plug 'wsdjeg/FlyGrep.vim'  " awesome grep on the fly
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'ncm2/ncm2-path'  " filepath completion
Plug 'kien/ctrlp.vim'  " fuzzy search files
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}  " Intellisense and auto completion
Plug 'craigemery/vim-autotag'  " Update tags
Plug 'tpope/vim-fugitive'  " Git integration
Plug 'janko-m/vim-test'  " Test runner
Plug 'benmills/vimux'  " Runs tests in new tmux window
Plug 'vim-syntastic/syntastic'  " Syntax check
Plug 'easymotion/vim-easymotion'  " Quick movement
Plug 'terryma/vim-multiple-cursors'  " Use multiple cursors
Plug 'SirVer/ultisnips'  " Snippets
Plug 'honza/vim-snippets'  " More snippets
Plug 'rhysd/git-messenger.vim'  " Display git commit information
Plug 'tpope/vim-surround'  " quoting/parenthesizing made simple
" Plug 'lifepillar/vim-solarized8'  " Light and dark theme
Plug 'joshdick/onedark.vim'  " Atom onedark theme
call plug#end()
"""</Plugins>"""


"""<Custom settings>"""
" GUI features
set mouse=a  " By default mouse is activated
set clipboard+=unnamedplus  " Use clipboard for yanking and pasting

set nu relativenumber  " No need to count lines from current position
set autoread  " Auto reload when file changes
set notagrelative  " Use full file path when generating tags

" Persistant undo history
set undofile
set undodir=/tmp/vimundo/

" code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" tags
set tags=.vscode/tags,./.vscode/tags  " Where to store tags file
let g:autotagTagsFile=".vscode/tags"  " ^^

" Generate ctags ignoring untracked files
command Ctags :exec(":!ctags -f \"$(git rev-parse --show-toplevel)/.vscode/tags\" $(git ls-files -co --exclude-standar)")
command Python :exec(":!pip install pynvim pylint") <bar> :exec(":CocInstall coc-pyls")

" Key mappings
let mapleader = ","
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>W :wall<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :qall<CR>
nnoremap <silent> <leader>t :Texplore<CR>
nnoremap <silent> <leader>T :tabnew .<CR>
nnoremap <silent> <c-up> :tp<CR>
nnoremap <silent> <c-down> :tn<CR>
nnoremap <silent> <a-left> :tabprevious<CR>
nnoremap <silent> <a-right> :tabnext<CR>
nnoremap gD :tab split<CR>:exec("tjump ".expand("<cword>"))<CR>
inoremap <a-left> <esc>vb
inoremap <a-right> <esc>ve
inoremap <c-s> <esc>:w<CR>
nnoremap <leader>m :set mouse=""<CR>
nnoremap <leader>M :set mouse=a<CR>
nnoremap O }i

" I forgot what it is
autocmd QuickFixCmdPost *grep* cwindow
"""</Custom settings>"""


"""<Testing: vim-test>"""
let test#strategy = "vimux"
"""</Testing>


"""<Searching: ctrlp.vim>"""
nnoremap <c-t> :CtrlPTag<cr>
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
"""</Searching"""

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
" nmap <leader>r <Plug>(coc-rename)
vnoremap <leader>r "hy:%s/<C-r>h//gc<left><left><left>

" Remap for format selected region
vmap <neader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
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

"""<Snippets: ultisnips>"""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"""</Snippets>"""


"""<Theme>"""
set cursorline
set cursorcolumn
" set background=light
" colorscheme solarized8
colorscheme onedark
"""</Theme>"""
