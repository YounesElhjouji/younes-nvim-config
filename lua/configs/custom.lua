-- ===========================================================================
--                             AUTO COMMANDS
-- ===========================================================================

-- Open NvimTree on VimEnter if opening a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      require('nvim-tree.api').tree.open()
    end
  end,
  desc = "Open NvimTree when opening a directory",
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "NvimTree_*",
  callback = function()
    local api_ok, api = pcall(require, "nvim-tree.api")
    if api_ok then
      api.tree.close()
    end
  end,
  desc = "Close NvimTree when its buffer is left",
})

vim.api.nvim_create_augroup("PythonIndent", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = "PythonIndent",
  pattern = "*.py",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- ===========================================================================
--                            MACRO NOTIFICATIONS
-- ===========================================================================

local function notify_macro_start()
  local register = vim.fn.reg_recording()
  if register ~= "" then
    vim.notify("Start recording @" .. register, "info", { title = "Macro" })
  end
end

local function notify_macro_end()
  local register = vim.fn.reg_recording()
  if register ~= "" then
    vim.notify("Stopped recording @" .. register, "info", { title = "Macro" })
  else
    vim.notify("Recording stopped!", "info", { title = "Macro" })
  end
end

-- Auto commands for macro recording notifications
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = notify_macro_start,
  desc = "Notify when macro recording starts",
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = notify_macro_end,
  desc = "Notify when macro recording stops",
})

-- Remove status line
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.o.laststatus = 0
    print("laststatus set to 0")
  end,
})
