version = "0.15.0"

-- https://xplr.dev/en/plugin.html

package.path = os.getenv("HOME") .. "/.config/xplr/plugins/?/src/init.lua"

require("completion").setup()
require("double-colon").setup({})
require("scroll").setup({})

require("nvim-ctrl").setup()
require("command-mode").setup()
require("icons").setup()
require("dynamic-table").setup()
require("trash-cli").setup()
require("zoxide").setup()
require("dragon").setup()
require("xclip").setup()
require("qrcp").setup()
require("alacritty").setup()
require("type-to-nav").setup()
require("xargs").setup({ key = "x" })

require("map").setup({ key = "M" })
require("paste-rs").setup({
  db_path = "$HOME/paste.rs.list",
})

-- https://github.com/sayanarijit/xplr/pull/229
-- require("nnn-preview-wrapper").setup{
--   plugin_path = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
--   fifo_path = "/tmp/xplr.fifo",
--   mode = "action",
--   key = "p",
-- }

require("preview-tabbed").setup()

require("material-landscape2").setup({
  keep_default_layout = true,
})

require("dua-cli").setup()
require("comex").setup({
  compressors = {
    Z = {
      extension = "zip",
      command = [[zip -d xplr_$(cat "${XPLR_PIPE_SELECTION_OUT:?}")]],
    },
  },
  extractors = {
    Z = {
      extension = "zip",
      command = [[unzip -d "${XPLR_FOCUS_PATH:?}.d" "${XPLR_FOCUS_PATH:?}"]],
    },
  },
})

require("fzf").setup({
  args = "--preview 'pistol {}'",
})

local xplr = xplr

xplr.config.general.enable_mouse = true
xplr.config.general.show_hidden = true

xplr.config.general.enable_recover_mode = true

xplr.config.modes.builtin.action.key_bindings.on_key["C"] = {
  help = "edit config",
  messages = {
    { BashExec = "${EDITOR:-vi} ~/.files/nixpkgs/files/xplr/init.lua" },
  },
}

xplr.config.modes.builtin.go_to.key_bindings.on_key.p = {
  help = "go to path",
  messages = {
    "PopMode",
    { SwitchModeCustom = "go_to_path" },
    { SetInputBuffer = "" },
  },
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
        "BufferInputFromKey",
      },
    },
  },
}

local cmd = xplr.fn.custom.command_mode.cmd
local silent_cmd = xplr.fn.custom.command_mode.silent_cmd
local map = xplr.fn.custom.command_mode.map

-- Type `:hello-lua` and press enter to know your location
cmd("hello-lua", "Enter name and know location")(function(app)
  print("What's your name?")

  local name = io.read()
  local greeting = "Hello " .. name .. "!"
  local message = greeting .. " You are inside " .. app.pwd

  return {
    { LogSuccess = message },
  }
end)

-- Type `:hello-bash` and press enter to know your location
silent_cmd("hello-bash", "Enter name and know location")(function(_)
  return {
    {
      BashExec = [===[
        echo "What's your name?"

        read name
        greeting="Hello $name!"
        message="$greeting You are inside $PWD"
      
        echo LogSuccess: '"'$message'"' >> "${XPLR_PIPE_MSG_IN:?}"
      ]===],
    },
  }
end)

-- map `h` to hello-lua
map("default", "h", "hello-lua")

-- map `H` to hello-bash
map("default", "H", "hello-bash")

-- require("icons-view").setup()
