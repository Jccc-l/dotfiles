-- 设置默认缩进
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- 为特定文件类型设置缩进
vim.api.nvim_create_augroup("CustomIndent", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "CustomIndent",
	pattern = { "python", "javascript", "typescript", "markdown" },
	callback = function()
		vim.opt.tabstop = 4
		vim.opt.softtabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.expandtab = true
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "CustomIndent",
	pattern = { "cpp", "c", "java" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.expandtab = true
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "CustomIndent",
	pattern = { "go", "lua" },
	callback = function()
		vim.opt.tabstop = 4
		vim.opt.softtabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.expandtab = false
	end,
})
