local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvim_tree.setup {
  -- Don’t fight netrw
  disable_netrw = true,
  hijack_netrw = true,

  -- Keep buffers stable when tree opens/closes
  hijack_cursor = true,
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },

  view = {
    side = "left",
    width = 48, -- tweak to taste
    preserve_window_proportions = true,
    signcolumn = "yes",
  },

  renderer = {
    root_folder_label = false, -- cleaner
    highlight_git = true,
    highlight_opened_files = "name",
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        folder = true,
        file = true,
        git = true,
      },
    },
  },

  git = {
    enable = true,
    ignore = false,
  },

  filters = {
    dotfiles = false,
    custom = { ".DS_Store", "venv", "node_modules", "__pycache__" },
  },
}
