return function()
  local gitsigns = require("gitsigns")
  gitsigns.setup({
    signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▎" },
    topdelete = { text = "契" },
    changedelete = { text = "▎" },
    },
  })
end
