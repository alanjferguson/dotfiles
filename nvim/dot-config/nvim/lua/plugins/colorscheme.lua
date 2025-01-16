return {
  {
    "f-person/auto-dark-mode.nvim",
    depends = "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = { { 'navarasu/onedark.nvim', }, },
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        require('onedark').setup({
          style = 'dark'
        })
        vim.cmd('colorscheme onedark')
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        require('onedark').setup({
          style = 'light'
        })
        vim.cmd('colorscheme onedark')
      end,
    },
  }
}
