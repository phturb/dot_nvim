local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>ll', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, bufopts)
end
local lsp_flags = {
  debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities() -- require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
