return function()
  local on_attach = require("lsp-utils").on_attach
  local utils = require("utils")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local python_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    utils.nmap("<leader>tm", function()
      require('dap-python').test_method {}
    end, "Test method")
    utils.nmap("<leader>tc", function()
      require('dap-python').test_class {}
    end, "Test class")
    utils.nmap("<leader>ts", function()
      require('dap-python').debug_selection {}
    end, "Debug selection")
  end
  local servers = {

    -- Ruby - https://solargraph.org/ - solargraph
    solargraph = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- Java - HANDLED by ftplugin/java.lua

    -- Python - https://github.com/pappasam/jedi-language-server - jedi-language-server


    jedi_language_server = {
      on_attach = python_on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- Typescript - https://github.com/theia-ide/typescript-language-server - typescript typescript-language-server
    tsserver = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- Javascript - https://github.com/hrsh7th/vscode-langservers-extracted - vscode-langservers-extracted
    eslint = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- Bash - https://github.com/mads-hartmann/bash-language-server - bash-language-server
    bashls = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- Go - https://github.com/golang/tools/tree/master/gopls - gopls
    gopls = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- HTML - https://github.com/hrsh7th/vscode-langservers-extracted - vscode-langservers-extracted
    html = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- CSS - https://github.com/hrsh7th/vscode-langservers-extracted - vscode-langservers-extracted
    cssls = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- JSON - https://github.com/hrsh7th/vscode-langservers-extracted - vscode-langservers-extracted
    jsonls = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- Rust -- HANDLED BY PLUGIN

    -- Terraform - https://github.com/hashicorp/terraform-ls - terraform-ls
    terraformls = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    },

    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`tsserver`) will work just fine
    -- tsserver = {},
    --

    lua_ls = {
      -- cmd = {...},
      -- filetypes { ...},
      -- capabilities = {},
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            -- Tells lua_ls where to find all the Lua files that you have loaded
            -- for your neovim configuration.
            library = {
              '${3rd}/luv/library',
              unpack(vim.api.nvim_get_runtime_file('', true)),
            },
            -- If lua_ls is really slow on your computer, you can try this instead:
            -- library = { vim.env.VIMRUNTIME },
          },
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
  }

  -- Ensure the servers and tools above are installed
  --  To check the current status of installed tools and/or manually install
  --  other tools, you can run
  --    :Mason
  --
  --  You can press `g?` for help in this menu
  require('mason').setup()

  -- You can add other tools here that you want Mason to install
  -- for you, so that they are available from within Neovim.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'stylua', -- Used to format lua code
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  require('mason-lspconfig').setup {
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    },
  }
end
