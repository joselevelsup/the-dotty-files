local M = {
  'hoob3rt/lualine.nvim',
  dependencies = {'kyazdani42/nvim-web-devicons'},
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info" },
	symbols = { error = " ", warn = " ", info = " " },
	colored = true,
	update_in_insert = true,
	always_visible = false,
}

local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

function M.config()
  local lualine = require("lualine")
  local icons = require("nvim-web-devicons")

  lualine.setup({
    options = {
      theme = "auto",
      globalstatus = true,
      icons_enabled = true,
      disabled_filetypes = {
        statusline = {"alpha", "dashboard", "Outline", "fern"},
        winbar = {"alpha", "dashboard", "Outline", "fern"},
        tabline = {"alpha", "dashboard", "Outline", "fern"}
      },
      always_divide_middle = true,
      component_separators = '',
      section_separators = ''
    },
    sections = {
      lualine_a = {{ 'mode', fmt = function(str) return str:sub(1,3) end }},
      lualine_b = {{ "filename" }, { "branch" }},
      lualine_c = { diagnostics },
      lualine_x = {
        {'encoding'},
        {
          'filetype',
          icon_only = true,
          fmt = function(str)
            if not icons.get_icon(vim.fn.expand('%:t'), vim.bo.filetype) then
                return nil
            end

            return str
          end,
        }
      },
      lualine_y = { progress },
      lualine_z = {{ 'location' }}
    },
  })
end

return M
