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

-- Hyperlinking
config.hyperlink_rules = {
	-- Linkify things that look like URLs and the host has a TLD name.
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},

	-- linkify email addresses
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
		format = "mailto:$0",
	},

	-- file:// URI
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\bfile://\S*\b]],
		format = "$0",
	},

	-- Linkify things that look like URLs with numeric addresses as hosts.
	-- E.g. http://127.0.0.1:8000 for a local development server,
	-- or http://192.168.1.1 for the web interface of many routers.
	{
		regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
		format = "$0",
	},
}

return config

-- vim: ts=2 sts=2 sw=2 et
