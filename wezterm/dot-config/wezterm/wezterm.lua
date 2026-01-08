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
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

-- Set the color scheme based on system appearance
config.color_scheme = scheme_for_appearance(get_appearance())

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

-- Use the retro text tab bar style instead of the fancy one
config.use_fancy_tab_bar = false

-- Disable fullscreen mode keybindings
config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config

-- vim: ts=2 sts=2 sw=2 et
