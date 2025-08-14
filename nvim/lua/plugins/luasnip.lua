-- Docstrings & Snippets
return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").config.setup({
      history = true,
      delete_check_events = "TextChanged",
    })
    -- Load custom snippets (optional)
    -- require("snippets.javascript")
    -- require("snippets.python")
  end,
}
