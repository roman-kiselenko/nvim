vim.pack.add({ "https://github.com/echasnovski/mini.icons" })

require("mini.icons").setup((function()
	local mini = require("mini.icons")

	local make_icon_tbl = function(category)
		local res = {}
		local postfix = "  "

		for _, name in ipairs(mini.list(category)) do
			res[name] = { glyph = " " .. mini.get(category, name) .. postfix }
		end

		return res
	end

	local default_icon = { glyph = "   " }

	local defaults = make_icon_tbl("default")
	defaults.extension = default_icon
	defaults.file = default_icon
	defaults.filetype = default_icon

	local file_icons = make_icon_tbl("file")
	file_icons[".zshrc"] = { glyph = " 󰒓  " }
	file_icons["init.lua"] = { glyph = " 󰢱  ", hl = "MiniIconsAzure" }
	file_icons["README.md"] = { glyph = "   ", hl = "MiniIconsCyan" }

	local ft_icons = make_icon_tbl("filetype")
	ft_icons.dosini = default_icon
	ft_icons.text = default_icon

	return {
		default = defaults,
		directory = make_icon_tbl("directory"),
		extension = make_icon_tbl("extension"),
		file = file_icons,
		filetype = ft_icons,
		lsp = make_icon_tbl("lsp"),
	}
end)())
