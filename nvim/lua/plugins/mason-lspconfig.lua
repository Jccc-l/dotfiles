-- ~/.config/nvim/plugins/mason-lspconfig.lua
return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		-- 自动安装这些 LSP 服务器
		ensure_installed = {
			"clangd",
			"lua_ls",
			"vimls",
			"bashls",
			"jsonls",
			"yamlls",
			"marksman",
			-- "git-delta", -- Git 差异查看
			-- "clang-format",-- Clang 格式化
			-- "rust_analyzer", -- 如果你用 Rust 再打开
			-- "tsserver",
		},

		automatic_installation = true, -- 保存文件时自动安装对应语言的工具
		-- 只自动启用以下服务器（更安全）
		-- 避免某些重型 LSP（如 rust_analyzer）自动启动
		automatic_enable = {
			"clangd",
			"lua_ls",
			"vimls",
			"bashls",
			"jsonls",
			"yamlls",
			"marksman",
		},
	},
}
