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

vim.lsp.enable(servers)
