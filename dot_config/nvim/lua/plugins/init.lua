return {
  {
    "windwp/nvim-autopairs",
    config = true
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
    "beauwilliams/focus.nvim",
    config = true,
    event = "BufRead",
  },
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end
  },
  {
    "SmiteshP/nvim-navic",
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
    config = true
  },
  'mrjones2014/smart-splits.nvim',
	"alvan/vim-closetag",
	'editorconfig/editorconfig-vim',
	"lukas-reineke/indent-blankline.nvim",
	'jparise/vim-graphql',
  {
    'rebelot/kanagawa.nvim',
    config = function()
      vim.cmd([[ colorscheme kanagawa ]])
    end
  },
	'Domeee/mosel.nvim',
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
  }
}

