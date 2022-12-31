local config = {
  g = {
    mapleader = ' ',
    indentLine_fileTypeExclude = { 'dashboard' },
    indentLine_setConceal = 0,
    mouse = "nvi",
    mousehide = true,
  },
  o = {
    termguicolors = true,
    cursorcolumn = true,
    cursorline = true,
    tabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    clipboard = "unnamedplus",
    cmdheight = 0,
    guicursor = "i:block"
  },
  go = {
    encoding = 'utf-8',
    hidden = true,
    background = 'dark',
    syntax = 'enable',
    history = 1000,
    completeopt = "menu,menuone,noselect",
    guifont = "JetBrainsMono Nerd Font:h9"
  },
  wo = {
    number = true,
    relativenumber = true
  }
}
local group = vim.api.nvim_create_augroup("FernStuff", { clear = true });
vim.api.nvim_create_autocmd("FileType", { pattern = "fern", command = "call glyph_palette#apply()", group = group });
vim.api.nvim_create_autocmd("FileType", { pattern = "fern", command = "setlocal nonu", group = group });
vim.api.nvim_create_autocmd("FileType", { pattern = "fern", command = "setlocal nornu", group = group });

vim.g["fern#renderer"] = "nvim-web-devicons"
vim.g.material_style = "deep ocean",

vim.cmd('filetype plugin indent on')

for configKey, configValue in pairs(config) do
  for vimKey, vimValue in pairs(configValue) do
    vim[configKey][vimKey] = vimValue
  end
end

