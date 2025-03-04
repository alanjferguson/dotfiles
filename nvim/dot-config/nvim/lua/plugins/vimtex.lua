return {
  "lervag/vimtex",
  lazy = false, -- lazy-loading will disable inverse search
  init = function()
    -- Disable conceallevel for LaTeX files
    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
      pattern = { "bib", "tex" },
      callback = function()
        vim.wo.conceallevel = 0
      end,
    })

    -- Disable K mapping as it conflicts with LSP hover
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }

    -- Use better quickfix method if available
    vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

    -- Detect OS and set viewer accordingly
    local is_mac = vim.fn.has('macunix') == 1
    local is_linux = vim.fn.has('unix') == 1 and vim.fn.has('macunix') == 0

    if is_mac then
      -- macOS configuration using Skim
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1  -- Forward search after compilation
      vim.g.vimtex_view_skim_activate = 1  -- Focus Skim after forward search
    elseif is_linux then
      -- Linux configuration using Zathura
      vim.g.vimtex_view_method = 'zathura'

      -- Optional: Set up synctex forward search with Zathura
      vim.g.vimtex_view_zathura_options = '--synctex-forward @line:@col:@tex @pdf'
    end

    -- General VimTeX settings
    vim.g.vimtex_compiler_latexmk = {
      build_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
  end,
}
