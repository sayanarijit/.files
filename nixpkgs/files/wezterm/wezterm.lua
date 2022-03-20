local wezterm = require("wezterm")

local bg_dark = "#151515"
local bg_light = "#212121"
local fg_dark = "#434343"
local fg_light = "#E5E5E5"

local colors = {
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
  font = wezterm.font("Hack"),
  font_size = 12.0,
  colors = colors,
  color_scheme = "MaterialDark",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  scrollback_lines = 3500,
  exit_behavior = "Close",
  adjust_window_size_when_changing_font_size = false,
  check_for_updates = false,
  hyperlink_rules = {
    -- Linkify things that look like URLs
    -- This is actually the default if you don't specify any hyperlink_rules
    {
      regex = "\\b\\w+://\\S*\\b",
      format = "$0",
    },

    -- linkify email addresses
    {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
    },

    -- file:// URI
    {
      regex = "\\bfile://\\S*\\b",
      format = "$0",
    },

    -- Make task numbers clickable
    --[[
    {
      regex = "\\b[tT](\\d+)\\b"
      format = "https://example.com/tasks/?t=$1"
    }
    ]]
  },
}
