local M = {
  {
    'nvim-treesitter/nvim-treesitter',
    cmd = "TSUpdate",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
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
          "norg",
          "org",
          "svelte",
          "tsx"
        },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = {
          enable = true
        }
      })
    end
  },
  {
    "nvim-neorg/neorg",
    cmd = "Neorg sync-parsers",
    ft = "norg",
    config = {
      load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.completion"] = {
          config = { engine = "nvim-cmp" },
        },
        ["core.integrations.nvim-cmp"] = {},
      },
    },
  },
}

function M.config()
end

return M
