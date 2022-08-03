-- Functional Stuff

function map_expr(mode, shortcut, command, desc)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true, desc = desc, expr = true })
end

function map(mode, shortcut, command, desc)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true, desc = desc })
end

function bufmap(bufnr, mode, shortcut, command, desc)
  vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, command, { noremap = true, silent = true, desc = desc })
end

function nmap(shortcut, command, desc)
  map('n', shortcut, command, desc)
end

function buf_nmap(bufnr, shortcut, command, desc)
  bufmap(bufnr, 'n', shortcut, command, desc)
end

function imap(shortcut, command, desc)
  map('i', shortcut, command, desc)
end

function buf_imap(bufnr, shortcut, command, desc)
  bufmap(bufnr, 'i', shortcut, command, desc)
end

function vmap(shortcut, command, desc)
  map('v', shortcut, command, desc)
end

function buf_vmap(bufnr, shortcut, command, desc)
  bufmap(bufnr, 'v', shortcut, command, desc)
end

