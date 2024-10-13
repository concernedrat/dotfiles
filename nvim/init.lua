local vim = vim
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local Plug = vim.fn['plug#']

-- For init.lua
vim.opt.termguicolors = true
vim.opt.guifont = 'Fira Code'
vim.call('plug#begin')

Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
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
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'          -- Optional, for UI support
Plug 'Pocco81/DAPInstall.nvim'       -- Optional, easier installation for DAP adapters
Plug 'nicholasmata/nvim-dap-cs'
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
-- Lua
require('telescope').setup({})
require('onedark').load()
require('wayland-clipboard')
require('treesitter-config')
require('remaps')
local dap = require('dap')
local dapui = require("dapui")
dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local dap = require("dap")
local lspconfig_util = require("lspconfig.util")

-- Helper function to get the root directory
local function get_root_dir()
    return lspconfig_util.root_pattern(".sln", ".csproj", ".git")(vim.fn.getcwd())
end

-- Function to list files in a directory (helper function)
local function ls_dir(directory)
    local files = {}
    for filename in io.popen('ls "' .. directory .. '"'):lines() do
        table.insert(files, filename)
    end
    return files
end

-- Function to recompile the project if the user confirms
local function recompile_project()
    local should_recompile = vim.fn.input("Recompile project? (y/n): ", "n")
    if should_recompile:lower() == "y" then
        vim.cmd("!dotnet build")
    end
end

-- CoreCLR adapter configuration for .NET
dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}

-- DAP configuration for C#
dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        env = { ASPNETCORE_ENVIRONMENT = "Development" },
        args = {
            "--urls=http://localhost:5086",
            "--environment=Development",
        },
        program = function()
            -- Prompt the user to recompile
            recompile_project()

            -- Proceed to find the DLL
            local files = ls_dir(get_root_dir() .. "/bin/Debug/")
            if #files == 1 then
                local dotnet_dir = get_root_dir() .. "/bin/Debug/" .. files[1]
                files = ls_dir(dotnet_dir)
                for _, file in ipairs(files) do
                    if file:match(".*%.dll") then
                        return dotnet_dir .. "/" .. file
                    end
                end
            end
            return vim.fn.input("Path to dll: ", get_root_dir() .. "/bin/Debug/", "file")
        end,
    },
}

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- Create a wrapper function around the built-in `vim.lsp.buf.definition`
    local original_definition = vim.lsp.buf.definition
    vim.lsp.buf.definition = function(...)
        original_definition(...)
        -- Delay the NvimTreeFindFile command to ensure the buffer is loaded
        vim.defer_fn(function()
            vim.cmd('NvimTreeFindFile')
	    vim.cmd('wincmd p') -- Move to the previous window
        end, 50) -- Adjust delay (in milliseconds) as needed
    end
  lsp.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false,
  })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup({})
require('lspconfig').omnisharp.setup({})
-- For Ruby LSP
require('lspconfig').ruby_lsp.setup({})
lsp.setup()
