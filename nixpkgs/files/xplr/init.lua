-- https://xplr.dev/en/configuration

---@diagnostic disable
version = "0.19.0"
local xplr = xplr
---@diagnostic enable

local home = os.getenv("HOME")

-- Lua search path
package.path = home
  .. "/.config/xplr/plugins/?/init.lua;"
  .. home
  .. "/.config/xplr/plugins/?.lua;"
  .. package.path

-- Add `eval "$(luarocks path --lua-version 5.1)"` in your `.bashrc` or `.zshrc`.
-- Install packages with `luarocks install $name --local --lua-version 5.1`.
package.path = os.getenv("LUA_PATH") .. ";" .. package.path
package.cpath = os.getenv("LUA_CPATH") .. ";" .. package.cpath

-- Plugin Manager
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(
  string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path)
)

-- Plugins
xplr.config.modes.builtin.default.key_bindings.on_key.x = {
  help = "xpm",
  messages = {
    "PopMode",
    { SwitchModeCustom = "xpm" },
  },
}

require("xpm").setup({
  auto_install = true,
  auto_cleanup = true,
  plugins = {
    -- Let xpm manage itself
    "dtomvan/xpm.xplr",

    -- Implements support for dual-pane navigation into xplr
    "sayanarijit/dual-pane.xplr",

    -- Previewer implementation for xplr using suckless tabbed and nnn preview-tabbed
    "sayanarijit/preview-tabbed.xplr",

    -- Send files to running Neovim sessions using nvim-ctrl
    "sayanarijit/nvim-ctrl.xplr",

    -- The missing command mode for xplr
    {
      name = "sayanarijit/command-mode.xplr",
      setup = function()
        local m = require("command-mode")

        m.setup()

        local help = m.silent_cmd("help", "show global help menu")(
          m.BashExec([[glow --pager $XPLR_PIPE_GLOBAL_HELP_MENU_OUT]])
        )

        m.silent_cmd("doc", "show docs")(m.BashExec([[glow /usr/share/doc/xplr]]))

        local hello_lua = m.cmd("hello-lua", "Enter name and know location")(
          function(app)
            print("What's your name?")

            local name = io.read()
            local greeting = "Hello " .. name .. "!"
            local message = greeting .. " You are inside " .. app.pwd

            return {
              { LogSuccess = message },
            }
          end
        )

        -- Type `:hello-bash` and press enter to know your location
        local hello_bash = m.silent_cmd("hello-bash", "Enter name and know location")(
          m.BashExec([===[
            echo "What's your name?"

            read name
            greeting="Hello $name!"
            message="$greeting You are inside $PWD"

            echo LogSuccess: '"'$message'"' >> "${XPLR_PIPE_MSG_IN:?}"
          ]===])
        )

        -- map `?` to command `help`
        xplr.config.modes.builtin.default.key_bindings.on_key["?"] = help.action

        -- map `h` to command `hello-lua`
        xplr.config.modes.builtin.default.key_bindings.on_key.h = hello_lua.action

        -- map `H` to command `hello-bash`
        xplr.config.modes.builtin.default.key_bindings.on_key.H = hello_bash.action
      end,
    },

    -- xplr icon theme
    "prncss-xyz/icons.xplr",

    -- A clean, distraction free xplr table UI
    "sayanarijit/zentable.xplr",

    -- trach-cli integration for xplr
    "sayanarijit/trash-cli.xplr",

    -- zoxide integration for xplr
    "sayanarijit/zoxide.xplr",

    -- dragon integration for xplr
    "sayanarijit/dragon.xplr",

    -- -- xclip based copy-paste integration for xplr
    "sayanarijit/xclip.xplr",

    -- type-to-nav port for xplr
    "sayanarijit/type-to-nav.xplr",

    -- xplr + xargs = POWER!
    "sayanarijit/xargs.xplr",

    -- Context switch for xplr
    "igorepst/context-switch.xplr",

    -- An interactive finder plugin to complement map.xplr
    "sayanarijit/find.xplr",

    -- Visually inspect and interactively execute batch commands using xplr
    "sayanarijit/map.xplr",

    -- dua-cli integration for xplr
    -- "sayanarijit/dua-cli.xplr",

    -- xplr wrapper for https://github.com/ouch-org/ouch
    "dtomvan/ouch.xplr",

    -- Adds (dev)icons to xplr.
    {
      "dtomvan/extra-icons.xplr",
      after = function()
        xplr.config.general.table.row.cols[1] = {
          format = "custom.icons_dtomvan_col_1",
        }
      end,
    },

    -- fzf integration for xplr
    -- {
    --   name = "sayanarijit/fzf.xplr",
    --   setup = function()
    --     require("fzf").setup({
    --       args = "--preview 'pistol {}'",
    --     })
    --   end,
    -- },

    -- Use this plugin to paste your files to paste.rs, and open/delete them later in fzf.
    {
      name = "dtomvan/paste-rs.xplr",
      setup = function()
        require("paste-rs").setup({
          db_path = home .. "/" .. "paste.rs.list",
        })
      end,
    },

    -- xplr theme - Material Landscape 2
    -- {
    --   name = "sayanarijit/material-landscape2.xplr",
    --   setup = function()
    --     require("material-landscape2").setup({
    --       keep_default_layout = true,
    --     })
    --   end,
    -- },

    -- qrcp integration for xplr
    {
      name = "sayanarijit/qrcp.xplr",
      setup = function()
        require("qrcp").setup({
          send_options = "-i $(ip link show | awk '{print $2}' | grep ':$' | cut -d: -f1 | fzf)",
          receive_options = "-i $(ip link show | awk '{print $2}' | grep ':$' | cut -d: -f1 | fzf)",
        })
      end,
    },

    -- Terminal integration for xplr
    {
      name = "sayanarijit/alacritty.xplr",
      rev = "term",
      setup = function()
        local term = require("alacritty")

        local window = term.profile_wezterm()
        window.send_selection = true
        window.key = "ctrl-n"

        local tab = term.profile_wezterm_tab()
        tab.send_selection = true
        tab.key = "ctrl-t"

        local vsplit = term.profile_wezterm_vsplit()
        vsplit.send_selection = true
        vsplit.key = "ctrl-v"

        local hsplit = term.profile_wezterm_hsplit()
        hsplit.send_selection = true
        hsplit.key = "ctrl-h"

        term.setup({ window, tab, vsplit, hsplit })
      end,
    },
  },
})

-- Custom Config
xplr.config.general.enable_mouse = true
xplr.config.general.show_hidden = true
xplr.config.general.enable_recover_mode = true

require("registers").setup()
require("offline-docs").setup()

xplr.config.modes.builtin.default.key_bindings.on_key["ctrl-f"] = {
  help = "fzf",
  messages = {
    "PopMode",
    {
      BashExec = [===[
        fzf -m --preview 'pistol {}' | while read -r line; do
          echo FocusPath: "'"$line"'" >> "${XPLR_PIPE_MSG_IN:?}"
        done
      ]===],
    },
  },
}

-- Fennel Support
local fennel = require("fennel")

fennel.path = fennel.path
  .. ";"
  .. home
  .. "/.config/xplr/plugins/?/init.fnl;"
  .. home
  .. "/.config/xplr/plugins/?.fnl;"

table.insert(package.loaders or package.searchers, fennel.searcher)
