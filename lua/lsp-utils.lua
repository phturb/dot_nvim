local M = {}


function M.on_attach(client, bufnr)
  local bufnmap = require("utils").buf_nmap
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  bufnmap(bufnr, 'gD', vim.lsp.buf.declaration, "LSP - Go to declaration")
  -- bufnmap(bufnr, 'gd', vim.lsp.buf.definition, "LSP - Go to definition")
  bufnmap(bufnr, 'gd', function() require('telescope.builtin').lsp_definitions() end, "LSP - Go to definition")
  bufnmap(bufnr, 'gt', function() require('telescope.builtin').lsp_type_definitions() end, "LSP - Go to type definition")
  bufnmap(bufnr, 'K', vim.lsp.buf.hover, "LSP - Hover info")
  bufnmap(bufnr, 'gi', function() require('telescope.builtin').lsp_implementations() end, "LSP - Go to implementation")
  -- bufnmap(bufnr, 'gi', vim.lsp.buf.implementation, "LSP - Go to implementation")
  bufnmap(bufnr, '<C-k>', vim.lsp.buf.signature_help, "LSP - Signature info")
  bufnmap(bufnr, '<leader>lf', vim.lsp.buf.add_workspace_folder, "LSP - Add workspace folder")
  bufnmap(bufnr, '<leader>lr', vim.lsp.buf.remove_workspace_folder, "LSP - Remove workpsace folder")
  bufnmap(bufnr, '<leader>ll', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "LSP - List workspace folders")
  bufnmap(bufnr, '<leader>D', vim.lsp.buf.type_definition, "LSP - Type Definition")
  bufnmap(bufnr, '<leader>rn', vim.lsp.buf.rename, "LSP - Rename")
  bufnmap(bufnr, '<leader>la', vim.lsp.buf.code_action, "LSP - Code Actions")
  bufnmap(bufnr, 'gr', function() require('telescope.builtin').lsp_references() end, "LSP - References")
  -- bufnmap(bufnr, 'gr', vim.lsp.buf.references, "LSP - References")
  bufnmap(bufnr, '<leader>lf', vim.lsp.buf.formatting, "LSP - Formatting")
end

return M
