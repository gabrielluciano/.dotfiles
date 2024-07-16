-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Dap
require("which-key").add({
    { "<leader>tR", "<ESC><CMD>lua require('dap').repl.open()<CR>", desc = "View Test Results", mode = "n" },
})
