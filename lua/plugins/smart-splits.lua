return function()
  local smart_splits = require("smart-splits")
  smart_splits.setup({
    ignored_filtypes = {
      "nofile",
      "quickfix",
      "qf",
      "prompt"
    },
    ignored_buftypes = {
      "nofile"
    },
  })
end
