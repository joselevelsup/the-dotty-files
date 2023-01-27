return {
  {
    "windwp/nvim-autopairs",
    config = true,
    event = "BufReadPost"
  },
  {
    'lambdalisue/fern.vim',
    dependencies = {
      "TheLeoP/fern-renderer-web-devicons.nvim",
      "lambdalisue/glyph-palette.vim",
      "lambdalisue/fern-hijack.vim"
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end
  },
  {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("barbecue").setup({
        attach_navic = false,
        show_dirname = false,
        show_modified = true,
      })
    end,
    event = "BufReadPre"
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    config = function()
      vim.g.navic_silence = false
      require("nvim-navic").setup({
       icons = {
        Array = " ",
        Boolean = "蘒 ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = "ﳠ ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
      },
      highlight = true,
      separator = " " .. ">" .. " ",
      depth_limit = 0,
      depth_limit_indicator = "..",
    })
    end,
  },
  {
    "kylechui/nvim-surround",
    config = true,
    event = "BufReadPost"
  },
  {
    'numToStr/Comment.nvim',
    config = true,
    event = "BufReadPost"
  },
  {
    "akinsho/toggleterm.nvim",
    config = true,
    event = "VimEnter"
  },
  {
    'mrjones2014/smart-splits.nvim',
    event = "BufRead"
  },
  {
    "alvan/vim-closetag",
    ft = "html,jsx,ts,tsx"
  },
  'editorconfig/editorconfig-vim',
	"lukas-reineke/indent-blankline.nvim",
	-- 'jparise/vim-graphql',
  {
    'natecraddock/workspaces.nvim',
    config = function()
      require("workspaces").setup({
        hooks = {
          open = {
            function(_, path)
              vim.cmd("Fern "..path)
            end
          }
        }
      })
    end,
    event = "VimEnter"
  },
  {
    'toppair/peek.nvim',
    ft = "md",
    build = 'deno task --quiet build:fast',
    init = function()
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
    config = function()
      require('peek').setup({
        auto_load = true,
        close_on_bdelete = true,
        syntax = true,
        theme = 'dark',
        update_on_change = true,
        throttle_at = 200000,
        throttle_time = 'auto',
      })
    end
  },
  {
    "declancm/maximize.nvim",
    config = true,
    event = "BufReadPost"
  },
  {
    "ThePrimeagen/vim-be-good"
  }
}

