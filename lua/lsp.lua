local lspconfig = require("lspconfig")
local on_attach = require("lsp-utils").on_attach
local utils = require("utils")

local lsp_flags = {
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Lua - https://github.com/sumneko/lua-language-server - lua-language-server
lspconfig["sumneko_lua"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
}

-- Ruby - https://solargraph.org/ - solargraph
lspconfig["solargraph"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- Java - HANDLED by ftplugin/java.lua

-- Python - https://github.com/pappasam/jedi-language-server - jedi-language-server
local python_on_attach = function(client, bufnr)
  on_attach(client, bufnr)
  utils.nmap("<leader>tm", function() require('dap-python').test_method() end, "Test method")
  utils.nmap("<leader>tc", function() require('dap-python').test_class() end, "Test class")
  utils.nmap("<leader>ts", function() require('dap-python').debug_selection() end, "Debug selection")
end

lspconfig["jedi_language_server"].setup {
  on_attach = python_on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- Typescript - https://github.com/theia-ide/typescript-language-server - typescript typescript-language-server
lspconfig["tsserver"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- Javascript - https://github.com/hrsh7th/vscode-langservers-extracted - vscode-langservers-extracted
lspconfig["eslint"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- Bash - https://github.com/mads-hartmann/bash-language-server - bash-language-server
lspconfig["bashls"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- Go - https://github.com/golang/tools/tree/master/gopls - gopls
lspconfig["gopls"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- HTML - https://github.com/hrsh7th/vscode-langservers-extracted - vscode-langservers-extracted
lspconfig["html"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- CSS - https://github.com/hrsh7th/vscode-langservers-extracted - vscode-langservers-extracted
lspconfig["cssls"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- JSON - https://github.com/hrsh7th/vscode-langservers-extracted - vscode-langservers-extracted
lspconfig["jsonls"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- Rust -- HANDLED BY PLUGIN

-- Terraform - https://github.com/hashicorp/terraform-ls - terraform-ls
lspconfig['terraformls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
