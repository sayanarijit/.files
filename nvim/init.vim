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
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'craigemery/vim-autotag'
Plug 'tpope/vim-fugitive'
Plug 'janko-m/vim-test'
Plug 'benmills/vimux'
Plug 'vim-syntastic/syntastic'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'
call plug#end()
"""</Plugins>"""


"""<Custom settings>"""
" GUI features
set mouse=a
set clipboard+=unnamedplus

set nu relativenumber
set autoread
set notagrelative

" tags
set tags=.vscode/tags,./.vscode/tags
let g:autotagTagsFile=".vscode/tags"
map gD :tab split<CR>:exec("tjump ".expand("<cword>"))<CR>
command Ctags :exec(":!ctags -f \"$(git rev-parse --show-toplevel)/.vscode/tags\" $(git ls-files -co --exclude-standar)")

" history
set undofile
set undodir=/tmp/vimundo/

" mappings
let mapleader = ","
nnoremap <leader>w :w<CR>
nnoremap <c-up> :tp<CR>
nnoremap <c-down> :tn<CR>
autocmd QuickFixCmdPost *grep* cwindow
inoremap <a-left> <esc>vb
inoremap <a-right> <esc>ve
inoremap <c-s> <esc>:w<CR>
map <leader>m :set mouse=""<CR>
map <leader>M :set mouse=a<CR>

" code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
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
map \\ :TagbarToggle<CR>
autocmd BufNewFile,BufRead * :call tagbar#autoopen()
"""</Tagbar>"""


"""</Syntax check: syntastic>"""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
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
