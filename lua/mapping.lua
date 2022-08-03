require("utils")

-- General prefix
local file_prefix = "f"
local git_prefix = "g"
local search_prefix = "s"
local find_prefix = "f"
local session_prefix = "S"
local lsp_prefix = "l"
local zen_prefix = "z"

-- General Helper mapping
nmap("<leader>w", "<cmd>w<cr>", "Save")
nmap("<leader>q", "<cmd>q<cr>", "Quit")
nmap("<leader>" .. file_prefix .. "n", "<cmd>enew<cr>", "New File")
nmap("<C-s>", "<cmd>w!<cr>", "Force Write")
nmap("<C-q>", "<cmd>q!<cr>", "Force Quit")

-- Packer mapping
local packer_nmap = function(key, cmd, desc)
  nmap("<leader>p" .. key, "<cmd>Packer" .. cmd .. "<cr>", desc)
end
packer_nmap("c", "Compile", "Packer Compile")
packer_nmap("i", "Install", "Packer Install")
packer_nmap("s", "Sync", "Packer Sync")
packer_nmap("S", "Status", "Packer Status")
packer_nmap("u", "Update", "Packer Update")

-- NeoTree mapping
nmap("<leader>e", "<cmd>Neotree toggle<cr>", "Toggle NeoTree Explorer")
nmap("<leader>o", "<cmd>Neotree focus<cr>", "Focus NeoTree Explorer")

-- Telescope
map('n', "<leader>" .. find_prefix .. "w", function() require("telescope.builtin").live_grep() end, "Search words")
map('n', "<leader>" .. find_prefix .. "W", function() require("telescope.builtin").live_grep({ additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,}) end, "Search words in all files")
map('n', "<leader>" .. git_prefix .. "t", function() require("telescope.builtin").git.status() end, "Git Status")
map('n', "<leader>" .. git_prefix .. "b", function() require("telescope.builtin").git_branches() end, "Git branches")
map('n', "<leader>" .. git_prefix .. "c", function() require("telescope.builtin").git_commits() end, "Git commits")
map('n', "<leader>" .. find_prefix .. "f", function() require("telescope.builtin").find_files() end, "Find files")
map('n', "<leader>" .. find_prefix .. "F", function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end, "Find all files")
map('n', "<leader>" .. find_prefix .. "b", function() require("telescope.builtin").buffers() end, "Search buffers")
map('n', "<leader>" .. find_prefix .. "h", function() require("telescope.builtin").help_tags() end, "Search help")
map('n', "<leader>" .. find_prefix .. "m", function() require("telescope.builtin").marks() end, "Search marks")
map('n', "<leader>" .. find_prefix .. "o", function() require("telescope.builtin").oldfiles() end, "Search history")
map('n', "<leader>" .. find_prefix .. "c", function() require("telescope.builtin").grep_string() end, "Search word under cursor")
map('n', "<leader>" .. search_prefix .. "h", function() require("telescope.builtin").help_tags() end, "Search help")
map('n', "<leader>" .. search_prefix .. "m", function() require("telescope.builtin").man_pages() end, "Search man")
map('n', "<leader>" .. search_prefix .. "n", function() require("telescope").extensions.notify.notify() end, "Search notifications")
map('n', "<leader>" .. search_prefix .. "r", function() require("telescope.builtin").registers() end, "Search registers")
map('n', "<leader>" .. search_prefix .. "k", function() require("telescope.builtin").keymap() end, "Search keymaps")
map('n', "<leader>" .. search_prefix .. "c", function() require("telescope.builtin").commands() end, "Search commands")
map('n', "<leader>" .. lsp_prefix .. "s", function() require("telescope").extensions.aerial.aerial() end, "Search symbols")
map('n', "<leader>" .. lsp_prefix .. "R", function() require("telescope.builtin").lsp_references() end, "Search references")
map('n', "<leader>" .. lsp_prefix .. "D", function() require("telescope.builtin").diagnostics() end, "Search diagnostics")

-- Indent
map('v', "<", "<gv", "Indent")
map('v', ">", ">gv", "Unindent")

