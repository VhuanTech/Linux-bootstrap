-- ~/.config/nvim/lua/plugins.lua
return {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000
  },
}
