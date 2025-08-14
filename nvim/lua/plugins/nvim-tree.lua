-- File explorer
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Optional: for file icons
  },
  cmd = { "NvimTreeToggle", "NvimTreeOpen" },
  keys = {
    { "<C-t>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
  },
  config = function()
    local nvim_tree = require("nvim-tree")

    nvim_tree.setup({
      -- Disable window_picker
      disable_netrw = true,
      hijack_netrw = true,
      respect_buf_cwd = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        debounce_delay = 200,
      },
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = false,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        highlight_opened_files = "all",
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", ".cache" },
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
    })
  end,
}
