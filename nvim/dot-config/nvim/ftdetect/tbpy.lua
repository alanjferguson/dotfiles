vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.tbpy", command = "setfiletype python" })
