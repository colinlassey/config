require('colinlassey');
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local cmp = require("cmp")
local luasnip = require("luasnip")
local builtin = require('telescope.builtin')

-- Opts
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remaps
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

keymap("n", "<leader>gs", vim.cmd.Git, opts)

keymap("n", "<leader>u", vim.cmd.UndotreeToggle, opts)

-- Nvim-tree
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Packer and plugins
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ({
	'folke/tokyonight.nvim',
	as = 'tokyonight',
	config = function()
		vim.cmd('colorscheme tokyonight')
	end
  })

  use('nvim-tree/nvim-web-devicons')
  use('nvim-tree/nvim-tree.lua')
  use('christoomey/vim-tmux-navigator')
  use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use {
	  'prettier/vim-prettier',
	  run = 'yarn install --frozen-lockfile --production',
	  ft = {'javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'}
  }

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},
		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
	 	  {'rafamadriz/friendly-snippets'},
	}
}

-- Harpoon
keymap("n", "<leader>a", mark.add_file)
keymap("n", "<C-e>", ui.toggle_quick_menu)

keymap("n", "<C-u>", function() ui.nav_file(1) end)
keymap("n", "<C-i>", function() ui.nav_file(2) end)
keymap("n", "<C-o>", function() ui.nav_file(3) end)

-- LSP
require("luasnip.loaders.from_vscode")

cmp.setup({
	completion = {
		completeopt = "menu, menuone, preview, noselct",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	}
})
mapping = cmp.mapping.preset.insert({
	["<C-p>"] = cmp.mapping.select_prev_item(),
	["<C-n>"] = cmp.mapping.select_next_item(),
	["<C-y>"] = cmp.mapping.confirm({ select = false }),
	["<C-Space>"] = cmp.mapping.complete(),
})
sources = cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = "luasnip" },
	{ name = "buffer" },
	{ name = "path" },
})

-- Telescope
keymap('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<C-p>', builtin.git_files, { desc = 'Git find files' })
keymap('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "typescript", "python", "html", "css" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

   additional_vim_regex_highlighting = false,
  },
}
end)
