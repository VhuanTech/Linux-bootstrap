
-- Fuzzy finder
return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",        -- Required async library
    "nvim-telescope/telescope-fzf-native.nvim",  -- Optional: Faster filtering
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        -- Show preview, results, and prompt side by side
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          width = 0.87,
          height = 0.80,
        },

        -- Enable prompt reset
        mappings = {
          i = {
            ["<Esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },

        -- Use ripgrep for live grep
        file_ignore_patterns = { "node_modules", ".git/" },
      },

      -- Extensions configuration
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    })

    -- Load FZF native support (optional but faster)
    pcall(telescope.load_extension, "fzf")

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep (search text)" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List open buffers" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help pages" })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent files" })
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Document symbols" })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "Show diagnostics" })
    vim.keymap.set('n', '<leader>fc', builtin.git_status, { desc = "Git status" })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Git branches" })
  end,
}
