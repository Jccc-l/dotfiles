return {
	"hrsh7th/nvim-cmp",
	config = function()
		-- Set up nvim-cmp.
		local cmp = require("cmp")
		local kind_icons = {
			Text = "",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰇽",
			Variable = "󰂡",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "󰅲",
		}

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					-- For `mini.snippets` users:
					-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
					-- insert({ body = args.body }) -- Insert at cursor
					-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
					-- require("cmp.config").set_onetime({ sources = {} })
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			completion = {
				-- keyword_length = 2,
				--autocomplete=false;
				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-S-k>"] = cmp.mapping.scroll_docs(-2),
				["<C-S-j>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if require("luasnip").expandable() then
							require("luasnip").expand()
						else
							cmp.confirm({
								select = true,
							})
						end
					else
						fallback()
					end
				end),
				["<Tab>"] = cmp.mapping(function(fallback)
					-- 1. 如果补全菜单可见
					if cmp.visible() then
						local entry_count = #cmp.get_entries()
						if entry_count == 1 then
							cmp.confirm({ select = true })
						else
							cmp.select_next_item()
						end

						-- 2. 如果在 snippet 可跳转位置，跳转 snippet
					elseif require("luasnip").locally_jumpable(1) then
						require("luasnip").jump(1)

						-- 3. 如果光标前有输入内容，尝试触发补全
						-- elseif has_words_before() then
						-- 	require("cmp").complete()
						-- 小技巧：触发后立即检查是否只有一项，可立即确认（可选）
						-- 注意：这里不能立刻获取 entry，因为 complete 是异步的
						-- 所以我们不在这一步 confirm，让用户再按一次 Tab 来确认

						-- 4. 否则 fallback（比如插入 Tab 字符）
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").locally_jumpable(-1) then
						require("luasnip").jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				-- 出现补全
				["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				-- 取消
				["<A-,>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				-- { name = "vsnip" }, -- For vsnip users.
				{ name = "luasnip" }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
				{ name = "buffer" },
				{ name = "path" },
				{ name = "spell" },
				{ name = "latex_symbols" },
				{ name = "lazydev", group_index = 0 },
				{ name = "render-markdown" },
			}),
			view = {
				-- entries = { name = "custom", selection_order = "near_cursor" },
			},
			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol",
					menu = {
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[Latex]",
						lazydev = "[LazyDev]",
					},
				}),
			},
		})

		-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
		-- Set configuration for specific filetype.
		--[[ cmp.setup.filetype('gitcommit', {
		  sources = cmp.config.sources({
		    { name = 'git' },
		  }, {
		    { name = 'buffer' },
		  })
		)
		equire("cmp_git").setup() ]]
		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
			view = {
				-- entries = { name = "custom", selection_order = "near_cursor" },
				entries = { name = "wildmenu", separator = "|" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
			entries = { name = "wildmenu", separator = "|" },
		})

		-- Set up lspconfig.
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
		require("lspconfig")["clangd"].setup({
			capabilities = capabilities,
		})
		require("lspconfig")["marksman"].setup({
			capabilities = capabilities,
		})
		require("lspconfig")["lua_ls"].setup({
			capabilities = capabilities,
		})
		require("lspconfig")["pylsp"].setup({
			capabilities = capabilities,
		})
		require("lspconfig")["jdtls"].setup({
			capabilities = capabilities,
		})
	end,
}
