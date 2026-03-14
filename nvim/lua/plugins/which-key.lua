return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {},
	config = function()
		require("which-key").add({
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
			{
				"<leader>e",
				function()
					vim.cmd([[NvimTreeToggle]])
				end,
				desc = "File Explorer",
			},
			{
				"<leader>q",
				function()
					require("utils.close-smart").smart_close()
				end,
				desc = "Smart Close Window / Quit Neovim",
			},
			{
				"<A-S-F>",
				function()
					vim.cmd([[Format]])
				end,
				desc = "Format",
			},
			{
				"<ESC>",
				function()
					vim.cmd([[nohlsearch]])
				end,
			},

			{ "<leader>d", group = "DAP" },
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Debug Continue",
			},
			{
				"<leader>dsi",
				function()
					require("dap").step_into()
				end,
				desc = "Debug Step Into",
			},
			{
				"<leader>dso",
				function()
					require("dap").step_over()
				end,
				desc = "Debug Step Over",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
			{ "<leader>x", group = "Trouble" },

			{ "<M-h>", "5h" },
			{ "<M-j>", "5j" },
			{ "<M-k>", "5k" },
			{ "<M-l>", "5l" },
		})
	end,
}
