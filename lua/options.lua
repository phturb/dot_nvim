-- General settings

-- opt
vim.opt.backspace = vim.opt.backspace + { "nostop" }
-- Allow system clipboard
vim.opt.clipboard = "unnamedplus"
-- Insert completion options
vim.opt.completeopt = "menuone,noselect"
-- Highlight cursor text
vim.opt.cursorline = true
-- Space in tabs
vim.opt.expandtab = true
-- UTF-8 Encoding
vim.opt.fileencoding = "utf-8"
-- Remove "~" for non existant lines
vim.opt.fillchars = { eob = " " }
-- Neovim command history size
vim.opt.history = 100
-- NonCase sensitive search
vim.opt.ignorecase = true
-- Global Status
vim.opt.laststatus = 3
-- Lazy redraw to reduce the load
vim.opt.lazyredraw = true
-- Enable mouse
vim.opt.mouse = "a"
-- Numberline
vim.opt.number = true
-- Indent structure preservation
vim.opt.preserveindent = true
-- PopUp menu height
vim.opt.pumheight = 5
-- Relative number line
vim.opt.relativenumber = true
-- Scroll line keep around cursor
vim.opt.scrolloff = 8
-- Indent spaces
vim.opt.shiftwidth = 2
-- Sidescroll column aroun cursor
vim.opt.sidescrolloff = 8
-- Sign Column enabled
vim.opt.signcolumn = "yes"
-- Smart Case
vim.opt.smartcase = true
-- Split under
vim.opt.splitbelow = true
-- Split right
vim.opt.splitright = true
-- Disable swap file in buffer
vim.opt.swapfile = false
-- Space in tabs
vim.opt.tabstop = 2
-- Termguicolors - NEEDD TO HAVE NICE COLORS
vim.opt.termguicolors = true
-- Timeout between keys
vim.opt.timeoutlen = 300
-- Persistent undo
vim.opt.undofile = true
-- Plugin trigger wait time
vim.opt.updatetime = 250
-- Line wrap
vim.opt.wrap = false
-- Backup disable on buffer write
vim.opt.writebackup = false
-- Coloum ruller
vim.opt.colorcolumn = "125"
-- Enable break indent
vim.opt.breakindent = true
-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- g
-- Use space as leader key
vim.g.mapleader = " " -- <leader> = <space>
-- New filetype from neovim
vim.g.do_filetype_lua = 1
vim.g.did_locad_filetypes = 0
-- Highlight urls
vim.g.highlighturl_enabled = true
-- General disable
vim.g.zipPlugin = false -- disable zip
vim.g.load_black = false -- disable black
vim.g.loaded_2html_plugin = true -- disable 2html
vim.g.loaded_getscript = true -- disable getscript
vim.g.loaded_getscriptPlugin = true -- disable getscript
vim.g.loaded_gzip = true -- disable gzip
vim.g.loaded_logipat = true -- disable logipat
vim.g.loaded_matchit = true -- disable matchit
vim.g.loaded_netrwFileHandlers = true -- disable netrw
vim.g.loaded_netrwPlugin = true -- disable netrw
vim.g.loaded_netrwSettngs = true -- disable netrw
vim.g.loaded_remote_plugins = true -- disable remote plugins
vim.g.loaded_tar = true -- disable tar
vim.g.loaded_tarPlugin = true -- disable tar
vim.g.loaded_zip = true -- disable zip
vim.g.loaded_zipPlugin = true -- disable zip
vim.g.loaded_vimball = true -- disable vimball
vim.g.loaded_vimballPlugin = true -- disable vimball
vim.g.have_nerd_font = true -- indicate if you have installed a nerd font
