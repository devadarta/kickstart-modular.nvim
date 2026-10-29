-- ===========================================================================
-- [[ CUSTOM KEYMAPS ]]
-- ===========================================================================

local util = require 'custom.util'
local vk = vim.keymap

vk.set('n', '<leader>r', ':', { desc = 'Run command' })

-- z0…z9 to open folds to a certain level
for i = 0, 9 do
  vk.set('n', 'z' .. i, ':set fdl=' .. i .. '<CR>', { noremap = true, silent = false })
end

--
-- [[ COPY PATH || COPY FILENAME ]]
--
vk.set('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand '%')
  print 'Copied the relative path (with filename)'
end, { desc = 'Copy relative path' })
vk.set('n', '<leader>cP', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
  print 'Copied the absolute path (with filename)'
end, { desc = 'Copy absolute path' })
vk.set('n', '<leader>cf', function()
  vim.fn.setreg('+', vim.fn.expand '%:t')
  print 'Copied the filename'
end, { desc = 'Copy filename' })
vk.set('n', '<leader>cr', function()
  vim.fn.setreg('+', vim.fn.expand '%:h')
  print 'Copied the relative path without filename'
end, { desc = 'Copy rel path w/o filename' })
vk.set('n', '<leader>cR', function()
  vim.fn.setreg('+', vim.fn.expand '%:p:h')
  print 'Copied the absolute path without filename'
end, { desc = 'Copy abs path w/o filename' })

--
-- [[ WINDOW || BUFFER ]]
--
vk.set('n', '<leader>,,', '<C-^>', { desc = 'Go to last accessed buffer' })
vk.set('n', '<leader>-', '<cmd>split<cr>', { desc = 'Split window bellow' })
vk.set('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Split window right' })
vk.set('n', '<leader>w-', '<cmd>split<cr>', { desc = 'Split window bellow' })
vk.set('n', '<leader>w|', '<cmd>vsplit<cr>', { desc = 'Split window right' })
-- Save/quit buffers
vk.set('n', '<leader>ww', '<cmd>write<cr>', { desc = 'Save buffer' })
vk.set('n', '<leader>wq', '<cmd>wq<cr>', { desc = 'Save buffer and exit' }) -- Save and exit (ZZ)
vk.set('n', '<leader>wc', util.close_or_quit, { desc = 'Close window or quit' })

-- Center screen when jumping
vk.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vk.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vk.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vk.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- Better indenting in visual mode
vk.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vk.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Move lines up/down
vk.set({ 'n', 'x' }, '<M-j>', ':move +1<cr>', { desc = 'Move Line Down' })
vk.set({ 'n', 'x' }, '<M-k>', ':move -2<cr>', { desc = 'Move Line Up' })
vk.set('i', '<M-j>', '<C-o>:move +1<cr>', { desc = 'Move Line Down' })
vk.set('i', '<M-k>', '<C-o>:move -2<cr>', { desc = 'Move Line Up' })
-- This dont work very well
vk.set('v', '<M-j>', ":move '>+1<cr>gv=gv'", { desc = 'Move selection down' })
vk.set('v', '<M-k>', ":move '<-2<cr>gv=gv'", { desc = 'Move selection up' })

--
-- [[ TERMINAL ]]
--
vk.set('n', '<leader>tt', util.floating_terminal, { noremap = true, silent = true, desc = 'Floating terminal' })
vk.set('t', '<Esc>', util.close_floating_terminal, { noremap = true, silent = true, desc = 'Close floating terminal from terminal mode' })
vk.set('n', '<leader>tT', util.bottom_terminal, { desc = 'Bottom terminal' })
vim.api.nvim_set_keymap('t', '<C-n>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Normal mode on terminal' })

--
-- [[ TABS ]]
--
local opts = { silent = true }

-- New/Creation/Close
vk.set('n', '<leader><Tab>i', ':tabnew<CR>', vim.tbl_extend('force', opts, { desc = 'Insert empty Tab' }))
vk.set('n', '<leader><Tab>o', util.open_file_tab, { desc = 'Open in new Tab' })
vk.set('n', '<leader><Tab>c', ':tabclose<CR>', vim.tbl_extend('force', opts, { desc = 'Close Tab' }))

-- Navigation
vk.set('n', '<A-l>', ':tabnext<CR>', vim.tbl_extend('force', opts, { desc = 'Go to next Tab' })) -- Built-in gt
vk.set('n', '<A-h>', ':tabprevious<CR>', vim.tbl_extend('force', opts, { desc = 'Go to previous Tab' })) -- Built-in gT
vk.set('n', '<leader><Tab>t', 'g<Tab>', vim.tbl_extend('force', opts, { desc = 'Go to last accessed Tab' }))
vk.set('n', '<leader><Tab><Tab>', 'g<Tab>', vim.tbl_extend('force', opts, { desc = 'Go to last accessed Tab' }))

-- Quick tab access (Alt + number for first 9 tabs)
for i = 1, 9 do
  vk.set('n', '<A-' .. i .. '>', i .. 'gt', vim.tbl_extend('force', opts, { desc = 'Go to Tab ' .. i }))
end

-- Moving
vk.set('n', '<A-S-l>', util.move_tab_right, vim.tbl_extend('force', opts, { desc = 'Move Tab Right' }))
vk.set('n', '<A-S-h>', util.move_tab_left, vim.tbl_extend('force', opts, { desc = 'Move Tab left' }))

vk.set('i', '<Tab>', function() require('custom.tabout').smart_tab() end)
