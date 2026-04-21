require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

autocmd("BufLeave", {
  callback = function()
    -- Auto-close nvim-tree when it loses focus
    if vim.bo.filetype == "NvimTree" then
      require("nvim-tree.api").tree.close()
    end

    -- Auto-close quickfix when it loses focus
    if vim.bo.filetype == "qf" then
      vim.cmd "cclose"
    end
  end,
})
