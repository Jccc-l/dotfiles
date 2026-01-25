return {

	-----------
	-- mason --
	-----------

	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				---@since 1.0.0
				-- The directory in which to install packages.
				-- install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },

				---@since 1.0.0
				-- Where Mason should put its bin location in your PATH. Can be one of:
				-- - "prepend" (default, Mason's bin location is put first in PATH)
				-- - "append" (Mason's bin location is put at the end of PATH)
				-- - "skip" (doesn't modify PATH)
				---@type '"prepend"' | '"append"' | '"skip"'
				PATH = "prepend",

				---@since 1.0.0
				-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
				-- debugging issues with package installations.
				log_level = vim.log.levels.INFO,

				---@since 1.0.0
				-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
				-- packages that are requested to be installed will be put in a queue.
				max_concurrent_installers = 4,

				---@since 1.0.0
				-- [Advanced setting]
				-- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
				-- multiple registries, the registry listed first will be used.
				registries = {
					"github:mason-org/mason-registry",
				},

				---@since 1.0.0
				-- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
				-- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
				-- Builtin providers are:
				--   - mason.providers.registry-api  - uses the https://api.mason-registry.dev API
				--   - mason.providers.client        - uses only client-side tooling to resolve metadata
				providers = {
					"mason.providers.registry-api",
					"mason.providers.client",
				},

				github = {
					---@since 1.0.0
					-- The template URL to use when downloading assets from GitHub.
					-- The placeholders are the following (in order):
					-- 1. The repository (e.g. "rust-lang/rust-analyzer")
					-- 2. The release version (e.g. "v0.3.0")
					-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
					download_url_template = "https://github.com/%s/releases/download/%s/%s",
				},

				pip = {
					---@since 1.0.0
					-- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
					upgrade_pip = false,

					---@since 1.0.0
					-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
					-- and is not recommended.
					--
					-- Example: { "--proxy", "https://proxyserver" }
					install_args = {},
				},

				ui = {
					---@since 1.0.0
					-- Whether to automatically check for new versions when opening the :Mason window.
					check_outdated_packages_on_open = true,

					---@since 1.0.0
					-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
					-- Defaults to `:h 'winborder'` if nil.
					border = nil,

					---@since 1.11.0
					-- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
					backdrop = 60,

					---@since 1.0.0
					-- Width of the window. Accepts:
					-- - Integer greater than 1 for fixed width.
					-- - Float in the range of 0-1 for a percentage of screen width.
					width = 0.8,

					---@since 1.0.0
					-- Height of the window. Accepts:
					-- - Integer greater than 1 for fixed height.
					-- - Float in the range of 0-1 for a percentage of screen height.
					height = 0.9,

					icons = {
						---@since 1.0.0
						-- The list icon to use for installed packages.
						package_installed = "◍",
						---@since 1.0.0
						-- The list icon to use for packages that are installing, or queued for installation.
						package_pending = "◍",
						---@since 1.0.0
						-- The list icon to use for packages that are not installed.
						package_uninstalled = "◍",
					},

					keymaps = {
						---@since 1.0.0
						-- Keymap to expand a package
						toggle_package_expand = "<CR>",
						---@since 1.0.0
						-- Keymap to install the package under the current cursor position
						install_package = "i",
						---@since 1.0.0
						-- Keymap to reinstall/update the package under the current cursor position
						update_package = "u",
						---@since 1.0.0
						-- Keymap to check for new version for the package under the current cursor position
						check_package_version = "c",
						---@since 1.0.0
						-- Keymap to update all installed packages
						update_all_packages = "U",
						---@since 1.0.0
						-- Keymap to check which installed packages are outdated
						check_outdated_packages = "C",
						---@since 1.0.0
						-- Keymap to uninstall a package
						uninstall_package = "X",
						---@since 1.0.0
						-- Keymap to cancel a package installation
						cancel_installation = "<C-c>",
						---@since 1.0.0
						-- Keymap to apply language filter
						apply_language_filter = "<C-f>",
						---@since 1.1.0
						-- Keymap to toggle viewing package installation log
						toggle_package_install_log = "<CR>",
						---@since 1.8.0
						-- Keymap to toggle the help view
						toggle_help = "g?",
					},
				},
			})
		end,
	},

	---------------
	-- lspconfig --
	---------------

	{
		"neovim/nvim-lspconfig",
		lazy = true,
		init = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig").util.default_config.capabilities = capabilities
			require("lspconfig").util.default_config.on_attach = function(client, bufnr) end
		end,
	},

	---------------------
	-- mason-lspconfig --
	---------------------

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {},
		opts = {
			automatic_enable = {
				"lua_ls",
				"vimls",
				"pyright",
				"clangd",
				"jdtls",
				"vimls",
			},
			ensure_installed = {
				"lua_ls",
				"vimls",
				"pyright",
				"clangd",
				"jdtls",
				"vimls",
			},
		},
	},

	-----------
	-- blink --
	-----------

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				-- set to 'none' to disable the 'default' preset
				preset = "default",

				["<M-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "select_and_accept", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback_to_mappings" },
				["<C-j>"] = { "select_next", "fallback_to_mappings" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<C-S-k>"] = { "show_signature", "hide_signature", "fallback" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
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
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
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
		},
	},
}
