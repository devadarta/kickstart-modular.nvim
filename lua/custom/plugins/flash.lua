local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'folke/flash.nvim',
}

local flash = require 'flash'

flash.setup {}

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jj', function() flash.jump() end, { desc = 'Flash Jump' })

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>jt', function() flash.treesitter() end, { desc = 'Flash Treesitter' })

vim.keymap.set('o', '<leader>jr', function() flash.remote() end, { desc = 'Flash Remote' })

vim.keymap.set({ 'o', 'x' }, '<leader>jR', function() flash.treesitter_search() end, { desc = 'Treesitter Search' })

vim.keymap.set({ 'c' }, '<c-s>', function() flash.toggle() end, { desc = 'Toggle Flash Search' })
