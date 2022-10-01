return function()
  local rust_tools = require("rust-tools")
  local lsp_utils = require("lsp-utils")
  rust_tools.setup({
    tools = {
      crate_graph = {
        backend = "x11",
        output = nil,
        full = true
      },
      hover_actions = {
        border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        }
      },
    },
    server = {
      on_attach = function(client, bufnr)
        lsp_utils.on_attach(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set("n", lsp_utils.hover_keybind, rust_tools.hover_actions.hover_actions, bufopts)
        vim.keymap.set("n", lsp_utils.code_action_keybind, rust_tools.code_action_group.code_action_group, bufopts)
        vim.keymap.set("n", "<leader>cg", function() rust_tools.crate_graph.view_crate_graph("x11", nil) end, bufopts)
        vim.keymap.set("n", "<C-Up>", function() rust_tools.move_item(true) end, bufopts)
        vim.keymap.set("n", "<C-Down>", function() rust_tools.move_item(false) end, bufopts)
        vim.keymap.set("n", "<leader>rp", rust_tools.parent_module.parent_module, bufopts)
        vim.keymap.set("n", "<leader>jl", rust_tools.join_lines.join_lines, bufopts)
      end
    },
    dap = {
      adapter = {
        type = "executable",
        command = "lldb-vscode",
        name = "rt_lldb"
      }
    }
  })
end
