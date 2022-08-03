return function()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header.val = {
    "  ████████╗██╗   ██╗ ██████╗ ███╗   ██╗ ",
    "     ██╔══╝██║   ██║██╔═══██╗████╗  ██║ ",
    "     ██║   ██║   ██║███████╗╝██╔██╗ ██║ ",
    "     ██║   ██║   ██║██║  ╚██╗██║╚██╗██║ ",
    "     ██║   ╚██████╔╝██║   ██║██║ ╚████║ ",
    "     ╚═╝    ╚═════╝ ╚═╝   ╚═╝╚═╝  ╚═══╝ ",
  }
  local fortune = require("alpha.fortune")
  dashboard.section.footer.val = fortune()
  alpha.setup(dashboard.opts)
end

