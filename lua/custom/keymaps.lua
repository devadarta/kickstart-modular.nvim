-- ===========================================================================
-- [[ CUSTOM KEYMAPS ]]
-- ===========================================================================

local util = require 'custom.util'

vim.keymap.set('n', '<leader>r', ':', { desc = 'Run command' })

-- z0…z9 to open folds to a certain level
for i = 0, 9 do
  vim.keymap.set('n', 'z' .. i, ':set fdl=' .. i .. '<CR>', { noremap = true, silent = false })
end

--
-- [[ WINDOW || BUFFER ]]
--
vim.keymap.set('n', '<leader>,,', '<C-^>', { desc = 'Go to last accessed buffer' })
vim.keymap.set('n', '<leader>-', '<cmd>hsplit<cr>', { desc = 'Split window bellow' })
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Split window right' })
vim.keymap.set('n', '<leader>w-', '<cmd>hsplit<cr>', { desc = 'Split window bellow' })
vim.keymap.set('n', '<leader>w|', '<cmd>vsplit<cr>', { desc = 'Split window right' })
-- Save/quit buffers
vim.keymap.set('n', '<leader>ww', '<cmd>write<cr>', { desc = 'Save buffer' })
vim.keymap.set('n', '<leader>wq', '<cmd>wq<cr>', { desc = 'Save buffer and exit' }) -- Save and exit (ZZ)
vim.keymap.set('n', '<leader>wc', util.close_or_quit, { desc = 'Close window or quit' })

-- Center screen when jumping
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Move lines up/down
vim.keymap.set({ 'n', 'x' }, '<M-j>', ':move +1<cr>', { desc = 'Move Line Down' })
vim.keymap.set({ 'n', 'x' }, '<M-k>', ':move -2<cr>', { desc = 'Move Line Up' })
vim.keymap.set('i', '<M-j>', '<C-o>:move +1<cr>', { desc = 'Move Line Down' })
vim.keymap.set('i', '<M-k>', '<C-o>:move -2<cr>', { desc = 'Move Line Up' })
-- This dont work very well
vim.keymap.set('v', '<M-j>', ":move '>+1<cr>gv=gv'", { desc = 'Move selection down' })
vim.keymap.set('v', '<M-k>', ":move '<-2<cr>gv=gv'", { desc = 'Move selection up' })

--
-- [[ TERMINAL ]]
--
vim.keymap.set('n', '<leader>tt', util.floating_terminal, { noremap = true, silent = true, desc = 'Floating terminal' })
vim.keymap.set('t', '<Esc>', util.close_floating_terminal, { noremap = true, silent = true, desc = 'Close floating terminal from terminal mode' })
vim.keymap.set('n', '<leader>tT', util.bottom_terminal, { desc = 'Bottom terminal' })
vim.api.nvim_set_keymap('t', '<C-n>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Normal mode on terminal' })

--
-- [[ TABS ]]
--
local opts = { silent = true }

-- New/Creation
vim.keymap.set('n', '<leader><Tab>i', ':tabnew<CR>', vim.tbl_extend('force', opts, { desc = 'Insert empty Tab' }))
vim.keymap.set('n', '<leader><Tab>o', util.open_file_tab, { desc = 'Open in new Tab' })

-- Navigation
vim.keymap.set('n', '<A-l>', ':tabnext<CR>', vim.tbl_extend('force', opts, { desc = 'Go to next Tab' })) -- Built-in gt
vim.keymap.set('n', '<A-h>', ':tabprevious<CR>', vim.tbl_extend('force', opts, { desc = 'Go to previous Tab' })) -- Built-in gT
vim.keymap.set('n', '<leader><Tab>t', 'g<Tab>', vim.tbl_extend('force', opts, { desc = 'Go to last accessed Tab' }))
vim.keymap.set('n', '<leader><Tab><Tab>', 'g<Tab>', vim.tbl_extend('force', opts, { desc = 'Go to last accessed Tab' }))

-- Quick tab access (Alt + number for first 9 tabs)
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', i .. 'gt', vim.tbl_extend('force', opts, { desc = 'Go to Tab ' .. i }))
end

-- Moving
vim.keymap.set('n', '<A-S-l>', util.move_tab_right, vim.tbl_extend('force', opts, { desc = 'Move Tab Right' }))
vim.keymap.set('n', '<A-S-h>', util.move_tab_left, vim.tbl_extend('force', opts, { desc = 'Move Tab left' }))

vim.keymap.set('i', '<Tab>', function() require('custom.tabout').smart_tab() end)
