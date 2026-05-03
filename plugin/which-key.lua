vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim", confirm = false },
})

vim.schedule(function()
	vim.cmd.packadd("which-key.nvim")
	local wk = require("which-key")
	wk.setup({
		delay = 500,
		icons = {
			separator = "→",
			mappings = false,
		},
		layout = { align = "center" },
		triggers = {
			{ "<leader>", mode = { "n", "v" } },
		},
		plugins = {
			spelling = {
				enabled = false,
			},
		},
		preset = "classic",
	})

	vim.api.nvim_set_hl(0, "WhichKeyValue", { link = "NormalFloat" })
	vim.api.nvim_set_hl(0, "WhichKeyDesc", { link = "NormalFloat" })
end)
