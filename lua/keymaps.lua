vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>gl", "<CMD>GoLint<CR>", { desc = "Run golangci-lint" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>F", "<cmd>FzfLua live_grep<cr>", { desc = "Grep" })
vim.keymap.set("n", "<leader>df", "<cmd>FzfLua lsp_definitions<cr>", { silent = true, desc = "LSP [d]e[f]initions" })
vim.keymap.set(
	"n",
	"<leader>dd",
	"<cmd>FzfLua lsp_document_diagnostics<cr>",
	{ silent = true, desc = "LSP [d]oc [d]iagnostics" }
)
vim.keymap.set("n", "<leader>R", "<cmd>FzfLua lsp_references<cr>", { silent = true, desc = "LSP [R]eferences" })
vim.keymap.set(
	"n",
	"<leader>ci",
	"<cmd>FzfLua lsp_incoming_calls<cr>",
	{ silent = true, desc = "LSP [i]ncoming [c]alls" }
)
vim.keymap.set(
	"n",
	"<leader>co",
	"<cmd>FzfLua lsp_outgoing_calls<cr>",
	{ silent = true, desc = "LSP [o]utgoing [c]alls" }
)
