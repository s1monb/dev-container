return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    enable = true,
    config = function()
      require("bufferline").setup({})
    end,
  },
}
