local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function load_source(src)
	local ok, loaded = pcall(require, src)
	if not ok then
		vim.api.nvim_err_writeln("Failed to load " .. src .. "\n" .. loaded)
	end
end

load_source("options")

local new_plugins = {
	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
	{ "numToStr/Comment.nvim", opts = {} },
	{                      -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for install instructions
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = require("plugins.telescope"),
	},
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim",                        opts = {} },
		},
		config = require("nvim-lspconfig"),
	},
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-emoji" },
			{ "rafamadriz/friendly-snippets", module = "cmp_nvim_lsp" },
		},
		config = require("plugins.nvim-cmp"),
	},
	{                -- You can easily change to a different colorscheme.
		"joshdick/onedark.vim",
		priority = 1000, -- make sure to load this before all the other start plugins
		init = function()
			vim.cmd.colorscheme("onedark")
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"rcarriga/nvim-notify",
		event = "VimEnter",
		config = require("plugins.nvim-notify"),
	},
	{ -- Terminal popup window
		"akinsho/toggleterm.nvim",
		module = { "toggleterm", "toggleterm.terminal" },
		config = require("plugins.toggleterm"),
	},
	{ -- Smooth Scrolling
		"declancm/cinnamon.nvim",
		event = { "BufRead", "BufNewFile" },
		config = require("plugins.cinnamon"),
	},
	{ -- Welcome Screen
		"goolord/alpha-nvim",
		config = require("plugins.alpha-nvim"),
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- Creates a beautiful debugger UI
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
			-- Installs the debug adapters for you
			{ "williamboman/mason.nvim" },
			{ "jay-babu/mason-nvim-dap.nvim" },
			-- Add your own debuggers here
			{ "mfussenegger/nvim-dap-python" },
			{ "leoluz/nvim-dap-go" },
			{ "nvim-telescope/telescope-dap.nvim" },
		},
		config = require("plugins.nvim-dap"),
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = require("plugins.neo-tree"),
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
}

local plugins = {
	{ "joshdick/onedark.vim" },
	{
		"neovim/nvim-lspconfig",
	},
	{
		"nvim-lua/popup.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufNewFile" },
		config = require("plugins.nvim-treesitter"),
	},
	{
		"stevearc/aerial.nvim",
		config = require("plugins.aerial"),
	},

	{
		"MunifTanjim/nui.nvim",
		module = "nui",
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = "VimEnter",
		config = require("plugins.nvim-web-devicons"),
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = require("plugins.neo-tree"),
	},
	{
		"feline-nvim/feline.nvim",
		config = require("plugins.feline"),
	},
	{
		"rcarriga/nvim-notify",
		event = "VimEnter",
		config = require("plugins.nvim-notify"),
	},
	{ "p00f/nvim-ts-rainbow" },
	{ "akinsho/bufferline.nvim", config = require("plugins.bufferline") },
	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		config = require("plugins.mason"),
	},
	{ "numToStr/Comment.nvim",        keys = { "gc", "gb", "g<", "g>" }, config = require("plugins.Comment") },
	{
		"stevearc/aerial.nvim",
		config = require("plugins.aerial"),
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertCharPre",
		config = require("plugins.better-escape"),
	},
	{ "rafamadriz/friendly-snippets", module = "cmp_nvim_lsp",           event = "InsertEnter" },
	{
		"L3MON4D3/LuaSnip",
		config = require("plugins.LuaSnip"),
	},
	{
		"hrsh7th/nvim-cmp",
		config = require("plugins.nvim-cmp"),
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"rcarriga/cmp-dap",
		},
	},
	-- Snippet completion source
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lua" },
	-- Buffer completion source
	{ "hrsh7th/cmp-buffer" },
	-- Path completion source
	{ "hrsh7th/cmp-path" },
	-- LSP Completion source
	{ "hrsh7th/cmp-nvim-lsp" },
	-- cmd Line Completion source
	{
		"hrsh7th/cmp-cmdline",
		config = require("plugins.cmp-cmdline"),
	},
	-- emoji Completion
	{ "hrsh7th/cmp-emoji" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufRead", "BufNewFile" },
		config = require("plugins.null-ls"),
	},
	{
		"nvim-telescope/telescope.nvim",
		module = "telescope",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = require("plugins.telescope"),
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build =
		"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"akinsho/toggleterm.nvim",
		module = { "toggleterm", "toggleterm.terminal" },
		config = require("plugins.toggleterm"),
	},
	{
		"declancm/cinnamon.nvim",
		event = { "BufRead", "BufNewFile" },
		config = require("plugins.cinnamon"),
	},
	{
		"goolord/alpha-nvim",
		config = require("plugins.alpha-nvim"),
	},
	{ "mfussenegger/nvim-dap" },
	{
		"rcarriga/nvim-dap-ui",
		module = "dapui",
		config = require("plugins.nvim-dap-ui"),
	},
	{
		"rcarriga/cmp-dap",
		config = require("plugins.cmp-dap"),
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = require("plugins.nvim-dap-virtual-text"),
	},
	{
		"mfussenegger/nvim-dap-python",
		config = require("plugins.nvim-dap-python"),
	},
	{ "leoluz/nvim-dap-go" },
	{
		"simrat39/rust-tools.nvim",
		config = require("plugins.rust-tools"),
	},
	{ "nvim-telescope/telescope-dap.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"MunifTanjim/prettier.nvim",
		config = require("plugins.prettier"),
	},
}

require("lazy").setup(new_plugins, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

load_source("colors")
load_source("lsp")
load_source("mappings")
load_source("autocmd")
