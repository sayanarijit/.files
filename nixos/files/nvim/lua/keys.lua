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
  { "n", "<cr>",         "ciw" },
  { "v", "y",            "ygv<esc>" },
  { "t", "<c-\\><c-\\>", "<c-\\><c-n>" },
  { "v", "<leader>r",    "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>" },
  { "v", "<leader>R",    "hy:bufdo %s/<C-r>h/<C-r>h/gce<left><left><left><left>" },
}

for _, key in ipairs(keys) do
  vim.keymap.set(key[1], key[2], key[3], { silent = true })
end
