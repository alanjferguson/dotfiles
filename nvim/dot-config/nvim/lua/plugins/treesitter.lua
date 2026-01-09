return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- ensure that these are always installed
        ensure_installed = { "c", "lua", "markdown" },

        -- automatically install missing parser when  entering new buffers
        auto_install = true,

        highlight = {
          -- trying all treesitter for moment
          enable = true,
        },
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })

      -- only supported on NVIM >= 0.10.0
      assert(vim.fn.has("nvim-0.10"), "NVIM version too old")

      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },
}
