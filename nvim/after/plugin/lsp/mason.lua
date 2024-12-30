local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		}
	}
})

mason_lspconfig.setup({
	ensure_installed = {
		"ts_ls",
		"cssls",
		"jsonls",
		"arduino_language_server",
		"bashls", 
		"clangd",
		"html",
		"pyright",
		"sqlls",
		"yamlls",
		"ast_grep",
		"lua_ls"
	},

	automatic_installation = true,

})
