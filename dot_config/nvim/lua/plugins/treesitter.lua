local M = {
  'nvim-treesitter/nvim-treesitter',
  cmd = "TSUpdate",
  event = "BufRead",
}

function M.config()
  require("nvim-treesitter.configs").setup{
    ensure_installed = {
      "vim",
      "regex",
      "bash",
      "css",
      "dockerfile",
      "go",
      "gomod",
      "graphql",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "typescript",
    },
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },
    indent = {
      enable = true
    }
  }
end

return M
