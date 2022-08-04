
-- NeoTree on start
vim.api.nvim_create_augroup("neotree_start", { clear = true })
vim.api.nvim_create_autocmd( { "BufEnter" }, {
  group = "neotree_start",
  callback = function()
      local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
      if stats and stats.type == "directory" then require("neo-tree.setup.netrw").hijack() end
  end,
})

-- Dashboard on start
vim.api.nvim_create_augroup("alpha_settings", {clear = true})
vim.api.nvim_create_autocmd( {"FileType"}, {
  desc = "Disable tabline for alpha",
  group = "alpha_settings",
  pattern = "alpha",
  callback = function()
    local prev_showtabline = vim.opt.showtabline
    vim.opt.showtabline = 0
    vim.api.nvim_create_autocmd({"BufUnload"}, {
      pattern = "<buffer>",
      callback = function() vim.opt.showtabline = prev_showtabline end,
    })
  end,
})

vim.api.nvim_create_autocmd( {"FileType"}, {
  desc = "Disable statusline for alpha",
  group = "alpha_settings",
  pattern = "alpha",
  callback = function()
    local prev_status = vim.opt.laststatus
    vim.opt.laststatus = 0
    vim.api.nvim_create_autocmd({"BufUnload"}, {
      pattern = "<buffer>",
      callback = function() vim.opt.laststatus = prev_status end,
    })
  end,
})
vim.api.nvim_create_autocmd( {"VimEnter"}, {
  desc = "Start Alpha when vim is opened with no arguments",
  group = "alpha_settings",
  callback = function()
    -- optimized start check from https://github.com/goolord/alpha-nvim
    local alpha_avail, alpha = pcall(require, "alpha")
    if alpha_avail then
      local should_skip = false
      if vim.fn.argc() > 0 or vim.fn.line2byte "$" ~= -1 or not vim.o.modifiable then
        should_skip = true
      else
        for _, arg in pairs(vim.v.argv) do
          if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
            should_skip = true
            break
          end
        end
      end
      if not should_skip then alpha.start(true) end
    end
  end,
})
