return {
	"neovim/nvim-lspconfig",
	config = function()
		-- 自定义高亮组（可选）
		-- vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = "#3c0000", italic = true })

		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				-- 只显示错误和警告（可选）
				-- severity = vim.diagnostic.severity.WARN,

				-- 提高优先级
				priority = 20,

				-- 自定义图标
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},

				-- 高亮行号（默认已有，可覆盖）
				numhl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				},

				-- 高亮整行（可选，较激进）
				linehl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
				},
			},
			update_in_insert = false,
			underline = true,
			severity_sort = true,
		})
	end,
}
