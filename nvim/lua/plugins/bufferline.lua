return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		lazy = false,
		config = function()
			local status_ok, bufferline = pcall(require, "bufferline")
			if not status_ok then
				return
			end

			bufferline.setup({
				options = {
					-- 显示模式: buffers（所有打开的文件）或 tabs（仅标签页）
					mode = "buffers",

					-- 样式预设（可选 default 或 minimal）
					style_preset = bufferline.style_preset.default,

					-- 是否启用主题高亮（推荐开启以适配配色方案）
					themable = true,

					-- buffer 编号显示方式
					numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both"

					-- 关闭 buffer 的命令（推荐使用 bufdelete 插件）
					close_command = function(bufnr)
						require("bufdelete").bufdelete(bufnr, false)
					end,
					right_mouse_command = function(bufnr)
						require("bufdelete").bufdelete(bufnr, false)
					end,
					left_mouse_command = "buffer %d",
					middle_mouse_command = nil,

					-- 侧边指示符样式
					indicator = {
						style = "underline", -- 'icon' | 'underline' | 'none'
						icon = "▎", -- 仅在 style = 'icon' 时生效
					},

					-- 图标设置（需 Nerd Font 支持）
					buffer_close_icon = "󰅖",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = " ",
					right_trunc_marker = " ",

					-- 最大名称长度 & 截断设置
					max_name_length = 18,
					max_prefix_length = 15,
					truncate_names = true,
					tab_size = 18,

					-- 启用 LSP 诊断信息
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					diagnostics_update_on_event = true,
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or ""
						return icon .. count
					end,

					-- 自定义过滤器：隐藏特定 buffer
					custom_filter = function(buf_number, _)
						-- 过滤终端 buffer
						if vim.bo[buf_number].filetype == "terminal" then
							return false
						end
						-- 可扩展其他规则
						return true
					end,

					-- 偏移区域（如 NvimTree、Outline）
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "left",
							separator = true,
						},
						{
							filetype = "Outline",
							text = "Symbols",
							text_align = "center",
							separator = true,
						},
					},

					-- 图标与颜色
					color_icons = true,
					show_buffer_icons = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					show_tab_indicators = true,
					show_duplicate_prefix = true,
					duplicates_across_groups = true,

					-- 排序与持久化
					persist_buffer_sort = true,
					sort_by = "insert_at_end", -- 文档支持此值

					-- 移动时是否循环
					move_wraps_at_ends = false,

					-- 分隔符风格
					separator_style = "slant", -- 'slant' | 'slope' | 'thick' | 'thin' | { 'x', 'y' }

					-- 正常的 tab 行为
					enforce_regular_tabs = false,

					-- 是否始终显示 tabline
					always_show_bufferline = true,

					-- 是否自动切换 tabline 显示状态
					auto_toggle_bufferline = true,

					-- 悬停效果
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" }, -- 文档中写法是 table，保留原样
					},

					-- 快速选择键
					pick = {
						alphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
					},

					-- 自定义图标获取函数（兼容 nvim-web-devicons）
					get_element_icon = function(element)
						local icon, hl =
							require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
						return icon, hl
					end,
				},

				-- 自定义高亮（可选，适配主题）
				highlights = {
					-- 选中 buffer 加粗
					buffer_selected = {
						bold = true,
						italic = false,
					},
					-- 诊断信息不斜体
					diagnostic_selected = {
						bold = true,
					},
					-- fill = {
					-- 	bg = "#0f1117",
					-- },
					-- background = {
					-- 	bg = "#0f1117",
					-- },
					-- tab_selected = {
					-- 	bg = "#1f232d",
					-- },
				},
			})
		end,
	},
}
