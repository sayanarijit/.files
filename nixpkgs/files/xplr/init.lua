version = "0.12.0"

xplr.config.general.default_ui.prefix = " "
xplr.config.general.default_ui.suffix = ""

xplr.config.general.focus_ui.prefix = "▸"
xplr.config.general.focus_ui.suffix = ""

xplr.config.general.selection_ui.prefix = " "
xplr.config.general.selection_ui.suffix = ""

xplr.config.general.selection_ui.style.add_modifiers = { "Dim", "CrossedOut" }

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

xplr.config.node_types.mime_essence["video"] = {
  ["*"] = {
    meta = { icon = "📽" },
  }
}

xplr.config.node_types.mime_essence["text"] = {
  ["*"] = {
    meta = {
      icon = "",
    },
  },
  csv = {
    meta = {
      icon = "",
    },
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
