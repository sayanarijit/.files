version = "0.12.0"

package.path = os.getenv("HOME") .. '/.config/xplr/?/init.lua'

require("icons").setup{}

xplr.config.general.prompt.format = ">> "
