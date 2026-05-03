vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		html = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		json = { "jq" },
		go = { "goimports" },
	},
})
