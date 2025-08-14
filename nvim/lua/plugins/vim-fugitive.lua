-- Git
return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G" },
  keys = {
    { "<leader>gs", ":Gstatus<cr>", desc = "Git Status" },
    { "<leader>gb", ":Gblame<cr>", desc = "Git Blame" },
    { "<leader>gd", ":Gdiffsplit<cr>", desc = "Diffsplit" },
    { "<leader>gc", ":Git commit<cr>", desc = "Git Commit" },
    { "<leader>gw", ":Gwrite<cr>", desc = "Git Write (save to index)" },
  },
}
