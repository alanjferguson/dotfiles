return {
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
  },
  {
    "nvim-mini/mini.trailspace",
    event = "VeryLazy",
    config = true,
  },
}
