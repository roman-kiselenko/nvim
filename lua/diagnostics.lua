local S = vim.diagnostic.severity
local icons = tools.ui.icons

vim.diagnostic.config({
	underline = false,
	severity_sort = true,
	signs = {
		text = {
			[S.ERROR] = icons.error,
			[S.HINT] = icons.info,
			[S.INFO] = icons.info,
			[S.WARN] = icons.warning,
		},
	},
	virtual_text = true, -- show inline diagnostics
})
