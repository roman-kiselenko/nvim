-- Use vim.opt.local to keep settings buffer-specific
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.expandtab = true

-- Example: Map <leader>r to run the current script
vim.keymap.set("n", "<leader>r", ":!bash %<CR>", { buffer = true, desc = "Run shell script" })
