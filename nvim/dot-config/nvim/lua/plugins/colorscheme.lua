return {
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd([[ colorscheme modus ]])
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd([[ colorscheme modus ]])
      end,
    },
  },
  {
    "miikanissi/modus-themes.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "auto",
      variant = 'tinted',
      dim_inactive = false,
    }
  },
}
