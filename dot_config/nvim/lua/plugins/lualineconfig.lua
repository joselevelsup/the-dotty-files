local present, lualine = pcall(require, "lualine")

if not present then
	return
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info" },
	symbols = { error = " ", warn = " ", info = " " },
	colored = true,
	update_in_insert = true,
	always_visible = true,
}

local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

lualine.setup{
	options = {
		theme = "auto",
		globalstatus = true,
		section_separators = {
			left = "",
			right = ""
		},
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "Outline" },
		always_divide_middle = true,
	},
  sections = {
		lualine_a = { {'mode'} },
		lualine_b = { {'branch'}, diagnostics },
		lualine_c = { {'filename'} },
		lualine_x = { {'encoding', 'fileformat', 'filetype'} },
		lualine_y = { progress },
		lualine_z = { {'location'} }
  }
}
