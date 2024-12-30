local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode")

cmp.setup({
	completion = {
		completeopt = "menu, menuone, preview, noselct",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	}
})
mapping = cmp.mapping.preset.insert({
	["<C-p>"] = cmp.mapping.select_prev_item(),
	["<C-n>"] = cmp.mapping.select_next_item(),
	["<C-y>"] = cmp.mapping.confirm({ select = false }),
	["<C-Space>"] = cmp.mapping.complete(),
})
sources = cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = "luasnip" },
	{ name = "buffer" },
	{ name = "path" },
})
