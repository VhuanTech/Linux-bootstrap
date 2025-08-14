-- ~/.config/nvim/lua/plugins/mru.lua
return {
  "vim-scripts/mru.vim",
  -- Optional: map keys in `config`, or do it elsewhere
  config = function()
    -- Optional: Set number of MRU files shown
    vim.g.MRU_Max_Entries = 100

    -- Optional: Map a key to open MRU browser
    vim.keymap.set("n", "<leader>r", "<cmd>MRU<CR>", { desc = "Open MRU files" })
  end,
}
