return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- Define a custom source for ast_grep if it is not a builtin
    local ast_grep = {
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "javascript", "typescript", "lua", "python" }, -- Adjust as needed
      generator = null_ls.generator({
        command = "ast-grep",                                   -- Ensure this command is in your PATH
        args = { ".", "-p", "$PATTERN", "--json" },             -- Replace `$PATTERN` with your AST-Grep pattern
        to_stdin = true,
        from_stderr = false,
        format = "json",
        on_output = function(params)
          local diagnostics = {}
          for _, result in ipairs(params.output) do
            table.insert(diagnostics, {
              row = result.start.line,
              col = result.start.column,
              end_row = result["end"].line,
              end_col = result["end"].column,
              message = result.message,
              severity = vim.diagnostic.severity.ERROR, -- Adjust severity
            })
          end
          return diagnostics
        end,
      }),
    }
    local custom_formatter = {
      method = null_ls.methods.FORMATTING,                      -- Specify formatting method
      filetypes = { "javascript", "typescript", "lua", "python" }, -- Adjust filetypes
      generator = null_ls.generator({
        command = "custom-format-tool",                         -- Replace with your formatter's command
        args = { "--stdin-filepath", "$FILENAME" },             -- Arguments for the tool
        to_stdin = true,                                        -- Pass file content via stdin
        from_stderr = false,                                    -- Ignore errors from stderr
        format = "raw",                                         -- Output format is raw text for formatting
        on_output = function(output)
          -- The formatter simply returns formatted text as is
          return output
        end,
      }),
    }

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
       -- null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.semgrep,
        custom_formatter, -- Add your custom formatter
        ast_grep,     -- Add your custom diagnostic source
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.prettier,
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
