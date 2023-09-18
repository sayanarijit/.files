local keys = {
  { "i", "<c-a>",        "<esc>I" },
  { "i", "<c-e>",        "<esc>A" },
  { "i", "<a-left>",     "<c-left>" },
  { "i", "<a-right>",    "<c-right>" },
  { "n", "<a-left>",     ":tabprevious<cr>" },
  { "n", "<a-right>",    ":tabnext<cr>" },
  { "n", "<a-s-right>",  ":tabm +1<cr>" },
  { "n", "<a-s-left>",   ":tabm -1<cr>" },
  { "n", "Y",            '"+y' },
  { "v", "Y",            '"+y' },
  { "n", "P",            '"+P' },
  { "v", "P",            '"+P' },
  { "v", "y",            "ygv<esc>" },
  { "t", "<c-\\><c-\\>", "<c-\\><c-n>" },
  { "v", "<leader>r",    'y:%s/<C-r>"/<C-r>"/gc<left><left><left><C-l>' },
  {
    "v",
    "<leader>R",
    'y:bufdo %s/<C-r>"/<C-r>"/gce<left><left><left><left><C-l>',
  },
}

for _, key in ipairs(keys) do
  vim.keymap.set(key[1], key[2], key[3], { silent = true })
end
