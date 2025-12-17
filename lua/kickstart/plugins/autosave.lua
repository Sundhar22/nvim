return {
  'okuuva/auto-save.nvim',
  event = { 'InsertEnter' },
  opts = {
    condition = function(buf)
      local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
      if ft == 'Fyler' then
        return false
      end
      return true
    end,
  },
  config = function(_, opts)
    require('auto-save').setup(opts)

    -- Disable autoformat before autosave
    vim.api.nvim_create_autocmd('User', {
      pattern = 'AutoSaveWritePre',
      desc = 'Disable autoformat before auto-save',
      callback = function()
        -- Global format flag (kickstart convention)
        vim.g._old_autoformat = vim.g.autoformat
        vim.g.autoformat = false

        local old_buffers = {}

        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.b[bufnr].autoformat then
            table.insert(old_buffers, bufnr)
            vim.b[bufnr].autoformat = false
          end
        end

        vim.g._old_autoformat_buffers = old_buffers
      end,
    })

    -- Restore autoformat after autosave
    vim.api.nvim_create_autocmd('User', {
      pattern = 'AutoSaveWritePost',
      desc = 'Restore autoformat after auto-save',
      callback = function()
        vim.g.autoformat = vim.g._old_autoformat

        for _, bufnr in ipairs(vim.g._old_autoformat_buffers or {}) do
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.b[bufnr].autoformat = true
          end
        end
      end,
    })
  end,
}
