return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function(_, opts)
      opts.exclude = opts.exclude or {}
      opts.exclude.filetypes = opts.exclude.filetypes or {}

      if not vim.tbl_contains(opts.exclude.filetypes, "dashboard") then
        table.insert(opts.exclude.filetypes, "dashboard")
      end

      return opts
    end,
  },
  -- {
  --   "nvchad/base46",
  --   build = function()
  --     require("base46").load_all_highlights()
  --   end,
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      require "configs.nvim-tree"
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "YounesElhjouji/nvim-copy",
    lazy = false,
    config = function()
      require("nvim_copy").setup {
        ignore = {
          "*node_modules/*",
          ".git/*",
          "*-lock*",
          "*.log",
          "build/*",
          "*/configs/*",
          "*.toml",
          "*__pycache__*",
          "*venv*",
          "package-lock.json",
        },
      }
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require "configs.dashboard"
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    cmd = { "HopWord" },
    opts = { keys = "etovxqpdygfblzhckisuran" },
  },
  { "tpope/vim-surround", lazy = false },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.noice"
    end,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup {
        menu = { width = vim.api.nvim_win_get_width(0) - 20 },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  { "nvim-treesitter/nvim-treesitter" },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettierd",
        "ruff",
        "typescript-language-server",
        "tailwindcss-language-server",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local luasnip = require "luasnip"
      luasnip.filetype_extend("typescriptreact", { "html" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  { "rafamadriz/friendly-snippets" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
    opts = {},
  },
  {
    "Aasim-A/scrollEOF.nvim",
    lazy = false,
    opts = {},
  },
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    enabled = function()
      return vim.env.USER ~= "root" or vim.env.SUDO_USER ~= nil
    end,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        require("base46").load_all_highlights()
        require("nvconfig").base46.theme = "solarized_dark"
        require("base46").load_all_highlights()
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        require("base46").load_all_highlights()
        require("nvconfig").base46.theme = "solarized_light"
        require("base46").load_all_highlights()
      end,
    },
  },
}
