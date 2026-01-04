require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd

-- Auto-close nvim-tree when it loses focus
autocmd("BufLeave", {
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      require("nvim-tree.api").tree.close()
    end
  end,
})
