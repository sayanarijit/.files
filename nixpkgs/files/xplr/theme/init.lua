local function setup()

  xplr.config.general.table.col_widths = {
    { Length = 8 },
    { Percentage = 50 },
    { Percentage = 10 },
    { Percentage = 10 },
    { Min = 1 },
  }

  xplr.config.general.default_ui.prefix = " "
  xplr.config.general.default_ui.suffix = ""
  xplr.config.general.focus_ui.prefix = "▸"
  xplr.config.general.focus_ui.suffix = ""
  xplr.config.general.focus_ui.style.fg = { Rgb = {170,150,130} }
  xplr.config.general.focus_ui.style.bg = { Rgb = {50,50,50} }
  xplr.config.general.focus_ui.style.add_modifiers = {"Bold"}
  xplr.config.general.selection_ui.prefix = " "
  xplr.config.general.selection_ui.suffix = ""
  xplr.config.general.selection_ui.style.fg = { Rgb = {70,70,70} }
  xplr.config.general.selection_ui.style.add_modifiers = {"Bold","CrossedOut"}
  xplr.config.general.sort_and_filter_ui.separator.format = " » "
  xplr.config.general.panel_ui.default.title.style.bg = { Rgb = {170,150,130} }
  xplr.config.general.panel_ui.default.title.style.fg = { Rgb = {40,40,40} }
  xplr.config.general.panel_ui.default.title.style.add_modifiers = {"Bold"}
  xplr.config.general.panel_ui.default.style.fg = { Rgb = {170,150,130} }
  xplr.config.general.panel_ui.default.style.bg = { Rgb = {33,33,33} }
  xplr.config.general.panel_ui.default.borders = {}
  xplr.config.general.panel_ui.help_menu.style.bg = { Rgb = {26,26,26} }
  xplr.config.general.panel_ui.selection.style.bg = { Rgb = {26,26,26} }
end

return { setup = setup }