-- Buffer
nmap("<leader>c", "<cmd>Bdelete<cr>", "Close window/buffer")
nmap("<S-l>", "<cmd>BufferLineCycleNext<cr>", "Next buffer tab")
nmap("<S-h>", "<cmd>BufferLineCyclePrev<cr>", "Previous buffer tab")
nmap(">b", "<cmd>BufferLineMoveNext<cr>", "Move buffer tab right")
nmap("<b", "<cmd>BufferLineMovePrev<cr>", "Move buffer tab left")

-- Comment
map("n", "<leader>/", function() require("Comment.api").toggle_current_linewise() end, "Comment line")
vmap("<leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>", "Toggle comment line")

-- GitSigns
map('n', "<leader>" .. git_prefix .. "j", function() require("gitsigns").next_hunk() end, "Next git hunk")
map('n', "<leader>" .. git_prefix .. "k", function() require("gitsigns").prev_hunk() end, "Previous git hunk")
map('n', "<leader>" .. git_prefix .. "p", function() require("gitsigns").preview_hunk() end, "Preview git hunk")
map('n', "<leader>" .. git_prefix .. "h", function() require("gitsigns").reset_hunk() end, "Reset git hunk")
map('n', "<leader>" .. git_prefix .. "l", function() require("gitsigns").blame_line() end, "View git blame")
map('n', "<leader>" .. git_prefix .. "r", function() require("gitsigns").reset_buffer() end, "Reset git buffer")
map('n', "<leader>" .. git_prefix .. "s", function() require("gitsigns").stage_hunk() end, "Stage git hunk")
map('n', "<leader>" .. git_prefix .. "u", function() require("gitsigns").undo_stage_hunk() end, "Unstage git hunk")
map('n', "<leader>" .. git_prefix .. "d", function() require("gitsigns").diffthis() end, "View git diff")

-- Session Manager
nmap("<leader>" .. session_prefix .. "l", "<cmd>SessionManager! load_last_session<cr>", "Load last session")
nmap("<leader>" .. session_prefix .. "s", "<cmd>SessionManager! save_current_session<cr>", "Save current session")
nmap("<leader>" .. session_prefix .. "d", "<cmd>SessionManager! delete_session<cr>", "Delete session")
nmap("<leader>" .. session_prefix .. ".", "<cmd>SessionManager! load_session<cr>", "Search sessions")

-- Smart Splits
map('n', "<C-h>", function() require("smart-splits").move_cursor_left() end, "Move to left split")
map('n', "<C-j>", function() require("smart-splits").move_cursor_down() end, "Move to left split")
map('n', "<C-k>", function() require("smart-splits").move_cursor_up() end, "Move to left split")
map('n', "<C-l>", function() require("smart-splits").move_cursor_right() end, "Move to left split")

map('n', "<C-Up>", function() require("smart-splits").resize_up() end, "Resize split up")
map('n', "<C-Down>", function() require("smart-splits").resize_down() end, "Resize split up")
map('n', "<C-Left>", function() require("smart-splits").resize_left() end, "Resize split up")
map('n', "<C-Right>", function() require("smart-splits").resize_right() end, "Resize split up")

-- SymbolsOutline
nmap("<leader>" .. lsp_prefix .. "S", "<cmd>AerialToggle<cr>", "Symbols outline explorer")

-- Mason
nmap("<leader>m", "<cmd>Mason<cr>", "Mason")

-- True Zen
nmap("<leader>" .. zen_prefix .. "n", "<cmd>TZNarrow<cr>", "Narrow zend mode")
vmap("<leader>" .. zen_prefix .. "n", "<cmd>'<,'>TZNarrow<cr>", "Narrow zend mode")
nmap("<leader>" .. zen_prefix .. "f", "<cmd>TZFocus<cr>", "Focus zen mode")
nmap("<leader>" .. zen_prefix .. "m", "<cmd>TZMinimalist<cr>", "Minimalist zend mode")
nmap("<leader>" .. zen_prefix .. "a", "<cmd>TZAtaraxis<cr>", "Ataraxis zend mode")

-- LSP
-- nmap("<leader>e", vim.diagnostic.open_float, "Open diagnostic")
nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic")

