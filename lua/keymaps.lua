-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[q] Open dignostic Quickfix list' })

-- Exit terminl mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
--
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- vim: ts=2 sts=2 sw=2 et

-- ===========================================================================
-- [[ CUSTOM KEYMAPS ]]
-- ===========================================================================
local util = require 'custom.util'

vim.keymap.set('n', '<leader>r', ':', { desc = '[r] Run command' })
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Go to last accessed buffer' })

-- Save/quit buffers
vim.keymap.set('n', '<leader>ww', '<cmd>write<cr>', { desc = 'Save buffer' })
vim.keymap.set('n', '<leader>wq', '<cmd>wq<cr>', { desc = 'Save buffer and exit' }) -- Save and exit (ZZ)
vim.keymap.set('n', '<leader>c', util.close_or_quit, { desc = '[c] Close window or quit' })

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
-- [[ KEYMAPS TERMINAL ]]
--
vim.keymap.set('n', '<leader>ter', util.floating_terminal, { noremap = true, silent = true, desc = 'Floating terminal' })
vim.keymap.set('t', '<Esc>', util.close_floating_terminal, { noremap = true, silent = true, desc = 'Close floating terminal from terminal mode' })
vim.keymap.set('n', '<leader>T', util.bottom_terminal, { desc = '[T] Bottom terminal' })
vim.api.nvim_set_keymap('t', '<C-n>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Normal mode on terminal' })

--
-- [[ KEYMAPS TABS ]]
--
local opts = { silent = true }

-- Creation
vim.keymap.set('n', '<leader>ti', ':tabnew<CR>', vim.tbl_extend('force', opts, { desc = 'Insert empty TAB' }))
vim.keymap.set('n', '<leader>to', util.open_file_tab, { desc = 'Open in new TAB' })

-- Navigation
vim.keymap.set('n', '<A-l>', ':tabnext<CR>', vim.tbl_extend('force', opts, { desc = 'Go to next TAB' })) -- Built-in gt
vim.keymap.set('n', '<A-h>', ':tabprevious<CR>', vim.tbl_extend('force', opts, { desc = 'Go to previous TAB' })) -- Built-in gT
vim.keymap.set('n', '<leader>tt', 'g<Tab>', vim.tbl_extend('force', opts, { desc = 'Go to last accessed TAB' }))

-- Quick tab access (Alt + number for first 9 tabs)
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', i .. 'gt', vim.tbl_extend('force', opts, { desc = 'Go to TAB ' .. i }))
end

-- Moving
vim.keymap.set('n', '<A-S-l>', util.move_tab_right, vim.tbl_extend('force', opts, { desc = 'Move TAB Right' }))
vim.keymap.set('n', '<A-S-h>', util.move_tab_left, vim.tbl_extend('force', opts, { desc = 'Move TAB left' }))
