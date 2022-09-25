return function()
  local aerial = require("aerial")
  aerial.setup({
    attach_mode = "global",
    backends = {
      "lsp",
      "treesitter",
      "markdown"
    },
    min_width = 28,
    show_guides = true,
    filter_kind = false,
    icons = {
      Array = "",
      Boolean = "⊨",
      Class = "",
      Constant = "",
      Constructor = "",
      Key = "",
      Function = "",
      Method = "ƒ",
      Namespace = "",
      Null = "NULL",
      Number = "#",
      Object = "⦿",
      Property = "",
      TypeParameter = "𝙏",
      Variable = "",
      Enum = "ℰ",
      Package = "",
      EnumMember = "",
      File = "",
      Module = "",
      Field = "",
      Interface = "ﰮ",
      String = "𝓐",
      Struct = "𝓢",
      Event = "",
      Operator = "+",
    },
    guides = {
      mid_item = "├ ",
      last_item = "└ ",
      nested_top = "│ ",
      whitespace = "  ",
    },
    on_attach = function(bufnr)
      -- Toggle the aerial window with <leader>a
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
      -- Jump forwards/backwards with '{' and '}'
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
      -- Jump up the tree with '[[' or ']]'
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
      vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
    end,
  })
end

