return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		priority = 1000, -- Load this first
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
		--		ensure_installed = {
		--			"lua_ls",
		--			"ts_ls", -- Correct name for TypeScript server
		--			"tailwindcss",
		--			"jdtls",
			--	},
				auto_install = true,
			})

			-- Setup LSP configs after mason-lspconfig
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.tailwindcss.setup({})
			lspconfig.ts_ls.setup({}) -- Correct name
			lspconfig.jdtls.setup({})

			-- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		end,
	},
}
