-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.g.copilot_enabled = false
vim.cmd("Copilot disable")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype == "markdown" or vim.bo.filetype == "txt" then
      vim.cmd("Copilot disable")
    else
      if vim.g.copilot_enabled then
        vim.cmd("Copilot enable")
      else
        vim.cmd("Copilot disable")
      end
    end
  end,
})

-- I want a variable to track enabled/diabled that defaults to disabled
-- but keeps it's state unless entering a markdown or text buffer
