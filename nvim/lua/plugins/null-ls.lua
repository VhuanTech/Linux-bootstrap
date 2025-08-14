-- Formatter & Linter
return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,        -- Python
        null_ls.builtins.formatting.isort,        -- Python imports
        null_ls.builtins.formatting.prettier,     -- JS/TS/Json/Html
        null_ls.builtins.formatting.shfmt,        -- Shell scripts
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.eslint_d,    -- JS/TS
        null_ls.builtins.diagnostics.shellcheck,  -- Shell
        null_ls.builtins.diagnostics.flake8,      -- Python
        null_ls.builtins.code_actions.gitsigns,   -- Git actions
        null_ls.builtins.code_actions.refactoring,-- Refactoring
      },
      -- format on save
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, { buffer = bufnr })
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
