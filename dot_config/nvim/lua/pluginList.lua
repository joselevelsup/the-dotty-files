local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end


-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require('packer').startup({function()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

	use {
		"folke/which-key.nvim",
		config = function ()
			require "plugins.keyconfig"
		end
	}

	-- Status Bar
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			require "plugins.lualineconfig"
		end
	}

	use {
		'kdheepak/tabline.nvim',
		config = function()
			require "plugins.tabconfig"
		end,
	}


	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function() 
			require "plugins.treesitterconfig"
		end
	}

	use "nvim-treesitter/nvim-treesitter-context"

	use { 
		'goolord/alpha-nvim',
		config = function()
			require "plugins.dashboardconfig"
		end
	}

	use {
		'TimUntersberger/neogit',
		requires = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim'
		},
		config = function()
			require("neogit").setup{
				auto_refresh = false,
				integrations = {
					diffview = true
				}
			}
		end
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
		config = function()
			require "plugins.telescopeconfig"
		end
	}

	use 'lambdalisue/fern.vim'

	use { "beauwilliams/focus.nvim", 
		config = function() 
			require("focus").setup() 
		end 
	}

	use { 
		'neovim/nvim-lspconfig',
		requires = {
			{"williamboman/mason.nvim"},
			{"williamboman/mason-lspconfig.nvim"},
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'L3MON4D3/LuaSnip'},
			{'saadparwaiz1/cmp_luasnip'},
			{'rafamadriz/friendly-snippets'},
			{'jose-elias-alvarez/null-ls.nvim'},
			{"ray-x/lsp_signature.nvim"}
		},
		event = "BufRead",
		config = function()
			require "plugins.lspconfig"
		end
	}

	use {
		"windwp/nvim-autopairs",
			config = function() require("nvim-autopairs").setup {} end
	}

	use 'mrjones2014/smart-splits.nvim'
	use "alvan/vim-closetag"
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'editorconfig/editorconfig-vim'
	use "lukas-reineke/indent-blankline.nvim"
  use 'jparise/vim-graphql'

	-- Colorschemes
	use 'rebelot/kanagawa.nvim'
	use 'Domeee/mosel.nvim'
  use {
		'pineapplegiant/spaceduck',
		branch = 'main',
	}
	use 'B4mbus/oxocarbon-lua.nvim'

	use 'lewis6991/impatient.nvim'

end,
	config = {
		compile_path = vim.fn.stdpath('config')..'/plugin/packer_compiled.lua'
	}})

