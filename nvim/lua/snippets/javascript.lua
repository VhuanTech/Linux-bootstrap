-- ~/.config/nvim/lua/snippets/javascript.lua

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("javascript", {
  -- docf: Function doc
  s({ trig = "docf", desc = "JSDoc function" }, {
    t({ "/**", " * " }),
    i(1, "Description"),
    t({ "", " *", " * @param {" }),
    i(2, "type"),
    t({ "} " }),
    i(3, "param"),
    t({ "", " * @returns {" }),
    i(4, "type"),
    t({ "}", "", " */" }),
    i(0)
  }),

  -- docc: Class doc
  s({ trig = "docc", desc = "JSDoc class" }, {
    t({ "/**", " * " }),
    i(1, "Class description"),
    t({ "", " *", " * @class" }),
    i(2, "ClassName"),
    t({ "", " * @author ", " */" }),
    i(0)
  }),

  -- con: Constructor snippet
  s({ trig = "con", desc = "Constructor" }, {
    t("constructor() {"),
    t({ "", "  " }),
    i(1),
    t({ "", "}" }),
    i(0)
  })
})

-- Optional: Auto-reload on save (great for snippet development)
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.lua",
  callback = function()
    local fpath = vim.fn.expand("%:p")
    if string.match(fpath, "snippets") then
      require("luasnip").clear_snippets("all")
      require("snippets.javascript")  -- or loop through all
      print("Snippets reloaded!")
    end
  end
})
