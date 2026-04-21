local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = {
  "html",
  "cssls",
  "pyright",
  "ruff",
  "ts_ls",
  "tailwindcss",
}

vim.lsp.config("*", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

vim.lsp.config("pyright", {
  settings = {
    python = {
      venvPath = ".",
      venv = "venv",
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = function(client, bufnr)
    -- Disable ruff's formatting so conform handles it
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
})

vim.lsp.enable(servers)
