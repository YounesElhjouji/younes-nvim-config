local function dashboard_cache_path()
  return vim.fs.joinpath(vim.fn.stdpath "cache", "dashboard", "cache")
end

local function dashboard_window()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)

  if vim.bo[current_buf].filetype == "dashboard" then
    return current_win, current_buf
  end

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "dashboard" then
      return win, buf
    end
  end
end

local function patch_dashboard_centering()
  local ok, utils = pcall(require, "dashboard.utils")
  if not ok or utils._window_width_centering then
    return
  end

  utils._window_width_centering = true
  utils.center_align = function(lines)
    local win = dashboard_window()
    local width = win and vim.api.nvim_win_get_width(win) or vim.o.columns
    local centered_lines = {}

    for _, line in ipairs(lines) do
      local fill = math.max(math.floor((width - vim.api.nvim_strwidth(line)) / 2), 0)
      table.insert(centered_lines, (" "):rep(fill) .. line)
    end

    return centered_lines
  end
end

local function redraw_dashboard()
  local win, buf = dashboard_window()
  if not win or not buf then
    return
  end

  local dashboard = require "dashboard"
  local opts = dashboard.opts
  if not opts then
    return
  end

  local config = vim.tbl_extend("force", vim.deepcopy(opts.config or {}), {
    path = dashboard_cache_path(),
    bufnr = buf,
    winid = win,
    confirm_key = opts.confirm_key,
    shortcuts_left_side = opts.shortcuts_left_side,
    shortcut_type = opts.shortcut_type,
    shuffle_letter = opts.shuffle_letter,
    letter_list = opts.letter_list,
    change_to_vcs_root = opts.change_to_vcs_root,
  })

  if opts.preview and opts.preview.command and #opts.preview.command > 0 then
    config = vim.tbl_extend("force", config, opts.preview)
  end

  vim.bo[buf].modifiable = true
  require("dashboard.theme." .. opts.theme)(config)
  vim.bo[buf].modifiable = false
end

patch_dashboard_centering()

require("dashboard").setup {
  theme = "doom",
  config = {
    header = {
      "                                                      ",
      "                                                      ",
      "                                                      ",
      "                                                      ",
      "▓██   ██▓ ▒█████   █    ██  ███▄    █ ▓█████   ██████ ",
      " ▒██  ██▒▒██▒  ██▒ ██  ▓██▒ ██ ▀█   █ ▓█   ▀ ▒██    ▒ ",
      "  ▒██ ██░▒██░  ██▒▓██  ▒██░▓██  ▀█ ██▒▒███   ░ ▓██▄   ",
      "  ░ ▐██▓░▒██   ██░▓▓█  ░██░▓██▒  ▐▌██▒▒▓█  ▄   ▒   ██▒",
      "  ░ ██▒▓░░ ████▓▒░▒▒█████▓ ▒██░   ▓██░░▒████▒▒██████▒▒",
      "   ██▒▒▒ ░ ▒░▒░▒░ ░▒▓▒ ▒ ▒ ░ ▒░   ▒ ▒ ░░ ▒░ ░▒ ▒▓▒ ▒ ░",
      " ▓██ ░▒░   ░ ▒ ▒░ ░░▒░ ░ ░ ░ ░░   ░ ▒░ ░ ░  ░░ ░▒  ░ ░",
      " ▒ ▒ ░░  ░ ░ ░ ▒   ░░░ ░ ░    ░   ░ ░    ░   ░  ░  ░  ",
      " ░ ░         ░ ░     ░              ░    ░  ░      ░  ",
      " ░ ░                                                  ",
      "                                                      ",
      "                                                      ",
    },
    -- Centered buttons for quick actions
    center = {
      {
        icon = "  ",
        desc = "Recently opened files                 ",
        action = "Telescope oldfiles",
        key = "r",
      },
      {
        icon = "  ",
        desc = "Find File                             ",
        action = "Telescope find_files",
        key = "f",
      },
      {
        icon = "  ",
        desc = "Find word                             ",
        action = "Telescope live_grep",
        key = "w",
      },
      {
        icon = "  ",
        desc = "Open Neovim config                    ",
        action = "edit ~/.config/nvim/init.lua",
        key = "c",
      },
      {
        icon = "  ",
        desc = "Quit Neovim                           ",
        action = "qa", -- Use "qa" for quit all
        key = "q",
      },
    },
    footer = {
      -- "ُهَرَي اًرْيَخ ٍةَّرَذ ل اقْثِم ْلَمْعَي نَمَف"
      "Akhdem a ss7aybi la gha tkhdem!",
    },
  },
}

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "DashboardFooter", {
      fg = "#FFFFFF",
      bg = "#1E222A",
      bold = true,
      height = 15,
    })
  end,
})

vim.api.nvim_create_autocmd("WinResized", {
  callback = function()
    vim.schedule(redraw_dashboard)
  end,
})
