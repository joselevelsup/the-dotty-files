local M = {}

function M.cmd(command)
   return table.concat({ '<cmd>', command, '<CR>' })
end

function M.keymapper(keymap, options, buffer)
	for _, value in pairs(keymap) do
		if buffer then
			vim.api.nvim_buf_set_keymap(buffer, value.mode, value.stroke, M.cmd(value.cmd), options)
		else
			if value.notCmd then
				vim.api.nvim_set_keymap(value.mode, value.stroke, value.cmd, options)
			else
				vim.api.nvim_set_keymap(value.mode, value.stroke, M.cmd(value.cmd), options)
			end
		end
	end
end

return M
