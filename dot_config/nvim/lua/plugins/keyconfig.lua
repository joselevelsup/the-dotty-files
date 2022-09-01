local present, whichKey = pcall(require, "which-key")
local cmd = require("utils").cmd

if not present then 
	return 
end

local fileKeys = {
	name = "+file",
	["<leader>"] = { cmd("Telescope find_files previewer=false hidden=true theme=dropdown"), "Search the chaos" },
	f = { cmd("Fern ."), "Browse project wares"},
	v = { cmd("FocusSplitRight cmd Fern ."), "Browse project file wares...VERTICALLY!!!" },
	s = { cmd("FocusSplitDown cmd Fern ."), "Browse project file wares...HORIZONTALLY!!!"},
	g = { cmd("Telescope live_grep"), "What you looking for?"},
}

local bufferKeys = {
	name = "+buffer",
	b = { cmd("Telescope buffers previewer=false theme=ivy"), "Look at your current arsenal" },
	n = {cmd("bn"), 'Next Buffer'},
	p = { cmd("bp"), "Previous Buffer"},
}

local tabKeys = {
	name = "+tab",
	t = {cmd("tabnew"), "Opens a new blank tab"},
	n = {"gt", "Moves to next tab"},
	p = { "gT", "Moves to previous tab"}
}

local windowKeys = {
	name = "+window",
	h = { "<C-w>h", "Strafe to the left"},
	j = {"<C-w>j", "Duck down"}, 
	k = {"<C-w>k", "Jump up"},
	l = {"<C-w>l", "Strafe to the right"},
	v = { cmd("FocusSplitRight"), "Vertical split"},
	s = { cmd("FocusSplitDown"), "Horizontal split"},
	S = { cmd("FocusSplitNicely"), "Split Nicely based on Golden Ratio?"},
	["="] = { cmd("FocusEqualise"), "Equalize the splits"},
}

local terminalKeys = {
	name = "+term",
	t = { cmd("term"), "Open a new terminal"},
	v = { cmd("FocusSplitRight cmd term"), "Open a new terminal...VERTICALLY!!!"},
	s = { cmd("FocusSplitDown cmd term"), "Open a new terminal...HORIZONTALLY!!!"}
}

whichKey.register({
	["<leader>"] = {
		b = bufferKeys,
		f = fileKeys,
		t = tabKeys,
		w = windowKeys,
		o = terminalKeys,
		g = {cmd("Neogit"), "Let's GIT into it"}
	}
})
