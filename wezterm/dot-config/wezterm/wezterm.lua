-- WezTerm configuration
local wezterm = require("wezterm")

-- Create a config object using the builder pattern
local config = wezterm.config_builder()

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find('Dark') then
    return 'tokyonight_night'
  else
    return 'tokyonight_day'
  end
end

-- Set the color scheme based on system appearance
config.color_scheme = scheme_for_appearance(get_appearance())

-- Make the cursor easier to see by using reverse video style
config.force_reverse_video_cursor = true

-- Font setup
config.font_size = 14.0
config.font = wezterm.font({
  family = "JuliaMono Nerd Font",
})
-- Use slashed zero for better readability
config.harfbuzz_features = { 'zero' }

-- Use the retro text tab bar style instead of the fancy one
config.use_fancy_tab_bar = false

return config

-- vim: ts=2 sts=2 sw=2 et
