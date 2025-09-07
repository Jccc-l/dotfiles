return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below

		---@type false | "classic" | "modern" | "helix"
		preset = "classic",
		-- Delay before showing the popup. Can be a number or a function that returns a number.
		---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
		delay = function(ctx)
			return ctx.plugin and 0 or 200
		end,
		---@param mapping wk.Mapping
		filter = function(mapping)
			-- example to exclude mappings without a description
			-- return mapping.desc and mapping.desc ~= ""
			return true
		end,
		--- You can add any mappings here, or use `require('which-key').add()` later
		---@type wk.Spec
		spec = {},
		-- show a warning when issues were detected with your mappings
		notify = true,
		-- Which-key automatically sets up triggers for your mappings.
		-- But you can disable this and setup the triggers manually.
		-- Check the docs for more info.
		---@type wk.Spec
		triggers = {
			{ "<auto>", mode = "nxso" },
		},
		-- Start hidden and wait for a key to be pressed before showing the popup
		-- Only used by enabled xo mapping modes.
		---@param ctx { mode: string, operator: string }
		defer = function(ctx)
			return ctx.mode == "V" or ctx.mode == "<C-V>"
		end,
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			presets = {
				operators = true, -- adds help for operators like d, y, ...
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		---@type wk.Win.opts
		win = {
			-- don't allow the popup to overlap with the cursor
			no_overlap = true,
			-- width = 1,
			-- height = { min = 4, max = 25 },
			-- col = 0,
			-- row = math.huge,
			-- border = "none",
			padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
			title = true,
			title_pos = "center",
			zindex = 1000,
			-- Additional vim.wo and vim.bo options
			bo = {},
			wo = {
				-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			},
		},
		layout = {
			width = { min = 20 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
		},
		keys = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		---@type (string|wk.Sorter)[]
		--- Mappings are sorted using configured sorters and natural sort of the keys
		--- Available sorters:
		--- * local: buffer-local mappings first
		--- * order: order of the items (Used by plugins like marks / registers)
		--- * group: groups last
		--- * alphanum: alpha-numerical first
		--- * mod: special modifier keys last
		--- * manual: the order the mappings were added
		--- * case: lower-case first
		sort = { "local", "order", "group", "alphanum", "mod" },
		---@type number|fun(node: wk.Node):boolean?
		expand = 0, -- expand groups when <= n mappings
		-- expand = function(node)
		--   return not node.desc -- expand all nodes without a description
		-- end,
		-- Functions/Lua Patterns for formatting the labels
		---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
		replace = {
			key = {
				function(key)
					return require("which-key.view").format(key)
				end,
				-- { "<Space>", "SPC" },
			},
			desc = {
				{ "<Plug>%(?(.*)%)?", "%1" },
				{ "^%+", "" },
				{ "<[cC]md>", "" },
				{ "<[cC][rR]>", "" },
				{ "<[sS]ilent>", "" },
				{ "^lua%s+", "" },
				{ "^call%s+", "" },
				{ "^:%s*", "" },
			},
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
			ellipsis = "…",
			-- set to false to disable all mapping icons,
			-- both those explicitly added in a mapping
			-- and those from rules
			mappings = true,
			--- See `lua/which-key/icons.lua` for more details
			--- Set to `false` to disable keymap icons from rules
			---@type wk.IconRule[]|false
			rules = {},
			-- use the highlights from mini.icons
			-- When `false`, it will use `WhichKeyIcon` instead
			colors = true,
			-- used by key format
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "󰘴 ",
				M = "󰘵 ",
				D = "󰘳 ",
				S = "󰘶 ",
				CR = "󰌑 ",
				Esc = "󱊷 ",
				ScrollWheelDown = "󱕐 ",
				ScrollWheelUp = "󱕑 ",
				NL = "󰌑 ",
				BS = "󰁮",
				Space = "󱁐 ",
				Tab = "󰌒 ",
				F1 = "󱊫",
				F2 = "󱊬",
				F3 = "󱊭",
				F4 = "󱊮",
				F5 = "󱊯",
				F6 = "󱊰",
				F7 = "󱊱",
				F8 = "󱊲",
				F9 = "󱊳",
				F10 = "󱊴",
				F11 = "󱊵",
				F12 = "󱊶",
			},
		},
		show_help = true, -- show a help message in the command line for using WhichKey
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		-- disable WhichKey for certain buf types and file types.
		disable = {
			ft = {},
			bt = {},
		},
		debug = false, -- enable wk.log in the current directory
	},
	keys = {},
	config = function()
		require("which-key").add({
			---------
			-- DAP --
			---------
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step Out",
			},

			{ "<leader>d", desc = "DAP Command" },
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint()
				end,
				desc = "Set Breakpoint",
			},
			{
				"<leader>dP",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "Log Point",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "REPL Open",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				mode = { "n", "v" },
				desc = "Hover Variables",
			},
			{
				"<leader>dp",
				function()
					require("dap.ui.widgets").preview()
				end,
				mode = { "n", "v" },
				desc = "Preview Value",
			},
			{
				"<leader>df",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.frames)
				end,
				desc = "Frames (Float)",
			},
			{
				"<leader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end,
				desc = "Scopes (Float)",
			},

			------------
			-- DAP UI --
			------------

			{ "<leader>du", group = "DAP UI", desc = "DAP UI" },
			{
				"<leader>dut",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
			{
				"<leader>duc",
				function()
					require("dapui").close()
				end,
				desc = "Close DAP UI",
			},
			{
				"<leader>duo",
				function()
					require("dapui").open()
				end,
				desc = "Open DAP UI",
			},

			--------------
			-- Exlporer --
			--------------

			{ "<leader>e", require("nvim-tree.api").tree.toggle, desc = "Exlporer" },

			-------------
			-- Outline --
			-------------

			{ "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Outline" },

			---------------
			-- Translate --
			---------------

			{ "<leader>t", "<cmd>TranslateW!<CR>", desc = "Translator" },

			------------
			-- Format --
			------------

			{ "<M-f>", group = "Format" },
			{ "<M-f><M-f>", "<cmd>FormatLock<cr>", desc = "Format Lock" },
			{ "<M-f><M-w>", "<cmd>FormatWriteLock<cr>", desc = "FormatWrite Lock" },
			--------------
			-- markdown --
			--------------

			{ "<leader>m", desc = "Markdown" },
			{ "<leader>mm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
			{
				"<leader>mr",
				function()
					require("render-markdown").toggle()
				end,
				desc = "Render Markdown toggle",
			},

			--------------
			-- Drop Bar --
			--------------

			{ "<Leader>;", desc = "Drop Bar" },
			{
				"<Leader>;;",
				function()
					require("dropbar.api").goto_context_start()
				end,
				desc = "Pick symbols in winbar",
			},
			{
				"<leader>;[",
				function()
					require("dropbar.api").goto_context_start()
				end,
				desc = "Go to start of current context",
			},
			{
				"<leader>;]",
				function()
					require("dropbar.api").select_next_context()
				end,
				desc = "Select next context",
			},

			------------------------
			-- cellular-automaton --
			------------------------

			{ "<leader>car", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Cellular Automation Rain" },
			{ "<leader>cag", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Cellular Automation Game of Life" },

			---------------
			-- Telescope --
			---------------

			{
				"<leader>f",
				desc = "Telescope",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files() -- require("telescope.themes").get_dropdown())
				end,
				desc = "Telescope find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep(require("telescope.themes").get_ivy({
						layout_config = {
							height = 0.3,
						},
					}))
				end,
				desc = "Telescope live grep",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
						layout_config = {
							width = 0.5,
						},
					}))
				end,
				desc = "Telescope buffers",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags(require("telescope.themes").get_ivy({
						layout_config = {
							height = 0.3,
						},
					}))
				end,
				desc = "Telescope help tags",
			},
			{
				"<leader>?",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},

			-------------
			-- Trouble --
			-------------

			{
				"<leader>x",
				desc = "Trouble",
			},
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},

			{ "<M-j>", "5j", mode = { "n", "v" } },
			{ "<M-k>", "5k", mode = { "n", "v" } },
			{ "<M-h>", "5h", mode = { "n", "v" } },
			{ "<M-l>", "5l", mode = { "n", "v" } },

			----------
			-- Yazi --
			----------
			{
				"<leader>y",
				desc = "Yazi",
			},
			{
				"<leader>yy",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>yc",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<leader>yt",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		})
	end,
}
