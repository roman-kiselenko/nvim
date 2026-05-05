return {
	-- on_attach = function()
	-- 	print("lua_ls attached")
	-- end,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Add this line
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
}
