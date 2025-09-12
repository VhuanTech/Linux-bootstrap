-- ~/.config/nvim/lua/plugins/nvim-ts-autotag.lua
return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter", -- only load when typing (optimized)
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup({
      enable = true,
      enable_close = true,      -- add close tag when typing `</`
      enable_final_close = true, -- close self-closing tags with `/>`
      enable_open = true,       -- add open tag when typing `<div>`
      ignore = {               -- disable where not needed
        "markdown",
        "text",
      },
      -- Optional: custom filetypes (if using non-standard extensions)
      filetypes = {
        html = { "html", "xml", "svg" },
        javascript = { "javascript", "typescript", "tsx", "jsx" },
        svelte = { "svelte" },
        vue = { "vue" },
      },
    })
  end,
}
