-- ~/.config/nvim/lua/snippets/python.lua

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", {
  -- docf: Function docstring (Google style)
  s({ trig = "docf", desc = "Function docstring" }, {
    t({ '"""', 'Summary.' }), i(1, "Description"),
    t({ "", "", "Args:" }),
    t({ "    ", }), i(2, "arg1"), t(": "), i(3, "Description of arg1"),
    t({ "", "    ", }), i(4, "arg2"), t(": "), i(5, "Description of arg2"),
    t({ "", "", "Returns:" }),
    t({ "    " }), i(6, "Return value description"),
    t({ "", "", '"""' }), i(0)
  }),

  -- docm: Module docstring
  s({ trig = "docm", desc = "Module docstring" }, {
    t({ '"""', '' }),
    i(1, "Module description"),
    t({ "", "", "Author: ", "" }),
    i(2, "Your Name"),
    t({ "", "Date: ", "" }),
    i(3, "YYYY-MM-DD"),
    t({ "", "", '"""' }), i(0)
  }),

  -- docc: Class docstring
  s({ trig = "docc", desc = "Class docstring" }, {
    t({ '"""', 'Summary.' }), i(1, "Class description"),
    t({ "", "", "Attributes:" }),
    t({ "    ", }), i(2, "attr1"), t(": "), i(3, "Description of attr1"),
    t({ "", "", "Methods:" }),
    t({ "    ", }), i(4, "method1"), t(": "), i(5, "Brief description"),
    t({ "", "", '"""' }), i(0)
  }),

  -- main: if __name__ == "__main__"
  s({ trig = "main", desc = "if __name__ == '__main__'" }, {
    t({ "", "", "if __name__ == '__main__':", "    " }),
    i(1),
    i(0)
  }),

  -- cl: Class definition
  s({ trig = "cl", desc = "Class definition" }, {
    t("class "), i(1, "ClassName"), t("("), i(2, "object"), t({ "):", "    " }),
    t('"""'), i(3, "Class docstring"),
    t('"""'), t({ "", "" }),
    t("    def __init__(self"), t(", "), i(4), t({ "):", "        " }),
    t("pass"), i(0)
  }),

  -- def: Function definition
  s({ trig = "def", desc = "Function definition" }, {
    t("def "), i(1, "function_name"), t("("), i(2, "self"), t(", "), i(3), t({ "):", "    " }),
    t('"""'), i(4, "Docstring"),
    t('"""'), t({ "", "    " }),
    i(5, "pass"),
    i(0)
  }),

  -- test: pytest function
  s({ trig = "test", desc = "Pytest test function" }, {
    t("def test_"), i(1, "something"), t({ "():", "    " }),
    t("assert "), i(2), t(" == "), i(3), i(0)
  }),

  -- for: for loop
  s({ trig = "for", desc = "for loop" }, {
    t("for "), i(1, "item"), t(" in "), i(2, "items"), t({ ":", "    " }),
    i(3, "pass"),
    i(0)
  }),

  -- try: try-except
  s({ trig = "try", desc = "try-except block" }, {
    t({ "try:", "    " }),
    i(1),
    t({ "", "except ", " as e:", "    " }),
    i(2, "print(e)"),
    i(0)
  }),

  -- with: context manager
  s({ trig = "with", desc = "with statement" }, {
    t("with "), i(1, "open('file.txt') as f"), t({ ":", "    " }),
    i(2),
    i(0)
  })
})
