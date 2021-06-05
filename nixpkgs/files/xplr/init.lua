version = "0.13.0"

package.path = os.getenv("HOME") .. '/.config/xplr/?/init.lua'

require("icons").setup{}
require("theme").setup{}
-- require("du").setup{}
require("fzf").setup{}

xplr.config.general.enable_mouse = true
