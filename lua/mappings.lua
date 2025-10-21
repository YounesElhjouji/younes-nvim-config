require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map({ "n", "x" }, ":", ";", { desc = "Next search movement" })
map({ "n", "x" }, ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- -- LSP mappings
map("n", "gR", "<CMD>lua vim.lsp.buf.rename()<CR>")
map("n", "ga", "<CMD>lua vim.lsp.buf.code_action()<CR>")
--
-- Command-line (c) mode mappings for history navigation:
map("c", "<C-j>", "<Down>", { desc = "Cmdline: Go to next history entry" })
map("c", "<C-k>", "<Up>", { desc = "Cmdline: Go to previous history entry" })

-- Quickfix list mappings
map("n", "]q", ":cnext<CR>", { desc = "Next quickfix item" })
map("n", "[q", ":cprev<CR>", { desc = "Previous quickfix item" })
map("n", "<leader>co", ":copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>cc", ":cclose<CR>", { desc = "Close quickfix list" })
map("n", "<leader>cq", ":caddbuffer<CR>", { desc = "Add current buffer to quickfix list" })
map("n", "<leader>cf", ":cfdo %s/<C-r><C-w>//g<CR>", { desc = "Find and replace in quickfix list" })


-- My write mappings
map({ "n", "v" }, "<leader>s", "<cmd> wall <cr>")


-- Paste from the system clipboard
map("i", "<C-v>", '<C-r>+', { desc = "Paste from system clipboard" })


-- Close mappings
map("n", "<leader>qo", "<CMD>CloseOthers<CR>", { desc = "Close all tabs except current" })
map("n", "<leader>qh", "<CMD>CloseLeft<CR>", { desc = "Close all tabs to the left" })
map("n", "<leader>ql", "<CMD>CloseRight<CR>", { desc = "Close all tabs to the right" })
map({ "n" }, "<leader>qq", "<CMD>qa<CR>", { desc = "Close all" })
map({ "n" }, "<leader>qs", "<CMD>wqa<CR>", { desc = "Save and Close all" })
map({ "n", "i", "v" }, "<C-q>", "<CMD>qa<CR>", { desc = "Close all" })

-- Vertical nav
map('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
map('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })

-- Terminal mode mapping
map('t', '<C-t>', '<C-\\><C-n>', { noremap = true, silent = true, desc = "Switch from terminal to normal mode" })

-- Line extremes navigation
map("n", "G", "Gzz", { noremap = true, silent = true, desc = "Go to end of file and center" })
map("n", "H", "^", { noremap = true, silent = true, desc = "Move to the beginning of the line" })
map("n", "L", "$", { noremap = true, silent = true, desc = "Move to the end of the line" })
map("v", "H", "^", { noremap = true, silent = true, desc = "Select to the beginning of the line" })
map("v", "L", "$", { noremap = true, silent = true, desc = "Select to the end of the line" })

-- Open Diagnostics
map("n", "<leader>df", vim.diagnostic.open_float,
  { noremap = true, silent = true, desc = "Show diagnostics in a floating window" })

-- Noice dismiss
map("n", "<leader>dd", ":NoiceDismiss<CR>", { noremap = true, silent = true, desc = "Dismiss all Noice messages" })

-- Harpoon mappings (short)
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

map("n", "<leader>a", harpoon_mark.add_file, { desc = "Add file to Harpoon" })
map("n", "<leader>h", harpoon_ui.toggle_quick_menu, { desc = "Toggle Harpoon menu" })
map("n", "<leader>1", function() harpoon_ui.nav_file(1) end, { desc = "Go to Harpoon mark 1" })
map("n", "<leader>2", function() harpoon_ui.nav_file(2) end, { desc = "Go to Harpoon mark 2" })
map("n", "<leader>3", function() harpoon_ui.nav_file(3) end, { desc = "Go to Harpoon mark 3" })
map("n", "<leader>4", function() harpoon_ui.nav_file(4) end, { desc = "Go to Harpoon mark 4" })

-- global replace from clipboard
map("n", "<C-t>", "ggVGp:w<CR>", { noremap = true, desc = "Replace page with clipboard content and save file" })

-- Map <leader>cb to copy all visible buffers' content to clipboard
map("n", "<leader>cb", "<CMD>CopyBuffersToClipboard<CR>", { desc = "Copy all visible buffers to clipboard" })
map("n", "<leader>cp", "<CMD>CopyCurrentBufferToClipboard<CR>", { desc = "Copy all visible buffers to clipboard" })
map("n", "<leader>cg", "<CMD>CopyGitFilesToClipboard<CR>", { desc = "Copy all visible buffers to clipboard" })


-- Pasting
map("v", "p", '"_dP', { noremap = true, silent = true })

-- Hop keybindings
local hop = require('hop')

map('n', '<leader>k', '<CMD>HopWord<CR>', { desc = 'Hop: Jump to word' })
map('n', '<leader>l', function()
  hop.hint_lines()
end, { desc = 'Hop: Jump to line' })
map('n', '<leader>jj', function()
  hop.hint_char1()
end, { desc = 'Hop: Jump to character' })
map('n', '<leader>jk', function()
  hop.hint_char2()
end, { desc = 'Hop: Jump to character' })

-- Navigate through changes
map('n', '[c', 'g;zz', { noremap = true, silent = true, desc = "Navigate to previous changed line" })
map('n', ']c', 'g,zz', { noremap = true, silent = true, desc = "Navigate to previous changed line" })

-- Toggle function to switch lualine on/off.
function ToggleLualine()
  if vim.o.laststatus == 0 then
    vim.o.laststatus = 2 -- 2: always show statusline
    print("Statusline enabled")
  else
    vim.o.laststatus = 0
    print("Statusline disabled")
  end
end

-- Map <leader>ss to toggle the statusline.
vim.api.nvim_set_keymap("n", "<leader>mm", ":lua ToggleLualine()<CR>", {
  noremap = true,
})

-- telescope find files single key
vim.keymap.set('n', 'F', '<Cmd>Telescope find_files<CR>', { desc = 'Telescope find files' })

map("n", "dh", "d^", { noremap = true, silent = true, desc = "Delete to the beginning of the line" })
map("n", "dl", "d$", { noremap = true, silent = true, desc = "delete to the end of the line" })
map("n", "ch", "c^", { noremap = true, silent = true, desc = "Change to the beginning of the line" })
map("n", "cl", "c$", { noremap = true, silent = true, desc = "change to the end of the line" })
map("n", "yh", "y^", { noremap = true, silent = true, desc = "Yank to the beginning of the line" })
map("n", "yl", "y$", { noremap = true, silent = true, desc = "Yank to the end of the line" })

