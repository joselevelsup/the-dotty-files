local keymapper = require("utils").keymapper;

vim.g.mapleader = ' '

local keymaps = {
	{mode = "n", stroke = "<Space>", cmd = "<NOP>", notCmd = true},
	{mode = "n", stroke = "<Up>", cmd = "<NOP>", notCmd = true},
	{mode = "n", stroke = "<Down>", cmd = "<NOP>", notCmd = true},
	{mode = "n", stroke = "<Left>", cmd = "<NOP>", notCmd = true},
	{mode = "n", stroke = "<Right>", cmd = "<NOP>", notCmd = true},
	{mode = "i", stroke = "<Up>", cmd = "<NOP>", notCmd = true},
	{mode = "i", stroke = "<Down>", cmd = "<NOP>", notCmd = true},
	{mode = "i", stroke = "<Left>", cmd = "<NOP>", notCmd = true},
	{mode = "i", stroke = "<Right>", cmd = "<NOP>", notCmd = true},
	{mode = "x", stroke = "K", cmd = ":move \'<-2<CR>gv-gv", notCmd = true},
	{mode = "x", stroke = "J", cmd = ":move \'>+1<CR>gv-gv", notCmd = true}
}

keymapper(keymaps, { noremap = true, silent = true }, nil)

