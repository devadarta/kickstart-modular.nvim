local function gh(repo) return 'https://github.com/' .. repo end
local lz = require 'custom.lazy'

-- nvim-treesitter e mini.nvim já são adicionados pelos seus próprios módulos
lz.add { gh 'MeanderingProgrammer/render-markdown.nvim' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  once = true,
  group = vim.api.nvim_create_augroup('lazy-render-markdown', { clear = true }),
  callback = function(ev)
    lz.once('render-markdown', function()
      vim.cmd.packadd 'render-markdown.nvim'
      require('render-markdown').setup {}
    end)
    -- O FileType deste buffer já disparou antes do plugin registrar seus autocmds.
    -- Reenvia o evento só para este buffer, para ele anexar agora.
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ev.buf) then vim.api.nvim_exec_autocmds('FileType', { buffer = ev.buf, modeline = false }) end
    end)
  end,
})
