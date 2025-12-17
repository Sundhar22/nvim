return {
  'nvim-mini/mini.sessions',

  config = function()
    require('mini.sessions').setup {
      -- Don't auto-read session on startup
      autoread = false,

      -- Auto-write before leaving
      autowrite = true,

      -- Directory for global sessions
      directory = vim.fn.stdpath 'data' .. '/session',

      -- Local session file per folder
      file = 'Session.vim',

      -- Force options
      force = {
        read = false,
        write = true,
        delete = false,
      },

      -- Hooks for actions
      hooks = {
        pre = {
          read = nil,
          write = nil,
          delete = nil,
        },
        post = {
          read = nil,
          write = nil,
          delete = nil,
        },
      },

      -- Print session path after action
      verbose = {
        read = false,
        write = true,
        delete = true,
      },
    }
  end,
}
