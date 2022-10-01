local M = {}

M.hover_keybind = "K"
M.go_to_keybind = "g"
M.git_keybind = "<leader>g"
M.lsp_keybind = "<leader>l"
M.code_action_keybind = M.lsp_keybind .. "a"

function M.on_attach(client, bufnr)
  local bufnmap = require("utils").buf_nmap
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  bufnmap(bufnr, M.go_to_keybind .. 'D', vim.lsp.buf.declaration, "LSP - Go to declaration")
  -- bufnmap(bufnr, 'gd', vim.lsp.buf.definition, "LSP - Go to definition")
  bufnmap(bufnr, M.hover_keybind, vim.lsp.buf.hover, "LSP - Hover info")
  bufnmap(bufnr, M.go_to_keybind ..'d', function() require('telescope.builtin').lsp_definitions() end, "LSP - Go to definition")
  bufnmap(bufnr, M.go_to_keybind ..'t', function() require('telescope.builtin').lsp_type_definitions() end, "LSP - Go to type definition")
  bufnmap(bufnr, M.go_to_keybind ..'i', function() require('telescope.builtin').lsp_implementations() end, "LSP - Go to implementation")
  -- bufnmap(bufnr, 'gi', vim.lsp.buf.implementation, "LSP - Go to implementation")
  bufnmap(bufnr, '<C-k>', vim.lsp.buf.signature_help, "LSP - Signature info")
  bufnmap(bufnr, M.lsp_keybind .. 'r', vim.lsp.buf.rename, "LSP - Rename")
  bufnmap(bufnr, M.lsp_keybind .. 'f', vim.lsp.buf.add_workspace_folder, "LSP - Add workspace folder")
  bufnmap(bufnr, M.lsp_keybind .. 'rw', vim.lsp.buf.remove_workspace_folder, "LSP - Remove workpsace folder")
  bufnmap(bufnr, M.lsp_keybind .. 'f', vim.lsp.buf.formatting, "LSP - Formatting")
  bufnmap(bufnr, M.lsp_keybind .. 'l', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "LSP - List workspace folders")
  bufnmap(bufnr, '<leader>D', vim.lsp.buf.type_definition, "LSP - Type Definition")
  bufnmap(bufnr, M.code_action_keybind, vim.lsp.buf.code_action, "LSP - Code Actions")
  -- bufnmap(bufnr, 'gr', vim.lsp.buf.references, "LSP - References")
  bufnmap(bufnr, 'gr', function() require('telescope.builtin').lsp_references() end, "LSP - References")
  require('aerial').on_attach(client, bufnr)
end

return M
