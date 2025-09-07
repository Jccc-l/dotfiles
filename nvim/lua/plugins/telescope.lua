return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	opts = {
		-- other defaults configuration here
		defaults = {
			-- 排序策略：更好的结果排在前面（"descending"）还是后面（"ascending"）
			sorting_strategy = "descending",

			-- 选择策略：排序后光标行为
			selection_strategy = "reset",

			-- 滚动策略：超出视图时如何处理
			scroll_strategy = "cycle",

			-- 布局策略
			layout_strategy = "horizontal",

			-- 布局配置
			layout_config = {
				bottom_pane = {
					height = 25,
					preview_cutoff = 120,
					prompt_position = "top",
				},
				center = {
					height = 0.4,
					preview_cutoff = 40,
					prompt_position = "top",
					width = 0.5,
				},
				cursor = {
					height = 0.9,
					preview_cutoff = 40,
					width = 0.8,
				},
				horizontal = {
					height = 0.9,
					preview_cutoff = 120,
					prompt_position = "bottom",
					width = 0.8,
				},
				vertical = {
					height = 0.9,
					preview_cutoff = 40,
					prompt_position = "bottom",
					width = 0.8,
				},
			},

			-- 循环布局列表（使用 cycle_layout_next/prev 时）
			cycle_layout_list = { "horizontal", "vertical" },

			-- 浮动窗口透明度（winblend）
			winblend = 0,

			-- 是否对结果进行换行
			wrap_results = false,

			-- 提示符前缀
			prompt_prefix = "> ",

			-- 当前选中项的标记
			selection_caret = "> ",

			-- 非选中项的前缀
			entry_prefix = "  ",

			-- 多选图标（会替换 caret 和 prefix 的最后一个字符）
			multi_icon = "+",

			-- 初始模式：insert 或 normal
			initial_mode = "insert",

			-- 是否显示边框
			border = true,

			-- 路径显示方式（可为表、字符串或函数）
			path_display = {},

			-- 边框字符（8个元素的表）
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

			-- -- 获取状态文本的函数（如 “1/10”）
			-- get_status_text = function(picker)
			-- 	local current = picker:current_result_count()
			-- 	local total = picker:total_result_count()
			-- 	return string.format("%d/%d", current, total)
			-- end,

			-- 是否高亮结果行末尾至窗口右边界
			hl_result_eol = true,

			-- 动态预览标题（如显示完整文件名）
			dynamic_preview_title = false,

			-- 结果窗口标题
			results_title = "Results",

			-- 提示窗口标题
			prompt_title = "Prompt",

			-- 自定义映射
			mappings = {},

			-- 是否使用默认映射（不推荐修改）
			default_mappings = nil,

			-- 历史记录配置
			history = {
				path = vim.fn.stdpath("data") .. "/telescope_history",
				limit = 100,
				handler = require("telescope.actions.history").get_simple_history,
			},

			-- 缓存配置
			cache_picker = {
				num_pickers = 1,
				limit_entries = 1000,
			},

			-- 预览器全局配置
			preview = {
				check_mime_type = not vim.fn.has("win32") == 1, -- Windows 默认 false
				filesize_limit = 25,
				timeout = 250,
				hooks = nil,
				treesitter = true,
				msg_bg_fillchar = "╱",
				hide_on_startup = false,
			},

			-- vimgrep 参数（用于 live_grep / grep_string）
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},

			-- 是否使用 less（已弃用）
			use_less = true,

			-- 终端预览器环境变量
			set_env = nil,

			-- 是否为文件图标着色（需 termguicolors）
			color_devicons = true,

			-- 文件排序器
			file_sorter = require("telescope.sorters").get_fzy_sorter,

			-- 通用排序器（非文件）
			generic_sorter = require("telescope.sorters").get_fzy_sorter,

			-- 预过滤排序器（用于 LSP 符号等）
			prefilter_sorter = require("telescope.sorters").prefilter,

			-- 平局时的排序函数
			tiebreak = function(current_entry, existing_entry, _)
				-- 按 ordinal 长度排序，短者优先
				return #current_entry.ordinal < #existing_entry.ordinal
			end,

			-- 忽略的文件模式（Lua 正则表达式）
			file_ignore_patterns = nil,

			-- 获取选择后打开窗口的函数
			get_selection_window = function()
				return 0
			end,

			-- 文件预览器
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,

			-- grep 预览器
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,

			-- quickfix 列表预览器
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

			-- buffer 预览器生成器
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		},

		pickers = {},
		extensions = {"fidget"},
	},
}
