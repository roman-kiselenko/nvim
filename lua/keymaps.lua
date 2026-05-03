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

vim.api.nvim_set_keymap("n", "<leader>t", ":ToggleTerm<CR>", { silent = true })
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- disable arrows
vim.keymap.set("n", "<up>", "")
vim.keymap.set("n", "<down>", "")
vim.keymap.set("n", "<left>", "")
vim.keymap.set("n", "<right>", "")
vim.keymap.set("i", "<up>", "")
vim.keymap.set("i", "<down>", "")
vim.keymap.set("i", "<left>", "")
vim.keymap.set("i", "<right>", "")
