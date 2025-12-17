return {
  'echasnovski/mini.bufremove',
  version = false,
  opts = {
    -- No options needed; defaults are correct
  },
  keys = {
    {
      '<leader>bd',
      function()
        require('mini.bufremove').delete(0, false)
      end,
      desc = 'Delete buffer',
    },
    {
      '<leader>bD',
      function()
        require('mini.bufremove').delete(0, true)
      end,
      desc = 'Force delete buffer',
    },
    {
      '<leader>ba',
      function()
        vim.cmd "bufdo lua require('mini.bufremove').delete(0, true)"
      end,
      desc = 'Delete all buffers',
    },
  },
}
