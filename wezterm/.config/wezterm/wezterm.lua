local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- local canonical_solarized = require('canonical-solarized')
-- canonical_solarized.apply_to_config(config)
-- config.color_scheme = "Canonical Solarized Light"
config.color_scheme = 'GitHub-Dark-Default'

-- Font setup
config.font = wezterm.font({
	family = "JuliaMono",
})

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
