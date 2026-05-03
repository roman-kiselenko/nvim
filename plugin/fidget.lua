vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

require("fidget").setup({
	progress = {
		suppress_on_insert = true,
		display = {
			done_ttl = 2,
			done_icon = tools.ui.icons.ok,
			progress_icon = {
				pattern = {
					" 󰫃 ",
					" 󰫄 ",
					" 󰫅 ",
					" 󰫆 ",
					" 󰫇 ",
					" 󰫈 ",
				},
			},
			done_style = "Comment",
			group_style = "Comment",
			icon_style = "Comment",
			progress_style = "Comment",
		},
	},
	notification = {
		window = {
			border_hl = "Comment",
			normal_hl = "Comment",
			winblend = 100,
			border = "solid",
			relative = "win",
		},
	},
})
