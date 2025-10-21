-- NvChad defaults
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- List of servers
local servers = {
  "html",
  "cssls",
  "pyright",
  "ruff",
  "ts_ls",
  "tailwindcss",
  "eslint",
}

-- 1) Global defaults for all servers (equivalent to passing in every setup)
vim.lsp.config("*", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

-- 2) Server-specific overrides

-- pyright: preserve custom pythonPath
vim.lsp.config("pyright", {
  settings = {
    python = {
      pythonPath = "./venv/bin/python",
    },
  },
})

-- 3) Enable all servers
vim.lsp.enable(servers)

-- 4) Formatting and fix-all on save (kept as-is)
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*.py", "*.js*", "*.ts*", "*.lua", "*.php" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*.py", "*.ts*", "*.js*", "*.lua", "*.php" },
  callback = function()
    local context = { only = { "source.fixAll" } }
    vim.lsp.buf.code_action({ context = context, apply = true })
  end,
})
