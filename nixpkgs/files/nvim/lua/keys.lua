local cmd = vim.cmd

cmd([[
  inoremap <silent> <c-a> <ESC>I
  inoremap <silent> <c-e> <ESC>A
  inoremap <silent> <a-left> <c-left>
  inoremap <silent> <a-right> <c-right>
  nnoremap <silent> <a-left> :tabprevious<CR>
  nnoremap <silent> <a-right> :tabnext<CR>
  nnoremap <silent> <a-s-right> :tabm +1<CR>
  nnoremap <silent> <a-s-left> :tabm -1<CR>

  nnoremap <silent> Y "+y
  vnoremap <silent> Y "+y
  nnoremap <silent> P "+P
  vnoremap <silent> P "+P

  tnoremap <c-\><c-\> <c-\><c-n>
]])
