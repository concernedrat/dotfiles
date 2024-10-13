local vim = vim
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local Plug = vim.fn['plug#']

-- For init.lua
vim.opt.termguicolors = true
vim.opt.guifont = 'Fira Code'
vim.call('plug#begin')

-- LSP
Plug 'neovim/nvim-lspconfig'             -- Required
Plug 'williamboman/mason.nvim'           -- Optional
Plug 'williamboman/mason-lspconfig.nvim' -- Optional

-- Autocompletion
Plug 'hrsh7th/nvim-cmp'       -- Required
Plug 'hrsh7th/cmp-nvim-lsp'   -- Required
Plug 'L3MON4D3/LuaSnip'       -- Required
Plug('VonHeikemen/lsp-zero.nvim', { ['branch'] = 'v2.x' })
-- Rustaceanvim
Plug('mrcjkb/rustaceanvim')

-- For Debugging
Plug('mfussenegger/nvim-dap')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('tpope/vim-sensible')
Plug('glepnir/galaxyline.nvim' , { ['branch'] = 'main' })
Plug('navarasu/onedark.nvim')

-- If you want to display icons, then use one of these plugins:
Plug('nvim-tree/nvim-web-devicons') -- lua
Plug('ryanoasis/vim-devicons')       -- vimscript

-- nvim-tree
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-tree/nvim-tree.lua')

-- Copilot
Plug('github/copilot.vim')

vim.call('plug#end')
-- Run PlugInstall if needed
-- vim.cmd [[PlugInstall]]

require('galaxyline-config')
require('nvimtree-config')
require('remaps')
-- Lua
require('onedark').load()
require('wayland-clipboard')
require('treesitter-config')
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false
  })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').omnisharp.setup({})
-- For Ruby LSP
require('lspconfig').ruby_lsp.setup({})
lsp.setup()
