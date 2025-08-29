return {
	{
		"voldikss/vim-translator",
		config = function()
			-- Translator.nvim Lua 配置
			vim.g.translator_target_lang = "zh"
			vim.g.translator_source_lang = "auto"

			-- 根据目标语言设置默认引擎
			if vim.g.translator_target_lang == "zh" then
				vim.g.translator_default_engines = { "bing", "haici", "youdao" } -- "google",
			else
				vim.g.translator_default_engines = { "youdao" } -- "google"
			end

			vim.g.translator_proxy_url = ""

			-- 启用翻译历史
			vim.g.translator_history_enable = false

			-- 翻译窗口类型: 'popup' 或 'preview'
			vim.g.translator_window_type = "popup"

			-- 窗口最大宽度（相对屏幕宽度的 60%）
			vim.g.translator_window_max_width = 0.6

			-- 窗口最大高度（相对屏幕高度的 60%）
			vim.g.translator_window_max_height = 0.6

			-- 浮动窗口边框字符
			vim.g.translator_window_borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
		end,
	},
}
