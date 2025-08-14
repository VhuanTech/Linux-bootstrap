-- Virtualenv
return {
  "microsoft/python-type-stubs",
  "AckslD/swenv.nvim",
  ft = "pyton",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set("n", "<leader>ve", "<cmd>SWEnvSelect<CR>", { desc = "Select Python Env" })
    vim.keymap.set("n", "<leader>va", "<cmd>SWEnvAuto<CR>", { desc = "Auto-select Env" })
  end,
}
