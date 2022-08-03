require("utils")

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd("packadd packer.nvim")
end

local packer = require("packer")
packer.startup(
  function(use)
    -- Packer itself 
    use "wbthomason/packer.nvim"

    -- Impatient
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

    -- Popup api
    use 'nvim-lua/popup.nvim'

    -- Indent detection
    use { 'Darazaki/indent-o-matic',
      event = "BufReadPost",
      config = require("plugins.indent-o-matic"),
    }

    -- Better notification
    use { 'rcarriga/nvim-notify',
      event = "VimEnter",
      config = require("plugins.nvim-notify"),
    }

    -- Better neovim UI
    use { 'MunifTanjim/nui.nvim',
      module = "nui",
    }

    -- CursorholdFix
    use { 'antoinemadec/FixCursorHold.nvim',
      event = { "BufRead", "BufNewFile" },
      config = require("plugins.FixCursorHold"),
    }

    -- Smarter split (BETTER)
    use { 'mrjones2014/smart-splits.nvim',
      module = "smart-splits",
      config = require("plugins.smart-splits"),
    }

    -- Nice Icons
    use { 'kyazdani42/nvim-web-devicons',
      event = "VimEnter",
      config = require("plugins.nvim-web-devicons"),
    }

    -- Bufferline
    use { 'akinsho/bufferline.nvim',
      config = require("plugins.bufferline"),
    }

    -- Buffer closing done right
    use { 'famiu/bufdelete.nvim',
      cmd = { "Bdelete", "Bwipeout" },
    }

    -- Todo find what it is
    use { "nvim-lua/plenary.nvim" }

    -- File explorer
    use { "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      module = "neo-tree",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        { "MunifTanjim/nui.nvim", module = "nui" },
      },
      cmd = "Neotree",
      setup = function()
        vim.g.neo_tree_remove_legacy_commands = true
      end,
      config = require("plugins.neo-tree")
    }

    -- Statusline
    use { "feline-nvim/feline.nvim",
      config = require("plugins.feline"),
    }

    -- Perenthesis highlighting of rainbow colour
    use { "p00f/nvim-ts-rainbow" }

    -- Autoclose tags
    use { "windwp/nvim-ts-autotag" }

    -- Context based commenting
    use { "JoosepAlviste/nvim-ts-context-commentstring" }

    -- Syntax highlight
    use { "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = { "BufRead", "BufNewFile" },
      cmd = {
        "TSInstall",
        "TSInstallInfo",
        "TSInstallSync",
        "TSUninstall",
        "TSUpdate",
        "TSUpdateSync",
        "TSDisableAll",
        "TSEnableAll",
      },
      config = require("plugins.nvim-treesitter")
    }

    -- Snippets
    use { "rafamadriz/friendly-snippets",
      module = "cmp_nvim_lsp",
      event = "InsertEnter",
      requires = "L3MON4D3/LuaSnip",
    }

    -- Snippet engine
    use { "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = require("plugins.LuaSnip"),
    }

    -- Completion engine
    use { "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = require("plugins.nvim-cmp"),
    }

    -- Snippet completion source
    use { "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
    }

    use { "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
    }

    -- Buffer completion source
    use { "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
    }

    -- Path completion source
    use { "hrsh7th/cmp-path",
      after = "cmp-buffer"
    }

    -- LSP Completion source
    use { "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua"
    }

    -- cmd Line Completion source
    use { "hrsh7th/cmp-cmdline" }

        -- emoji Completion
    use { "hrsh7th/cmp-emoji" }

    -- Built-in LSP
    use { "neovim/nvim-lspconfig",
      event = "VimEnter",
    }

    -- LSP Manager
    use { "williamboman/mason.nvim",
      cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
      },
      config = require("plugins.mason"),
    }

    -- LSP Manager LSP Config link
    -- use { "williamboman/mason-lspconfig.nvim",
    --   config = function()
    --     local mason_config = require("mason-lspconfig")
    --     mason_config.setup({
    --       ensure_installed = { "sumneko_lua" }
    --     })
    --     require("lsp")
    --     mason_config.setup_handlers({
    --       function(server_name)
    --         require("lspconfig")[server_name].setup {}
    --       end
    --     })
    --   end,
    -- }

    -- LSP Symbols
    use { "stevearc/aerial.nvim",
      module = "aerial",
      cmd = {
        "AerialToggle",
        "AerialOpen",
        "AerialInfo",
      },
      config = require("plugins.aerial"),
    }

    -- Formatting and linting
    use { "jose-elias-alvarez/null-ls.nvim",
      event = { "BufRead", "BufNewFile" },
      config = require("plugins.null-ls"),
    }

    -- Telescope aka fuzzyfinder
    use { "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
        -- Telescope Syntax support
        { 'nvim-telescope/telescope-fzf-native.nvim' },
        -- Aerial symbol
        { 'stevearc/aerial.nvim' },
        -- Notification integration
        { 'rcarriga/nvim-notify' },
      },
      module = "telescope",
      config = require("plugins.telescope"),
    }

    -- Telescope Syntax support
    use { 'nvim-telescope/telescope-fzf-native.nvim',
      run = "make",
    }

    -- Git helper
    use { "lewis6991/gitsigns.nvim",
      event = "BufEnter",
      config = require("plugins.gitsigns"),
    }

    -- Color highlight
    use { "norcalli/nvim-colorizer.lua",
      event = { "BufRead", "BufNewFile" },
      config = require('plugins.nvim-colorizer'),
    }

    -- Autopairs
    use { "windwp/nvim-autopairs",
      requires = { "hrsh7th/nvim-cmp" },
      event = "InsertEnter",
      config = require("plugins.nvim-autopairs"),
    }

    -- Terminal popup
    use { "akinsho/toggleterm.nvim",
      cmd = "ToggleTerm",
      module = { "toggleterm", "toggleterm.terminal" },
      config = require("plugins.toggleterm"),
    }

    -- Commenting
    use { "numToStr/Comment.nvim",
      requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
      module = { "Comment", "Comment.api" },
      keys = { "gc", "gb", "g<", "g>" },
      config = require("plugins.Comment")
    }

    -- Smooth scrolling
    use { "declancm/cinnamon.nvim",
      event = { "BufRead", "BufNewFile" },
      config = require("plugins.cinnamon")
    }

    -- Session Manager
    use { "Shatur/neovim-session-manager",
      module = "session_manager",
      cmd = "SessionManager",
      event = "BufWritePost",
      config = require("plugins.neovim-session-manager"),
    }

    -- Smooth escaping
    use { "max397574/better-escape.nvim",
      event = "InsertCharPre",
      config = require("plugins.better-escape"),
    }

    -- Zen upgrade
    use { "Pocco81/true-zen.nvim",
      config = require("plugins.true-zen"),
    }

    -- Color Scheme
    use { "joshdick/onedark.vim" }

    -- Dashboard
    use { 'goolord/alpha-nvim',
      requires = { "kyazdani42/nvim-web-devicons" },
      config = require("plugins.alpha-nvim")
    }

    -- DAP
    use { "mfussenegger/nvim-dap" }

    -- DAP UI
    use { "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      module = "dapui",
      config = require("plugins.nvim-dap-ui")
    }

    use { "theHamsta/nvim-dap-virtual-text",
      requires = { "mfussenegger/nvim-dap" },
      config = require("plugins.nvim-dap-virtual-text")
    }

    -- Java LSP
    use { "mfussenegger/nvim-jdtls" }


    -- After all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end
)

