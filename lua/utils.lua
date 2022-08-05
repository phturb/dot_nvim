-- Functional Stuff

local M = {}

function M.map_expr(mode, shortcut, command, desc)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true, desc = desc, expr = true })
end

function M.map(mode, shortcut, command, desc)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true, desc = desc })
end

function M.bufmap(bufnr, mode, shortcut, command, desc)
  vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, command, { noremap = true, silent = true, desc = desc })
end

function M.nmap(shortcut, command, desc)
  M.map('n', shortcut, command, desc)
end

function M.buf_nmap(bufnr, shortcut, command, desc)
  M.bufmap(bufnr, 'n', shortcut, command, desc)
end

function M.imap(shortcut, command, desc)
  M.map('i', shortcut, command, desc)
end

function M.buf_imap(bufnr, shortcut, command, desc)
  M.bufmap(bufnr, 'i', shortcut, command, desc)
end

function M.vmap(shortcut, command, desc)
  M.map('v', shortcut, command, desc)
end

function M.buf_vmap(bufnr, shortcut, command, desc)
  M.bufmap(bufnr, 'v', shortcut, command, desc)
end


return M
