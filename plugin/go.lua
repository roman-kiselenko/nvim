vim.pack.add({
	"https://github.com/ray-x/go.nvim",
	"https://github.com/ray-x/guihua.lua",
})

require("go").setup({
	goimports = "gopls",
	gofmt = "gofumpt",
})
