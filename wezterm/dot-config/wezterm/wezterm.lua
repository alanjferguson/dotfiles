local wezterm = require("wezterm")

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
  if appearance:find 'Dark' then
    return 'tokyonight_night'
  else
    return 'tokyonight_day'
  end
end

-- config.color_scheme_dirs = { '~/.config/wezterm/colors' }
config.color_scheme = scheme_for_appearance(get_appearance())

config.force_reverse_video_cursor = true

-- Font setup
config.font_size = 14.0
config.font = wezterm.font({
	family = "JuliaMono Nerd Font",
})
config.harfbuzz_features = { 'zero' }


-- Use retro text tab bar instead
config.use_fancy_tab_bar = false

return config

-- vim: ts=2 sts=2 sw=2 et
