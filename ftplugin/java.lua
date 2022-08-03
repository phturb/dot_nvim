local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
local home = os.getenv('HOME')

local java_home = os.getenv('JAVA_HOME')
local lsp_home = home .. "/.local/share/nvim/lsp"
local jar = lsp_home .. "/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
local jdt_config = lsp_home .. "/jdt-language-server/config_mac"
local lombok = lsp_home .. "/jdt-language-server/lombok.jar"
local workspace = lsp_home .. "/workspace/" .. vim.fn.fnamemodify(root_dir, ':p:h:t')

local cmd = {
  java_home .. "/bin/java",
  "-javaagent:" .. lombok,
  "-Xbootclasspath/a:" .. lombok,
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

local bundles = {
  vim.fn.glob(lsp_home .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(lsp_home .. "/vscode-java-test/server/*.jar"), "\n"))
local on_attach = function(client, bufnr)
-- This is taken from the plugins.lsp file
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>ll', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
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
  debounce_text_changes = 150,
}

local config = {
    on_attach = on_attach,
    cmd = cmd,
    root_dir = root_dir,
    setting = {
      java = { },
    },
    init_options = {
        bundles = bundles,
    },
    flags = lsp_flags,
}

require('jdtls').start_or_attach(config)
