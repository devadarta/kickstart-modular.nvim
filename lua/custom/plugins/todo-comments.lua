local function gh(repo) return 'https://github.com/' .. repo end
local lz = require 'custom.lazy'

lz.add { gh 'folke/todo-comments.nvim' }

lz.on_event('todo-comments', { 'BufReadPre', 'BufNewFile' }, function()
  lz.pack('plenary.nvim', 'todo-comments.nvim') -- plenary é dependência do todo-comments
  require('todo-comments').setup { signs = false }
end)

-- vim: ts=2 sts=2 sw=2 et
