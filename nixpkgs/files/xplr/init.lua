version = "0.12.0"

package.path = os.getenv("HOME") .. '/.config/xplr/?/init.lua'

require("icons").setup{}

xplr.config.general.table.col_widths = {
    { Length = 7 },
    { Percentage = 50 },
    { Percentage = 10 },
    { Percentage = 10 },
    { Min = 1 },
}
