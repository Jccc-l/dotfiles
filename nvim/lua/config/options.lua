local options = {
	number = true,
	relativenumber = true,
	list = true, -- 启用 list 模式，显示由 listchars 定义的字符
	wrap = true,
	linebreak = true,
	hlsearch = false,
	pumheight = 8,
	showmode = false,
	mouse = "a",
	encoding = "utf-8",
	cursorline = true,
	scrolloff = 4,
	sidescrolloff = 10,
	ruler = false,
	laststatus = 1,
	ignorecase = true,
	smartcase = true,
	termguicolors = true, -- optionally enable 24-bit colour
	background = "dark",
	listchars = {
		-- space = " ",
		trail = "·", -- 行尾空白符号显示小点
		eol = "󰌑", -- 行尾显示为否定符号（可选）
		tab = "󰌒 ", -- Tab 显示为三角形后跟一个空格（可选）
	},
}
for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd.filetype("on")
vim.cmd.filetype("plugin on")
vim.cmd.filetype("indent on")
vim.cmd.colorscheme("dracula")
vim.cmd.syntax("on")

vim.api.nvim_set_hl(0, "Normal", { ctermbg = none, guibg = none })
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = none, guibg = none })

-------------------------------------------------
-------------------------------------------------
------------特定文件类型启用拼写检查-------------
-------------------------------------------------
-------------------------------------------------
-- local function enable_spell_for_filetypes()
-- 	local bufnr = vim.api.nvim_get_current_buf()
-- 	local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
-- 	local spell_filetypes = { "markdown", "text", "rst", "latex", "tex", "txt" }
-- 	for _, v in ipairs(spell_filetypes) do
-- 		if ft == v then
-- 			vim.opt_local.spell = true
-- 			vim.opt_local.spelllang = "en_us"
-- 			return
-- 		end
-- 	end
-- 	vim.opt_local.spell = false
-- end

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "*",
-- 	callback = enable_spell_for_filetypes,
-- })
