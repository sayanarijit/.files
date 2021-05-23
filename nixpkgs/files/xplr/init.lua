version = "0.10.0"

xplr.config.general.default_ui.prefix = " "
xplr.config.general.default_ui.suffix = ""

xplr.config.general.focus_ui.prefix = "▸"
xplr.config.general.focus_ui.suffix = ""

xplr.config.general.focus_ui.style.add_modifiers = { "Bold" }
xplr.config.general.focus_ui.style.bg = { Rgb = { 50, 50, 50 } }

xplr.config.general.focus_ui.style.fg = { Rgb = { 170, 150, 130 } }

xplr.config.general.panel_ui.default.style.bg = { Rgb = { 33, 33, 33 } }

xplr.config.general.panel_ui.default.style.fg = { Rgb = { 170, 150, 130 } }

xplr.config.node_types.directory = {
  style = {
    fg = "Cyan",
  },
  meta = {
    icon = "",
  },
}

xplr.config.node_types.file = {
  meta = {
    icon = "",
  },
}

xplr.config.node_types.symlink = {
  meta = {
    icon = "",
  },
}

xplr.config.node_types.mime_essence["text/plain"] = {
  meta = {
    icon = "",
  },
}

xplr.config.node_types.mime_essence["text/csv"] = {
  meta = {
    icon = "",
  },
}

xplr.config.node_types.extension["md"] = {
  meta = {
    icon = "",
  },
}

xplr.config.node_types.extension["lock"] = {
  meta = {
    icon = "",
  },
}

xplr.config.node_types.extension["rs"] = {
  meta = {
    icon = "",
  },
}

xplr.config.node_types.special["Cargo.toml"] = {
  meta = {
    icon = "",
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key["F"] = {
  help = "fzf mode",
  messages = {
    {
      SwitchModeCustom = "fzxplr",
    },
    "Refresh",
  },
}

xplr.config.modes.custom["fzxplr"] = {
  name = "fzxplr",
  key_bindings = {
    remaps = {
      ["/"] = "F",
    },
    on_key = {
      F = {
        help = "search",
        messages = {
          {
            BashExec = [===[
            PTH=$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}" | awk -F/ '{print $NF}' | fzf)
            if [ -d "$PTH" ]; then
              echo ChangeDirectory: "'"${PWD:?}/${PTH:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
            elif [ -f "$PTH" ]; then
              echo FocusPath: "'"${PWD:?}/${PTH:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
            fi
            ]===]
          },
          "PopMode",
          "Refresh",
        },
      },
    },
    default = {
      messages = {
        "PopMode",
        "Refresh",
      },
    },
  },
}

