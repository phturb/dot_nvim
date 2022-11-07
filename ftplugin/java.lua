-- Require "mfussenegger/nvim-jdtls"
local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
local home = os.getenv('HOME')

local java_home = os.getenv('JAVA_HOME')
local lsp_home = home .. "/.local/share/nvim/lsp"
-- This needs to be manually installed - https://download.eclipse.org/jdtls/milestones/?d
local jar = lsp_home .. "/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
local jdt_config = lsp_home .. "/jdt-language-server/config_mac"
-- This needs to be manually installed - https://projectlombok.org/download
local lombok = lsp_home .. "/jdt-language-server/lombok.jar"
local workspace = lsp_home .. "/workspace/" .. vim.fn.fnamemodify(root_dir, ':p:h:t')

local cmd = {
  java_home .. "/bin/java",
  "-javaagent:" .. lombok,
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xms2g",
  "-Xmx4g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "-jar", jar,
  "-configuration", jdt_config,
  "-data", workspace,
}

-- This needs to be manually installed and compiled - https://github.com/microsoft/vscode-java-debug
local bundles = {
  vim.fn.glob(lsp_home .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
}
-- This needs to be manually installed and compiled - https://github.com/microsoft/vscode-java-test
vim.list_extend(bundles, vim.split(vim.fn.glob(lsp_home .. "/vscode-java-test/server/*.jar"), "\n"))

local on_attach = function(client, bufnr)
-- Generic on_attach with default keymap
  require('lsp-utils').on_attach(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, bufopts)
-- This is jdtls specific attach command
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  require('jdtls.setup').add_command()
  vim.keymap.set('n', "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>", bufopts)
  vim.keymap.set('n', "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", bufopts)
  vim.keymap.set('v', "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", bufopts)
  vim.keymap.set('n', "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", bufopts)
  vim.keymap.set('v', "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", bufopts)
  vim.keymap.set('v', "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", bufopts)
  vim.keymap.set('n', "<leader>df", "<Cmd>lua require'jdtls'.test_class()<CR>", bufopts)
  vim.keymap.set('n', "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", bufopts)
end

local lsp_flags = {
  -- Nvim 0.7 default value
  debounce_text_changes = 150,
}

-- Require "hrsh7th/cmp-nvim-lua"
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local config = {
    on_attach = on_attach,
    cmd = cmd,
    root_dir = root_dir,
    capabilities = capabilities,
    setting = {
      java = { },
    },
    init_options = {
        bundles = bundles,
    },
    flags = lsp_flags,
}

require('jdtls').start_or_attach(config)
