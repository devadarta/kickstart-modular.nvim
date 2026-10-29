-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

-- vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'Explorer (neo-tree) ', silent = true })
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle reveal float<CR>', { desc = 'NeoTree float reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      popup = {
        size = { width = '75%' },
      },
      -- mappings = {
      --   ['\\'] = 'close_window',
      -- },
    },
  },
}
