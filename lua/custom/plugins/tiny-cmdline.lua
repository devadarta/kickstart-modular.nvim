require('vim._core.ui2').enable {}

vim.o.cmdheight = 0
vim.g.tiny_cmdline = { width = { value = '35%' }, position = { x = '50%', y = '13%' } }
vim.pack.add { 'https://github.com/rachartier/tiny-cmdline.nvim' }
