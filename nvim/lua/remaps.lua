vim.api.nvim_set_keymap('n', '<C-H>', [[:lua CloseAllExceptCurrentAndMenu()<CR>]], { noremap = true, silent = true })

-- Define the Lua function to close all buffers except the current one and the NvimTree buffer
function CloseAllExceptCurrentAndMenu()
    local current_buf = vim.api.nvim_get_current_buf()

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        -- Check if the buffer is neither the current buffer nor the NvimTree buffer
        if buf ~= current_buf and not buf_name:match("NvimTree") and vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
end

vim.api.nvim_set_keymap('n', '<C-m>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Telescope remaps
--
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Remaps for buffer navigation
vim.api.nvim_set_keymap('n', '<C-]>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-[>', ':bprev<CR>', { noremap = true, silent = true })

-- Remaps for debugging with DAP

-- Set a breakpoint
vim.api.nvim_set_keymap('n', '<F9>', ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })

-- Continue execution (run/resume)
vim.api.nvim_set_keymap('n', '<F5>', ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })

-- Step over (next line)
vim.api.nvim_set_keymap('n', '<F10>', ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })

-- Step into (enter function)
vim.api.nvim_set_keymap('n', '<F11>', ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })

-- Step out (exit function)
vim.api.nvim_set_keymap('n', '<F12>', ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })

-- Open DAP REPL (for evaluating variables, expressions, etc.)
vim.api.nvim_set_keymap('n', '<leader>dr', ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })

-- Open DAP UI (widget for inspecting state)
vim.api.nvim_set_keymap('n', '<leader>du', ":lua require'dap.ui.widgets'.hover()<CR>", { noremap = true, silent = true })

-- Clear all breakpoints
vim.api.nvim_set_keymap('n', '<leader>db', ":lua require'dap'.clear_breakpoints()<CR>", { noremap = true, silent = true })

-- List all breakpoints
vim.api.nvim_set_keymap('n', '<leader>dl', ":lua require'dap'.list_breakpoints()<CR>", { noremap = true, silent = true })
