local function gh(repo) return 'https://github.com/' .. repo end
local lz = require 'custom.lazy'

lz.add { gh 'NMAC427/guess-indent.nvim' }

-- BufReadPre (e não BufReadPost): o setup registra o autocmd do plugin ANTES
-- de o BufReadPost do primeiro arquivo disparar, então o primeiro buffer também é detectado.
lz.on_event('guess-indent', { 'BufReadPre', 'BufNewFile' }, function()
  vim.cmd.packadd 'guess-indent.nvim'
  require('guess-indent').setup {}
end)

-- vim: ts=2 sts=2 sw=2 et
