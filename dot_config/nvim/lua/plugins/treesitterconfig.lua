local present, treesitter_config = pcall(require, "nvim-treesitter.configs")
local present2, treesitter_context = pcall(require, "treesitter-context")

if not present and present2 then
	return
end

treesitter_config.setup{
	ensure_installed = {
		"bash",
		"css",
		"dockerfile",
		"go",
		"gomod",
		"graphql",
		"javascript",
		"json",
		"jsonc",
		"lua",
		"typescript",
	},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	},
	indent = {
		enable = true
	}
}

function ContextSetup(show_all_context)
    treesitter_context.setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        show_all_context = show_all_context,
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
                "function",
                "method",
                "for",
                "while",
                "if",
                "switch",
                "case",
            },

            typescript = {
                "class_declaration",
                "abstract_class_declaration",
                "else_clause",
            },
        },
    })
end

ContextSetup(false)
