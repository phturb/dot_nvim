return function()
  local notify = require("notify")
  notify.setup({
    stages = "fade",
  })
  vim.notify = notify
end
