local cmp = require('cmp')
local keymapper = require("utils").keymapper

require("luasnip/loaders/from_vscode").lazy_load()

local icons = {
   Text = "",
   Method = "",
   Function = "",
   Constructor = "",
   Field = "ﰠ",
   Variable = "",
   Class = "ﴯ",
   Interface = "",
   Module = "",
   Property = "ﰠ",
   Unit = "塞",
   Value = "",
   Enum = "",
   Keyword = "",
   Snippet = "",
   Color = "",
   File = "",
   Reference = "",
   Folder = "",
   EnumMember = "",
   Constant = "",
   Struct = "פּ",
   Event = "",
   Operator = "",
   TypeParameter = "",
}

cmp.setup{
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
    format = function(entry, vim_item)
			vim_item.kind = string.format(
				"%s %s",
				icons[vim_item.kind],
				vim_item.kind
			)

			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[SNIP]",
				buffer = "[BUF]",
			})[entry.source.name]

			return vim_item
		end,
  },
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm {
			 behavior = cmp.ConfirmBehavior.Replace,
			 select = true,
		},
	},
	sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
  }, {
      { name = 'buffer' },
			{ name = "path" }
  })
}

local function setup_diags()
	local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

setup_diags()

local installedLSPs = {
	"sumneko_lua",
	"gopls",
	"tsserver",
	"dockerls",
	"prismals"
}

require("mason").setup();

require("mason-lspconfig").setup({
	ensure_installed = installedLSPs,
	automatic_installation = true
})

local lspServers = require("lspconfig")

local onAttach = function (client, bufnr)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false

	local opts = { noremap = true, silent = true }

	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]],
			false
		)
	end

	local keymap = {
		{mode = "n", stroke = "gD", cmd = "lua vim.lsp.buf.declaration()"},
		{mode = "n", stroke = "gd", cmd = "lua vim.lsp.buf.definition()" },
		{mode = "n", stroke = "K", cmd = "lua vim.lsp.buf.hover()"},
		{mode = "n", stroke = "gi", cmd = "lua vim.lsp.buf.implementation()"},
		{mode = "n", stroke = "<C-k>", cmd = "lua vim.lsp.buf.code_action()"},
		{mode = "n", stroke = "gr", cmd = "lua vim.lsp.buf.references()"},
		{mode = "n", stroke = "[d", cmd = 'lua vim.diagnostic.goto_prev({ border = "rounded" })'},
		{mode = "n", stroke = "]d", cmd = 'lua vim.diagnostic.goto_next({ border = "rounded" })'},
		{mode = "n", stroke = "gl", cmd = 'lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })'},
		{mode = "n", stroke = "<Leader>q", cmd = "lua vim.diagnostic.setloclist()"}
	}

	keymapper(keymap, opts, bufnr);
end

local lspFlags = {
	debounce_text_changes = 150,
}

local local_capabilities = vim.lsp.protocol.make_client_capabilities()

for _, lsp in ipairs(installedLSPs) do
	lspServers[lsp].setup {
		on_attach = onAttach,
		flags = lspFlags,
		capabilities = require('cmp_nvim_lsp').update_capabilities(local_capabilities)
	}

end

local null_ls = require "null-ls"

null_ls.setup({
	sources = {
		-- Javascript/Typescript
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.prettier,
		-- Go
		null_ls.builtins.diagnostics.revive,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
				vim.cmd([[
				augroup LspFormatting
						autocmd! * <buffer>
						autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 3000)
				augroup END
				]])
		end
	end
})
