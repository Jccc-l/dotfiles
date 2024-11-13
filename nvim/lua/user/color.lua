local M = {}

M.colors = {
	background = "#282a36",
	current_line = "#44475a",
	selection = "#44475a",
	foreground = "#f8f8f2",
	comment = "#6272a4",
	cyan = "#8be9fd",
	green = "#50fa7b",
	orange = "#ffb86c",
	pink = "#ff79c6",
	purple = "#bd93f9",
	red = "#ff5555",
	yellow = "#f1fa8c",
}

M.highlights = {
	Normal = { fg = M.colors.foreground, bg = M.colors.background },
	CursorLine = { bg = M.colors.current_line },
	Visual = { bg = M.colors.selection },
	Comment = { fg = M.colors.comment, italic = true },
	Constant = { fg = M.colors.purple },
	String = { fg = M.colors.green },
	Character = { fg = M.colors.orange },
	Number = { fg = M.colors.pink },
	Boolean = { fg = M.colors.pink },
	Float = { fg = M.colors.pink },
	Identifier = { fg = M.colors.yellow },
	Function = { fg = M.colors.cyan, bold = true },
	Statement = { fg = M.colors.red },
	Conditional = { fg = M.colors.red },
	Repeat = { fg = M.colors.red },
	Label = { fg = M.colors.red },
	Operator = { fg = M.colors.red },
	Keyword = { fg = M.colors.red },
	Exception = { fg = M.colors.red },
	PreProc = { fg = M.colors.purple },
	Include = { fg = M.colors.purple },
	Define = { fg = M.colors.purple },
	Macro = { fg = M.colors.purple },
	PreCondit = { fg = M.colors.purple },
	Type = { fg = M.colors.cyan },
	StorageClass = { fg = M.colors.cyan },
	Structure = { fg = M.colors.cyan },
	Typedef = { fg = M.colors.cyan },
	Special = { fg = M.colors.orange },
	SpecialChar = { fg = M.colors.orange },
	Tag = { fg = M.colors.orange },
	Delimiter = { fg = M.colors.foreground },
	SpecialComment = { fg = M.colors.comment, italic = true },
	Debug = { fg = M.colors.red },
	Underlined = { underline = true },
	Ignore = { fg = M.colors.background },
	Error = { fg = M.colors.red, bold = true },
	Todo = { fg = M.colors.yellow, bold = true },
}

function M.setup()
	for group, hl in pairs(M.highlights) do
		vim.api.nvim_set_hl(0, group, hl)
	end
end

return M
