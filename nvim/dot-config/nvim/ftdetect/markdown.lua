-- Wrapping: soft-wrap at word boundaries, don't hard-break
vim.opt_local.wrap = true
vim.opt_local.linebreak = true       -- wrap at word boundaries, not mid-word
vim.opt_local.breakindent = true     -- wrapped lines visually align
vim.opt_local.showbreak = "↪ "

-- Treat wrapped lines as separate lines for j/k (less jarring in long paragraphs)
vim.keymap.set({ "n", "x" }, "j", "gj", { buffer = true })
vim.keymap.set({ "n", "x" }, "k", "gk", { buffer = true })

-- Indentation: 2 spaces is the markdown convention (matters for nested lists)
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- Spell checking on by default for prose
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

-- Conceal: hide markup (e.g. **bold** shows as bold) but not on the cursor line
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ""

-- Don't auto-insert comment leaders; markdown's "comments" are just text
vim.opt_local.formatoptions:remove({ "c", "r", "o" })

-- Useful textwidth for those who prefer hard-wrapping (off by default — uncomment if wanted)
-- vim.opt_local.textwidth = 80
