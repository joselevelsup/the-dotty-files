return {
  "folke/tokyonight.nvim",
  'rebelot/kanagawa.nvim',
  'Domeee/mosel.nvim',
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
  },
}

