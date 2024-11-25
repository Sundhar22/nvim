return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.erb_lint,
				null_ls.builtins.diagnostics.semgrep,
				null_ls.builtins.formatting.clang_format,
			},
		})
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			update_in_insert = true, -- Enable diagnostics updates in insert mode
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
