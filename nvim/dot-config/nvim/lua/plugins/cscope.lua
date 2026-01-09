return {
  {
    "dhananjaylatkar/cscope_maps.nvim",
    lazy = true,
    ft = { "c", "cpp" },
    dependencies = {
      "folke/snacks.nvim", -- for picker
      -- "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
    },
    opts = {
      cscope = {
        exec = "gtags-cscope",
        picker = "snacks",
      },
      -- prefix = "<C-c>",
    },
  },
}
