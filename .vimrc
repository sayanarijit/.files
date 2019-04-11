set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry
set number relativenumber

" hi Normal guibg=NONE ctermbg=NONE

" if has('unix')
"     set t_Co=256
" endif

let g:multi_cursor_next_key='<C-n>'
" let g:syntastic_quiet_messages={'level':'warnings'}

" let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" nmap s <Plug>(easymotion-overwin-f)
" nmap s <Plug>(easymotion-overwin-f2)

" map  <Leader>a <Plug>(easymotion-bd-w)
" nmap <Leader>a <Plug>(easymotion-overwin-w)

" Turn on case insensitive feature
" let g:EasyMotion_smartcase = 1

" JK motions: Line motions
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)

let g:qs_first_occurrence_highlight_color = 155
let g:qs_second_occurrence_highlight_color = 81

" Fuzzy finder
let g:ctrlp_map = '<c-p>'
let g:elm_setup_keybindings = 0
