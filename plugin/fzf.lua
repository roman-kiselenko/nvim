vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local actions = require("fzf-lua.actions")
local fzf = require("fzf-lua")
-- --
fzf.setup({
	actions = {
		files = {
			["enter"] = actions.file_edit,
		},
	},
	keymap = {
		fzf = {
			["ctrl-q"] = "select-all+accept",
		},
	},
	buffers = {
		cwd_prompt = false,
		ignore_current_buffer = true,
		prompt = "Buffers: ",
	},
	files = {
		cwd_prompt = false,
		prompt = "Files: ",
		formatter = "path.filename_first",
	},
	grep = {
		cmd = "rg -o -n -r '' --column --no-heading --smart-case",
		prompt = "Text: ",
	},
	lsp = {
		prompt_postfix = ": ",
	},
	defaults = {
		git_icons = false,
	},
	fzf_colors = {
		["bg"] = { "bg", "NormalFloat" },
		["bg+"] = { "bg", "CursorLine" },
		["fg"] = { "fg", "Comment" },
		["fg+"] = { "fg", "Normal" },
		["hl"] = { "fg", "CmpItemAbbrMatch" },
		["hl+"] = { "fg", "CmpItemAbbrMatch" },
		["gutter"] = { "bg", "NormalFloat" },
		["header"] = { "fg", "NonText" },
		["info"] = { "fg", "NonText" },
		["pointer"] = { "bg", "Cursor" },
		["separator"] = { "bg", "NormalFloat" },
		["spinner"] = { "fg", "NonText" },
	},
	fzf_opts = { ["--keep-right"] = "" },
	hls = {
		border = "FloatBorder",
		header_bind = "NonText",
		header_text = "NonText",
		help_normal = "NonText",
		normal = "NormalFloat",
		preview_border = "FloatBorder",
		preview_normal = "NormalFloat",
		search = "CmpItemAbbrMatch",
		title = "FloatTitle",
	},
	winopts = {
		backdrop = 90,
		cursorline = true,
		height = 0.75,
		width = 0.93,
		row = 0.5,
		preview = {
			layout = "horizontal",
			scrollbar = "border",
			vertical = "up:65%",
		},
	},
})

fzf.register_ui_select()
