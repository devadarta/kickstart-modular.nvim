-- Abre no Root Dir (Tenta pegar a raiz do LSP ou fallback para o CWD)
-- vim.keymap.set('n', '<leader>e', function()
--   local root = vim.lsp.buf.list_workspace_folders()[1] or vim.uv.cwd()
--   require('neo-tree.command').execute { toggle = true, dir = root }
-- end, { desc = 'Neo-tree (Root Dir)' })
--
-- -- Abre no CWD (Diretório onde o Neovim está rodando)
-- vim.keymap.set('n', '<leader>E', function() require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd() } end, { desc = 'Neo-tree (CWD)' })

vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'Explorer (neo-tree) ', silent = true })
