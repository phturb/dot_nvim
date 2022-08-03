return function()
  local treesitter = require("nvim-treesitter.configs")
  treesitter.setup({
    ensure_installed = {},
    sync_install = false,
    ingore_install = {},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    rainbow = {
      enable = true,
      disable = { "html" },
      extended_mode = false,
      max_file_lines = nil,
    },
    autopairs = { enable = true },
    autotag = { enable = true },
    incrementatl_selection = { enable = true },
    indent = { enable = false },
  })
end
