return {
  {
    "f-person/auto-dark-mode.nvim",
    depends = "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = { 
      { 
        'loctvl842/monokai-pro.nvim',
        setup = function()
          require("monokai-pro").setup({})
        end,
      },
    },
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme monokai-pro")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme monokai-pro-light")
      end,
    },
  }
}
