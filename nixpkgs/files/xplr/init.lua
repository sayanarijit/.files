version = "0.14.0"

package.path = os.getenv("HOME") .. '/.config/xplr/?/init.lua'


require("experimental").setup{}

require("icons").setup{}
require("theme").setup{}
-- require("du").setup{}
require("fzf").setup{}
require("scroll").setup{}
require("visit_path").setup{}

-- https://github.com/sayanarijit/xplr/pull/229
require("nnn_preview_wrapper").setup{
  plugin_path = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
  fifo_path = "/tmp/xplr.fifo",
  mode = "action",
  key = "p",
}

xplr.config.general.enable_mouse = true
xplr.config.general.disable_recover_mode = false

xplr.config.modes.builtin.default.key_bindings.on_key.x = {
    messages = {
        {
            FocusPath = "/home/sayanarijit/Documents/GitHub/xplr",
        },
    },
}
