local wk = require 'which-key'
wk.setup {
  preset = 'helix',
}
wk.add {
  { '<leader>r', icon = '' },
  { '<leader>b', group = '[b] Buffers' },
  { '<leader>w', group = '[w] Write (save) window' },
  { '<leader>q', desc = '[q] Open diagnostic Quickfix list' },
  { '<leader>f', desc = '[f] Format buffer' },
  -- {
  --   '<leader>?',
  --   function() require('which-key').show { global = false } end,
  --   desc = '[?] Buffer Local Keymaps (which-key)',
  -- },
  {
    '<leader>b',
    group = '[b] Buffers',
    expand = function() return require('which-key.extras').expand.buf() end,
  },
}
