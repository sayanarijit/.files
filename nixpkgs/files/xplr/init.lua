version = "0.14.0"

-- https://arijitbasu.in/xplr/en/plugin.html

package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'

require("completion").setup()

require("icons").setup{}
require("double-colon").setup{}
require("scroll").setup{}

require("trash-cli").setup()
require("zoxide").setup()
require("dragon").setup()
require("xclip").setup()
require("qrcp").setup()
require("type-to-nav").setup()
require("xargs").setup{
  key = "x",
}
require("paste-rs").setup{
  db_path = "$HOME/paste.rs.list"
}


-- https://github.com/sayanarijit/xplr/pull/229
-- require("nnn-preview-wrapper").setup{
--   plugin_path = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
--   fifo_path = "/tmp/xplr.fifo",
--   mode = "action",
--   key = "p",
-- }

require("preview-tabbed").setup()


require("material-landscape2").setup{
  keep_default_layout = true
}

require("dua-cli").setup()
require("comex").setup{
  compressors = {
    Z = { extension = "zip", command = [[zip -d xplr_$(cat "${XPLR_PIPE_SELECTION_OUT:?}")]] },
  },
  extractors = {
    Z = { extension = "zip", command = [[unzip -d "${XPLR_FOCUS_PATH:?}.d" "${XPLR_FOCUS_PATH:?}"]] },
  },
}


require("fzf").setup{
  args = "--preview 'pistol {}'"
}


local xplr = xplr

xplr.config.general.enable_mouse = true
xplr.config.general.disable_recover_mode = false
xplr.config.general.show_hidden = true

xplr.config.modes.builtin.action.key_bindings.on_key["C"] = {
  help = "edit config",
  messages = {
    { BashExec = "${EDITOR:-vi} ~/.files/nixpkgs/files/xplr/init.lua" },
  }
}


xplr.config.modes.builtin.go_to.key_bindings.on_key.p = {
  help = "go to path",
  messages = {
    "PopMode",
    { SwitchModeCustom = "go_to_path" },
    { SetInputBuffer = "" },
  }
}

xplr.config.modes.custom.go_to_path = {
  name = "go to path",
  key_bindings = {
    on_key = {
      enter = {
        messages = {
          "FocusPathFromInput",
          "PopMode",
        },
      },
      esc = {
        help = "cancel",
        messages = { "PopMode" },
      },
      tab = {
        help = "complete",
        messages = {
          { CallLuaSilently = "custom.completion.complete_path" },
        },
      },
      ["ctrl-c"] = {
        help = "terminate",
        messages = { "Terminate" },
      },
      backspace = {
        help = "remove last character",
        messages = { "RemoveInputBufferLastCharacter" },
      },
      ["ctrl-u"] = {
        help = "remove line",
        messages = { { SetInputBuffer = "" } },
      },
      ["ctrl-w"] = {
        help = "remove last word",
        messages = { "RemoveInputBufferLastWord" },
      },
    },
    default = {
      messages = {
        "BufferInputFromKey"
      },
    },
  },
}


xplr.fn.custom.fmt_index = function(m)
  if m.is_focused then
    return m.prefix .. m.index
  elseif m.is_before_focus then
    return "-" .. m.relative_index
  else
    return "+" .. m.relative_index
  end
end

xplr.fn.custom.fmt_simple_column = function(m)
  return m.meta.icon .. " " .. m.relative_path .. m.suffix
end

xplr.config.general.table.header.cols = {
  { format = "" },
  { format = "  path" },
}

xplr.config.general.table.row.cols = {
  { format = "custom.fmt_index" },
  { format = "custom.fmt_simple_column" },
}

xplr.config.general.table.col_widths = {
  { Length = 7 },
  { Percentage = 100 },
}

-- With this config, you should only see a single column displaying the
-- relative paths.
