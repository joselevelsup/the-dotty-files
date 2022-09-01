if vim.fn.has("clipboard") then
	if vim.fn.has("unnamedplus") then
		vim.o.clipboard = 'unnamedplus'
	else
		vim.o.clipboard = 'unnamed'
	end
end

vim.go.encoding = 'utf-8'
vim.go.hidden = true
vim.go.number = true
vim.go.background = 'dark'
vim.go.syntax = 'enable'
vim.go.history = 1000
vim.go.completeopt = "menu,menuone,noselect"
vim.go.backupcopy = 'yes'
vim.o.termguicolors = true
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.guicursor = "i:block"
vim.go.guifont = "JetBrainsMono Nerd Font:h9"
vim.go.mouse = "n"

vim.g.netrw_bufsettings = "nohidden noma nomod nonu nowrap ro buflisted"
vim.g.netrw_liststyle = 3
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.tokyonight_style = "night"
vim.g.material_style = "deep ocean"

vim.cmd("set shortmess+=c")
vim.cmd('filetype plugin indent on')
vim.cmd('colorscheme spaceduck')

vim.g.indentLine_fileTypeExclude = { 'dashboard' }
vim.g.indentLine_setConceal = 0

-- Closetag Config
local closetag_region_dict = {}
closetag_region_dict["typescript.tsx"] = "jsxRegion,tsxRegion"
closetag_region_dict["javascript.jsx"] = "jsxRegion"

local user_emmet_settings_dict = {}
user_emmet_settings_dict["javascript.jsx"] = { extends = 'jsx' }

vim.g.closetag_regions = closetag_region_dict
vim.g.closetag_filenames = "*.html,*.jsx,*.tsx,*.js"
vim.g.vim_jsx_pretty_colorful_config = 1

-- Emmet Config
vim.g.user_emmet_mode = 'inv'
vim.g.user_emmet_settings = user_emmet_settings_dict
