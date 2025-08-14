-- lua/config/keymaps.lua
vim.keymap.set("n", "s", ":w<CR>", { desc = "Write file" })
vim.keymap.set("n", "<SPACE>", "<C-F>", { desc = "Forward" })
vim.keymap.set("n", ";", "<C-B>", { desc = "Back" })
vim.keymap.set("n", "<leader>,", "<C-W>w", { desc = "Switch between windows" })

vim.keymap.set("n", "zR", "zR", { desc = "Expand all folds" })
vim.keymap.set("n", "zM", "zM", { desc = "Collapse all folds" })

-- ~/.config/nvim/lua/keymaps.lua
local gitsigns = require("gitsigns")

vim.keymap.set("n", "]c", gitsigns.next_hunk, { desc = "Next git hunk" })
vim.keymap.set("n", "[c", gitsigns.prev_hunk, { desc = "Previous git hunk" })

-- Stage / unstage hunks
vim.keymap.set({ "n", "v" }, "<leader>hs", gitsigns.stage_hunk, { desc = "Stage git hunk" })
vim.keymap.set({ "n", "v" }, "<leader>hr", gitsigns.reset_hunk, { desc = "Reset git hunk" })

-- Stage / reset entire buffer
vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage entire buffer" })
vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset entire buffer" })

-- Preview hunk
vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview git hunk" })

-- Blame
vim.keymap.set("n", "<leader>hb", gitsigns.blame_line, { desc = "Git blame (current line)" })

-- Toggle
vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" })
vim.keymap.set("n", "<leader>hd", gitsigns.toggle_deleted, { desc = "Toggle deleted (show removed lines)" })
vim.keymap.set("n", "<leader>ht", gitsigns.toggle_signs, { desc = "Toggle git signs" })

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle file explorer" })


-- Luasnip
local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
