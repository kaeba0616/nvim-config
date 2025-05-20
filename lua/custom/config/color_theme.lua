---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  transparent = true,
  styles = {
    sidebars = 'transparent',
    floats = 'transparent',
    comments = { italic = false },
    -- Disable italics in comments
  },
}
vim.cmd.colorscheme 'tokyonight-night'
