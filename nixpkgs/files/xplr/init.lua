version = "0.13.0"

package.path = os.getenv("HOME") .. '/.config/xplr/?/init.lua'

require("icons").setup{}
require("theme").setup{}
-- require("du").setup{}
require("fzf").setup{}

-- https://github.com/sayanarijit/xplr/pull/229
require("nnn_preview_wrapper").setup{
  plugin_path = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
  fifo_path = "/tmp/xplr.fifo",
}

xplr.config.general.enable_mouse = true
