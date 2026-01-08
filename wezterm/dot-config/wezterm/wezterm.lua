-- WezTerm configuration
local wezterm = require("wezterm")

-- Create a config object using the builder pattern
local config = wezterm.config_builder()

local function get_color_by_key(key)
	local current_scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]

	local key_to_color = {
		black = current_scheme.ansi[1],
		red = current_scheme.ansi[2],
		green = current_scheme.ansi[3],
		yellow = current_scheme.ansi[4],
		blue = current_scheme.ansi[5],
		magenta = current_scheme.ansi[6],
		cyan = current_scheme.ansi[7],
		white = current_scheme.ansi[8],
		black_bright = current_scheme.brights[1],
		red_bright = current_scheme.brights[2],
		green_bright = current_scheme.brights[3],
		yellow_bright = current_scheme.brights[4],
		blue_bright = current_scheme.brights[5],
		magenta_bright = current_scheme.brights[6],
		cyan_bright = current_scheme.brights[7],
		white_bright = current_scheme.brights[8],
	}

  if key_to_color[key] then
    return key_to_color[key]
  end

  return current_scheme[key]
end

-- Set the color scheme based on system appearance
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
if wezterm.gui then
  config.color_scheme = wezterm.gui.get_appearance() == "Dark" and "Modus-Vivendi" or "Modus-Operandi"
end

-- Font setup
config.font_size = 11.0
config.font = wezterm.font({
  family = "IosevkaTerm NF",
  weight = "Medium",
  harfbuzz_features = {
    -- All the features can be found here: https://typeof.net/Iosevka/
    -- Turn off ligatures
    "calt=0", -- Ligatures like != -> ==>
    "dlig=0", -- Discretionary ligatures

    -- Style sets, only one can be enabled (1) at a time
    -- Disable all to get the default look and feel
    "ss01=0", -- Andale Mono
    "ss02=0", -- Anonymous Pro
    "ss03=0", -- Consolas
    "ss04=0", -- Menlo
    "ss05=0", -- Fira Mono
    "ss06=0", -- Liberation Mono
    "ss07=0", -- Monaco
    "ss08=1", -- Pragmata Pro
    "ss09=0", -- Source Code Pro
    "ss10=0", -- Envy Code R
    "ss11=0", -- X Window Style
    "ss12=0", -- Ubuntu Mono
    "ss13=0", -- Lucida
    "ss14=0", -- JetBrains Mono
    "ss15=0", -- IBM Plex Mono
    "ss16=0", -- PT Mono
    "ss17=0", -- Recursive Mono
    "ss18=0", -- Input Mono
    "ss19=0", -- 19 seems to be missing for some reason unknown to me
    "ss20=0", -- Curly Style
  },
})

-- Hide window title bar (but keep it resizable!)
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Use the retro text tab bar style instead of the fancy one
config.use_fancy_tab_bar = false

config.tab_max_width = 32

-- Use the same font as terminal
config.window_frame = {
  font = config.font,
  font_size = config.font_size,
  active_titlebar_bg = get_color_by_key('foreground'),
  inactive_titlebar_bg = get_color_by_key('foreground'),
}

config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = get_color_by_key('foreground'),

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = get_color_by_key('selection_bg'),
      -- The color of the text for the tab
      fg_color = get_color_by_key('selection_fg'),

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = get_color_by_key('foreground'),
      fg_color = get_color_by_key('background'),
      intensity = 'Half',
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = get_color_by_key('cursor_fg'),
      fg_color = get_color_by_key('cursor_bg'),
      intensity = 'Bold',
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = get_color_by_key('foreground'),
      fg_color = get_color_by_key('background'),
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = get_color_by_key('cursor_fg'),
      fg_color = get_color_by_key('cursor_bg'),

    },
  },
}

-- Cursor config
config.default_cursor_style = "SteadyBlock"
config.cursor_thickness = "0.1cell"
config.force_reverse_video_cursor = true

config.default_domain = 'WSL:Ubuntu'

config.keys = {
  -- Disable fullscreen mode keybindings
  {
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config

-- vim: ts=2 sts=2 sw=2 et
