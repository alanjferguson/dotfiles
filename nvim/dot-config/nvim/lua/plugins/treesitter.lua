return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = {
        disable = { "c", "cpp" },
      },
    },
  }, 
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = function()
          return vim.bo.commentstring
        end,
      }
    end,
  },
}
