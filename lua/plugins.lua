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
    use { 'lewis6991/impatient.nvim',
      config = function() require('impatient') end
    }

    -- Popup api
    use { 'nvim-lua/popup.nvim' }

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

    -- Coroutine helper
    use { "nvim-lua/plenary.nvim" }

    -- File explorer
    use { "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      module = "neo-tree",
      cmd = "Neotree",
      config = require("plugins.neo-tree"),
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

    -- LSP Symbols
    use { "stevearc/aerial.nvim",
      config = require("plugins.aerial"),
    }

    -- Snippets
    use { "rafamadriz/friendly-snippets",
      module = "cmp_nvim_lsp",
      event = "InsertEnter",
    }

    -- Snippet engine
    use { "L3MON4D3/LuaSnip",
      config = require("plugins.LuaSnip"),
    }

    -- Completion engine
    use { "hrsh7th/nvim-cmp",
      config = require("plugins.nvim-cmp"),
    }

    -- Snippet completion source
    use { "saadparwaiz1/cmp_luasnip",
    }

    use { "hrsh7th/cmp-nvim-lua",
    }

    -- Buffer completion source
    use { "hrsh7th/cmp-buffer",
    }

    -- Path completion source
    use { "hrsh7th/cmp-path",
    }

    -- LSP Completion source
    use { "hrsh7th/cmp-nvim-lsp",
    }

    -- cmd Line Completion source
    use { "hrsh7th/cmp-cmdline",
      config = require("plugins.cmp-cmdline"),
    }

        -- emoji Completion
    use { "hrsh7th/cmp-emoji",
    }

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



    -- Formatting and linting
    use { "jose-elias-alvarez/null-ls.nvim",
      event = { "BufRead", "BufNewFile" },
      config = require("plugins.null-ls"),
    }

    -- Telescope aka fuzzyfinder
    use { "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
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
      config = require("plugins.alpha-nvim")
    }

    -- DAP
    use { "mfussenegger/nvim-dap" }

    -- DAP UI
    use { "rcarriga/nvim-dap-ui",
      module = "dapui",
      config = require("plugins.nvim-dap-ui")
    }

    use { "rcarriga/cmp-dap",
      config = require("plugins.cmp-dap")
    }

    use { "theHamsta/nvim-dap-virtual-text",
      config = require("plugins.nvim-dap-virtual-text")
    }

    -- python DAP
    use { "mfussenegger/nvim-dap-python",
      config = require("plugins.nvim-dap-python")
    }

    -- go DAP
    use { "leoluz/nvim-dap-go"}

    -- Lua/nvim DAP
    use { "jbyuki/one-small-step-for-vimkind" }

    use { "mxsdev/nvim-dap-vscode-js",
    }

    -- Java LSP
    use { "mfussenegger/nvim-jdtls" }

    -- Rust LSP
    use { "simrat39/rust-tools.nvim",
      config = require("plugins.rust-tools"),
    }

    -- Telescope DAP extension
    use { "nvim-telescope/telescope-dap.nvim",
    }

    -- Telescope UI select
    use { "nvim-telescope/telescope-ui-select.nvim" }

    -- After all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end
)

