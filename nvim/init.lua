-- ~/.config/nvim/init.lua

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function() vim.lsp.buf.format() end,
})

-- Load lazy.nvim and your plugins
require("config.options")
require("lazy").setup("plugins")
require("config.keymaps")
-- Load custom Lua snippets
require("snippets.javascript")
require("snippets.python")
