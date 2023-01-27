local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'L3MON4D3/LuaSnip',
    'jose-elias-alvarez/null-ls.nvim',
    "ray-x/lsp_signature.nvim",
    {
      "rmagatti/goto-preview",
      config = true
    }
    
  },
  event = "BufReadPre"
}

function M.config()
  local cmp = require('cmp')
  local keymapper = require("utils").keymapper

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

  cmp.setup({
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
    }, {
        { name = 'buffer' },
        { name = "path" }
      })
  })

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


  local installedLSPs = {
    "sumneko_lua",
    "gopls",
    "tsserver",
    "dockerls",
    "prismals",
    "haxe_language_server",
    "svelte"
  }

  require("mason").setup();

  require("mason-lspconfig").setup({
    ensure_installed = installedLSPs,
  })

  local lspServers = require("lspconfig")
  local navic = require("nvim-navic")

  local function onAttach(client, bufnr)
    local opts = { noremap = true, silent = true }

    local keymap = {
      { mode = "n", stroke = "gD", cmd = "lua vim.lsp.buf.declaration()" },
      { mode = "n", stroke = "gd", cmd = "lua require('goto-preview').goto_preview_definition()" },
      { mode = "n", stroke = "gi", cmd = "lua require('goto-preview').goto_preview_implementation()" },
      { mode = "n", stroke = "gr", cmd = "lua require('goto-preview').goto_preview_references()" },
      { mode = "n", stroke = "gl", cmd = 'lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })' },
      { mode = "n", stroke = "K", cmd = "lua vim.lsp.buf.hover()" },
      { mode = "n", stroke = "<C-k>", cmd = "lua vim.lsp.buf.code_action()" },
      { mode = "n", stroke = "[d", cmd = 'lua vim.diagnostic.goto_prev({ border = "rounded" })' },
      { mode = "n", stroke = "]d", cmd = 'lua vim.diagnostic.goto_next({ border = "rounded" })' },
      { mode = "n", stroke = "<Leader>q", cmd = "lua vim.diagnostic.setloclist()" }
    }

    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end

    setup_diags()

    keymapper(keymap, opts, bufnr);
  end

  local local_capabilities = vim.lsp.protocol.make_client_capabilities()

  for _, lsp in ipairs(installedLSPs) do
    lspServers[lsp].setup {
      on_attach = onAttach,
      capabilities = require('cmp_nvim_lsp').default_capabilities(local_capabilities)
    }
  end

  local null_ls = require("null-ls")
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    debounce = 150,
    sources = {
      -- Javascript/Typescript
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.code_actions.eslint,
      null_ls.builtins.formatting.prettierd,
      -- Go
      null_ls.builtins.diagnostics.revive,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.goimports,
      -- Lua
      null_ls.builtins.formatting.lua_format
    },
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".git", "package.json"),
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              filter = function(c)
                -- apply whatever logic you want (in this example, we'll only use null-ls)
                return c.name == "null-ls"
              end,
              bufnr = bufnr,
            })
          end,
        })
      end
    end
  })
end

return M
