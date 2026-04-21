require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    python = { "ruff_organize_imports", "ruff_format" },
    lua = { "stylua" },
  },
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "markdown" then
      return false
    end
    return { timeout_ms = 500, lsp_fallback = false }
  end,
})
