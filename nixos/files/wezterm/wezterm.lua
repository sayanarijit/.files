local wezterm = require("wezterm")

local color = {
  bg_dark = "#151515",
  bg_light = "#212121",
  fg_dark = "#434343",
  fg_light = "#E5E5E5",
}

local colors = {
  tab_bar = {
    active_tab = {
      bg_color = color.bg_light,
      fg_color = color.fg_light,
    },
    inactive_tab = {
      bg_color = color.bg_dark,
      fg_color = color.fg_dark,
    },
    inactive_tab_hover = {
      bg_color = color.bg_light,
      fg_color = color.fg_dark,
    },
    new_tab = {
      bg_color = color.bg_dark,
      fg_color = color.fg_dark,
    },
    background = color.bg_dark,
  },
}

local hyperlink_rules = {
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
}

local url_patterns = {}
for _, l in ipairs(hyperlink_rules) do
  table.insert(url_patterns, l.regex)
end

local keys = {
  {
    key = "u",
    mods = "CTRL|SHIFT",
    action = wezterm.action.QuickSelectArgs({
      label = "open url",
      patterns = url_patterns,
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.log_info("opening: " .. url)
        wezterm.open_with(url)
      end),
    }),
  },

  {
    key = "e",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(function(window, pane)
      local lines = pane:get_lines_as_text()
      local tmpfile = os.tmpname() .. ".txt"
      local f = assert(io.open(tmpfile, "w"))
      f:write(lines)
      f:flush()

      window:perform_action(
        wezterm.action.SpawnCommandInNewTab({
          args = { "nvim", "+", tmpfile },
        }),
        pane
      )

      wezterm.sleep_ms(1000)
      os.remove(tmpfile)
    end),
  },
}

for i = 1, 8 do
  -- ALT + number to activate that tab
  table.insert(keys, {
    key = tostring(i),
    mods = "ALT",
    action = wezterm.action({ ActivateTab = i - 1 }),
  })
end

return {
  font = wezterm.font("Hack"),
  font_size = 12.0,
  colors = colors,
  color_scheme = "MaterialDark",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  scrollback_lines = 3500,
  enable_scroll_bar = true,
  exit_behavior = "Close",
  adjust_window_size_when_changing_font_size = false,
  check_for_updates = false,
  keys = keys,
  audible_bell = "Disabled",
  hyperlink_rules = hyperlink_rules,
  window_background_opacity = 0.95,
  window_decorations = "NONE",
}
