local wk = require 'which-key'
wk.setup {
  preset = 'helix',
}
wk.add {
  { '<leader>e', icon = '󰙅' },
  { '<leader>r', icon = '' },
  { '<leader>?', function() require('which-key').show { global = false } end, desc = 'Buffer keymaps (which-key)' },
  -- Groups
  { '<leader>,', group = 'Buffers', expand = function() return require('which-key.extras').expand.buf() end },
  { '<leader>j', group = 'Flash', icon = '󰛕' },
  { '<leader>w', group = 'Window' },
  { '<leader><Tab>', group = 'Tab' },
}
