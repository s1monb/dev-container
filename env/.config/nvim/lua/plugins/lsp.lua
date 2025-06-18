return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "gopls" },
	},
	lazy = false,
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{
			"neovim/nvim-lspconfig",
			opts = {},
			-- example calling setup directly for each LSP
			config = function()
				local capabilities = require("blink.cmp").get_lsp_capabilities()
				local lspconfig = require("lspconfig")

				lspconfig["lua_ls"].setup({ capabilities = capabilities })
				lspconfig["gopls"].setup({ capabilities = capabilities })
				lspconfig["ts_ls"].setup({ capabilities = capabilities })
			end,
		},
	},
}
