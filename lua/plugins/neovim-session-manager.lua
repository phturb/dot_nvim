return function()
  local session_manager = require("session_manager")
  session_manager.setup({ autosave_last_session = false })
end
