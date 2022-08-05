local lspconfig = require("lspconfig")
local on_attach = require("lsp-utils").on_attach

local lsp_flags = {
  debounce_text_changes = 150,
}


-- local capabilities = vim.lsp.protocol.make_client_capabilities() -- require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua
lspconfig["sumneko_lua"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
    }
  }
}

-- Ruby
lspconfig["solargraph"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- Java
-- lspconfig["jdtls"].setup {}

-- Python
lspconfig["jedi_language_server"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- Typescript
lspconfig["tsserver"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}
