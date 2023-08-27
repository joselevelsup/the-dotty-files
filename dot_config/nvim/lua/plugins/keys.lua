local utils = require("utils")
local cmd = utils.cmd;
local keymapper = utils.keymapper;


local M = {
  "folke/which-key.nvim",
}

function M.config()
  local whichKey = require("which-key")

  local fileKeys = {
    name = "+file",
    ["<leader>"] = { cmd("Telescope find_files previewer=false hidden=true theme=dropdown"), "Search the chaos" },
    f = { cmd("Fern . -drawer -toggle"), "Browse project wares"},
    p = { cmd("Telescope workspaces hidden=true theme=dropdown"), "Look at your projects"},
    v = { cmd("vs | Fern ."), "Browse project file wares...VERTICALLY!!!" },
    s = { cmd("sp | Fern ."), "Browse project file wares...HORIZONTALLY!!!"},
    g = { cmd("Telescope live_grep"), "What you looking for?"},
  }

  local bufferKeys = {
    name = "+buffer",
    b = { cmd("Telescope buffers previewer=false theme=ivy"), "Look at your current arsenal" },
    n = { cmd("bn"), 'Next Buffer'},
    p = { cmd("bp"), "Previous Buffer"},
 }

  local tabKeys = {
    name = "+tab",
    t = { cmd("tabnew"), "Opens a new blank tab"},
    n = { "gt", "Moves to next tab"},
    p = { "gT", "Moves to previous tab"}
  }

  local windowKeys = {
    name = "+window",
    h = { "<C-w>h", "Strafe to the left"},
    j = { "<C-w>j", "Duck down"},
    k = { "<C-w>k", "Jump up"},
    l = { "<C-w>l", "Strafe to the right"},
    v = { cmd("vs"), "Vertical split"},
    s = { cmd("sp"), "Horizontal split"},
    ["="] = { "<C-w>=", "Equalize the splits"},
  }

  local terminalKeys = {
    name = "+term",
    t = { cmd("term"), "Opens a new Terminal"},
    v = { cmd("vsp | term"), "Open a new terminal...VERTICALLY!!!"},
    s = { cmd("sp | term"), "Open a new terminal...HORIZONTALLY!!!"},
  }

  --Just removing arrow keys and making sure space does nothing but be the leader key
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
    -- Actually this makes K and J (after highlighting in Visual Line) moves said line up or down
    {mode = "x", stroke = "K", cmd = ":move \'<-2<CR>gv-gv", notCmd = true},
    {mode = "x", stroke = "J", cmd = ":move \'>+1<CR>gv-gv", notCmd = true},
    {mode = "t", stroke = "<esc>", cmd = [[<C-\><C-n>]], notCmd = true}
  }
  keymapper(keymaps, { noremap = true, silent = true }, nil)

  whichKey.register({
    ["<leader>"] = {
      b = bufferKeys,
      f = fileKeys,
      t = tabKeys,
      w = windowKeys,
      o = terminalKeys,
      g = { cmd("tab G"), "Opens Fugitive" },
    }
  })
end

return M
