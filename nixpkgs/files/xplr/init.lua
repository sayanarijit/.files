version = "0.14.2"

-- https://arijitbasu.in/xplr/en/plugin.html

package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'

require("icons").setup{}
require("double-colon").setup{}
require("scroll").setup{}

require("trash-cli").setup{}

-- https://github.com/sayanarijit/xplr/pull/229
require("nnn-preview-wrapper").setup{
  plugin_path = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
  fifo_path = "/tmp/xplr.fifo",
  mode = "action",
  key = "p",
}

require("material-landscape2").setup()

require("dua-cli").setup{
  mode = "action",
  key = "D",
}


require("fzf").setup{
  mode = "default",
  key = "F",
  args = "--preview 'pistol {}'"
}


xplr.config.general.enable_mouse = true
xplr.config.general.disable_recover_mode = false
xplr.config.general.show_hidden = true

xplr.config.modes.builtin.action.key_bindings.on_key["C"] = {
  help = "edit config",
  messages = {
    { BashExec = "nvim ~/.files/nixpkgs/files/xplr/init.lua" },
  }
}
