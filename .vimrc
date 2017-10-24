set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

set nu

" hi Normal guibg=NONE ctermbg=NONE
if has('unix')
    set t_Co=256
endif

let g:multi_cursor_next_key='<C-n>'
