-- ~/.config/nvim/lua/plugins/nvim-navic.lua
return {
  "SmiteshP/nvim-navic",
  dependencies = {
    "neovim/nvim-lspconfig", -- optional but recommended
  },
  opts = {
    separator = " > ",
    highlight = true,
    depth_limit = 5,
    -- Safe output for weird symbols
    safe_output = true,
    -- Show icons
    icons = {
      File = "󰈔 ",
      Module = " ",
      Namespace = "󰅪 ",
      Package = " ",
      Class = "󰌗 ",
      Method = "󰆧 ",
      Property = "󰜢 ",
      Field = " ",
      Constructor = " ",
      Enum = " ",
      Interface = " ",
      Function = "󰊕 ",
      Variable = "󰂡 ",
      Constant = "󰏫 ",
      String = " ",
      Number = " ",
      Boolean = "󰨙 ",
      Array = "󰅪 ",
      Object = "󰅩 ",
      Key = "󰌋 ",
      Null = "󰟢 ",
      EnumMember = " ",
      Struct = " ",
      Event = " ",
      Operator = "󰆕 ",
      TypeParameter = "󰅲 ",
    },
  },
  -- Optional: Attach navic to LSP client on setup
  init = function()
    vim.g.navic_silence = true -- silence warnings
  end,
  config = function(_, opts)
    local navic = require("nvim-navic")
    navic.setup(opts)

    -- Optional: Attach to LSP in lspconfig's on_attach
    -- You can also do this in your lsp config
  end,
}
