return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'light'

      -- Palette & contrast
      vim.g.gruvbox_material_palette = 'material' -- safest for light
      vim.g.gruvbox_material_contrast = 'soft' -- medium/hard look harsh in light

      -- Styling (don’t overdo it)
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_italic_comments = 1
      vim.g.gruvbox_material_bold = 1

      -- UI behavior
      vim.g.gruvbox_material_transparent_background = 0 -- light + transparent = ugly
      vim.g.gruvbox_material_disable_terminal_colors = 0
      vim.g.gruvbox_material_better_performance = 1

      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
