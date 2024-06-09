vim.api.nvim_create_autocmd("VimEnter", {
    command = "Neotree position=float toggle",
})
vim.keymap.set("n", "<leader>pv", "<Cmd>Neotree position=float<CR>")

