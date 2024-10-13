vim.api.nvim_set_keymap('n', '<C-m>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })


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
