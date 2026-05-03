vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
  attach_to_untracked = false,
  preview_config = {
    border = "solid",
    row = 1,
    col = 1,
  },
  signcolumn = true,
  signs = {
    change = { text = " ┋" },
  },
  signs_staged = {
    change = { text = " ┋" },
  },
  update_debounce = 500,
})

