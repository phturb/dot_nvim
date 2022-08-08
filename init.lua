local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

-- Packer auto-compile
vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd( { "BufWritePost" }, {
  group = "packer_user_config",
  pattern = { "plugins.lua" },
  callback = function()
    vim.cmd("source <afile> | PackerCompile")
  end,
})

local function load_source(src)
  local ok, loaded = pcall(require, src)
  if not ok then vim.api.nvim_err_writeln("Failed to load " .. src .. "\n" .. loaded) end
end

-- Import the options
load_source("options")
-- Import colors
load_source("colors")
-- Import the plugins setting
load_source("plugins")
-- Import the key mapping
load_source("mapping")
-- Import LSP
load_source("lsp")
-- Import DAP
load_source("dap-config")
-- Import autocmd
load_source("autocmd")
