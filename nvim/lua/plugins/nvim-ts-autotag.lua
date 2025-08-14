-- Automatically close tags in Vue/HTML
return {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy",
  ft = { "html", "vue", "jsx", "tsx" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
