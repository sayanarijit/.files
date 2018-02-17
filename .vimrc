set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

set number relativenumbertry
    source ~/.vim_runtime/my_configs.vim
catch
endtry

set number relativenumber

hi Normal guibg=NONE ctermbg=NONE

if has('unix')
    set t_Co=256
endif

let g:multi_cursor_next_key='<C-n>'
let g:syntastic_quiet_messages={'level':'warnings'}

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" hi Normal guibg=NONE ctermbg=NONE
if has('unix')
    set t_Co=256
endif

let g:multi_cursor_next_key='<C-n>'
let g:syntastic_quiet_messages={'level':'warnings'}
