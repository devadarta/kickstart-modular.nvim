local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'sindrets/diffview.nvim',
  gh 'NeogitOrg/neogit',
}

require('neogit').setup {
  integrations = { diffview = true },
}

local kmap = vim.keymap
kmap.set('n', '<leader>gs', '<cmd>Neogit<cr>', { desc = 'Open Neogit UI' })
-- Atalhos dentro do Neogit UI
-- 's' (em cima de um arquivo ou hunk): Faz o stage (adiciona ao commit) linha por linha ou arquivo por arquivo.
-- 'u': Faz o unstage (remove do commit).
-- 'cc': Abre direto a janela de commit (se você não quiser usar o atalho separado).
-- 'p': Abre o menu de Push.
-- 'f': Abre o menu de Fetch / Pull.
-- 'b': Abre o menu de Branch (para criar, deletar ou alternar branches rapidamente).
-- 'X': Abre o menu de Reset (para descartar alterações com segurança).

kmap.set('n', '<leader>gg', '<cmd>Neogit commit<cr>', { desc = 'Neogit Commit' })
kmap.set('n', '<leader>gc', '<cmd>Neogit commit<cr>', { desc = 'Neogit Commit' })
kmap.set('n', '<leader>gS', function() require('telescope.builtin').git_status() end, { desc = 'Git Status File' })
kmap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Diff View' })
kmap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = 'File History' })
kmap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<CR>', { desc = 'Repo History' })
kmap.set('n', '<leader>gb', function() require('telescope.builtin').git_branches() end, { desc = 'Git Branches (Telescope)' })
-- Atalhos:
-- <C-a> : Cria branch
-- <C-d> : Apaga branch
kmap.set('n', '<leader>gB', '<cmd>Neogit branch<CR>', { desc = 'Neogit Branch Menu' })
kmap.set('n', '<leader>gC', function() require('telescope.builtin').git_commits() end, { desc = 'Git Commits (Repo)' })
