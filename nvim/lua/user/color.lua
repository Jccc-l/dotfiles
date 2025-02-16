local themes = {
	dracula = {
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
	},
	monokai = {
		background = "#272822",
		current_line = "#3e3d32",
		selection = "#3e3d32",
		foreground = "#f8f8f2",
		comment = "#75715e",
		cyan = "#a1efe4",
		green = "#a6e22e",
		orange = "#fd971f",
		pink = "#f92672",
		purple = "#ae81ff",
		red = "#f92672",
		yellow = "#e6db74",
	},
	snazzy = {
		background = "#282a36",
		current_line = "#44475a",
		selection = "#44475a",
		foreground = "#f1f1f0",
		comment = "#5e6c70",
		cyan = "#9aedfe",
		green = "#5af78e",
		orange = "#f3f99d",
		pink = "#ff6ac1",
		purple = "#ff6ac1",
		red = "#ff5c57",
		yellow = "#f3f99d",
	},
	-- 可以继续添加更多的主题
}

-- 定义高亮函数
local function highlight(group, fg, bg, sp, attr, theme)
	local style = {}
	if attr then
		for _, v in ipairs(attr) do
			table.insert(style, v)
		end
	end
	vim.api.nvim_set_hl(0, group, {
		fg = fg or (type(fg) == "string" and theme[fg]) or nil,
		bg = bg or (type(bg) == "string" and theme[bg]) or nil,
		sp = sp or (type(sp) == "string" and theme[sp]) or nil,
		bold = table.concat(style, " "):match("bold") ~= nil,
		italic = table.concat(style, " "):match("italic") ~= nil,
		strikethrough = table.concat(style, " "):match("strikethrough") ~= nil,
		underline = table.concat(style, " "):match("underline") ~= nil,
		undercurl = table.concat(style, " "):match("undercurl") ~= nil,
		reverse = table.concat(style, " "):match("reverse") ~= nil,
	})
end

-- 应用颜色到高亮组
local function apply_theme(theme)
	-- 应用颜色到高亮组
	highlight("Boolean", theme.orange, nil, nil, nil, theme)
	highlight("Character", theme.orange, nil, nil, nil, theme)
	highlight("Comment", theme.comment, nil, nil, { "italic" }, theme)
	highlight("Conditional", theme.purple, nil, nil, nil, theme)
	highlight("Constant", theme.purple, nil, nil, nil, theme)
	highlight("Cursor", "#ffffff", nil, nil, nil, theme)
	highlight("CursorIM", "#ffffff", nil, nil, nil, theme)
	highlight("CursorLine", nil, theme.current_line, nil, nil, theme)
	highlight("CursorLineNr", theme.pink, nil, nil, nil, theme)
	highlight("Debug", theme.red, nil, nil, nil, theme)
	highlight("Define", theme.pink, nil, nil, nil, theme)
	highlight("Delimiter", theme.foreground, nil, nil, nil, theme)
	highlight("Error", theme.red, nil, nil, { "strikethrough" }, theme)
	highlight("Exception", theme.purple, nil, nil, nil, theme)
	highlight("Float", theme.orange, nil, nil, nil, theme)
	highlight("Function", theme.cyan, nil, nil, nil, theme)
	highlight("Identifier", theme.pink, nil, nil, nil, theme)
	highlight("Include", theme.pink, nil, nil, nil, theme)
	highlight("Keyword", theme.purple, nil, nil, nil, theme)
	highlight("Label", theme.purple, nil, nil, nil, theme)
	highlight("LineNr", theme.comment, nil, nil, nil, theme)
	highlight("Macro", theme.pink, nil, nil, nil, theme)
	highlight("MatchParen", theme.purple, nil, nil, { "underline" }, theme)
	highlight("Normal", theme.foreground, theme.background, nil, nil, theme)
	highlight("Number", theme.orange, nil, nil, nil, theme)
	highlight("Operator", theme.pink, nil, nil, nil, theme)
	highlight("PreCondit", theme.pink, nil, nil, nil, theme)
	highlight("PreProc", theme.pink, nil, nil, nil, theme)
	highlight("Repeat", theme.purple, nil, nil, nil, theme)
	highlight("Search", theme.orange, theme.current_line, nil, { "reverse" }, theme)
	highlight("Special", theme.orange, nil, nil, nil, theme)
	highlight("SpecialChar", theme.orange, nil, nil, nil, theme)
	highlight("SpecialComment", theme.comment, nil, nil, nil, theme)
	highlight("SpellBad", theme.comment, nil, theme.red, { "undercurl" }, theme)
	highlight("Statement", theme.purple, nil, nil, nil, theme)
	highlight("StatusLine", nil, theme.current_line, nil, nil, theme)
	highlight("StatusLineNC", nil, theme.background, nil, nil, theme)
	highlight("StorageClass", theme.pink, nil, nil, nil, theme)
	highlight("String", theme.green, nil, nil, nil, theme)
	highlight("Structure", theme.pink, nil, nil, nil, theme)
	highlight("Tag", theme.pink, nil, nil, nil, theme)
	highlight("Todo", nil, nil, nil, { "reverse" }, theme)
	highlight("Type", theme.yellow, nil, nil, nil, theme)
	highlight("Typedef", theme.pink, nil, nil, nil, theme)
	highlight("Visual", nil, theme.selection, nil, nil, theme)
end

-- 切换主题
local function set_theme(name)
	local theme = themes[name]
	if theme then
		apply_theme(theme)
	else
		print("Theme not found: " .. name)
	end
end

-- 初始化时应用默认主题
set_theme("snazzy")
