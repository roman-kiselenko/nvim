vim.pack.add({ "https://github.com/kevinhwang91/nvim-hlslens" })

require("hlslens").setup({
	calm_down = true,
	enable_incsearch = false,
	override_lens = tools.lens,
})
