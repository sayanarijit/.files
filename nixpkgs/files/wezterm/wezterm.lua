local wezterm = require("wezterm")
local launchMenu = {
  { label = "htop", args = { "htop" } },
  { label = "xplr", args = { "xplr" } },
}

local bg_dark = "#111111"
local bg_light = "#212121"
local fg_dark = "#434343"
local fg_light = "#E5E5E5"

local colours = {
  tab_bar = {
    active_tab = {
      bg_color = bg_light,
      fg_color = fg_light,
    },
    inactive_tab = { bg_color = bg_dark, fg_color = fg_dark },
    inactive_tab_hover = {
      bg_color = bg_light,
      fg_color = fg_dark,
    },
    new_tab = {
      bg_color = bg_dark,
      fg_color = fg_dark,
    },
    background = bg_dark,
  },
}

return {
  lauch_menu = launchMenu,
  font = wezterm.font("Hack", { font_size = 0.8 }),
  colors = colours,
  color_scheme = "MaterialDark",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  scrollback_lines = 3500,
}
