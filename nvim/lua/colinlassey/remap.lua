local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>pv", vim.cmd.Ex, opts)

keymap("n", "<leader>sp", vim.cmd.split, opts)
keymap("n", "<leader>sv", vim.cmd.vsplit, opts)

keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

keymap("x", "<leader>p", [["_dP]], opts)

keymap({"n", "v"}, "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]], opts)

keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)
keymap("n", "<leader>f", vim.lsp.buf.format, opts)

keymap("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

keymap("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/colinlassey/packer.lua<CR>", opts)
keymap("n", "<leader>so", "<cmd>source ~/.config/nvim/lua/colinlassey/packer.lua<CR>", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
