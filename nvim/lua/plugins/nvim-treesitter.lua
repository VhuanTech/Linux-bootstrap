return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python",
        "lua",
        "vim",
        "bash",
        "javascript",
        "typescript",
        "html",
        "css",
        "scss",
        "vue",
        "json",
        "markdown",
        "yaml",
        "c",
        "cpp",
        "java",
        "rust",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<TAB>",
          node_decremental = "<BS>",
        },
      },
      fold = {
        enable = true,
      },
      indent = {
        enable = true
      },
      autotag = {
        enable = true
      },
      context_commentstring = {
        enable = true
      },
    })
  end,
}
