-- Wait for plugins to sync, then quit Neovim
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      vim.cmd("qa")
    end,
  })
  
  -- Trigger plugin install
  require("lazy").sync()
  