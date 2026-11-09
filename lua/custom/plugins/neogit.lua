local function gh(repo) return 'https://github.com/' .. repo end
local lz = require 'custom.lazy'

lz.add {
  gh 'sindrets/diffview.nvim',
  gh 'NeogitOrg/neogit',
}

local function N()
  lz.once('neogit', function()
    lz.telescope()
    lz.pack('diffview.nvim', 'neogit')
    require('neogit').setup { integrations = { diffview = true } }
  end)
end

local function cmd(c)
  return function()
    N()
    vim.cmd(c)
  end
end
local function tel(picker)
  return function()
    N()
    lz.telescope()[picker]()
  end
end

local kmap = vim.keymap
-- Atalhos dentro do Neogit UI
-- 's' (em cima de um arquivo ou hunk): Faz o stage (adiciona ao commit) linha por linha ou arquivo por arquivo.
-- 'u': Faz o unstage (remove do commit).
-- 'cc': Abre direto a janela de commit (se você não quiser usar o atalho separado).
-- 'p': Abre o menu de Push.
-- 'f': Abre o menu de Fetch / Pull.
-- 'b': Abre o menu de Branch (para criar, deletar ou alternar branches rapidamente).
-- 'X': Abre o menu de Reset (para descartar alterações com segurança).
kmap.set('n', '<leader>gs', cmd 'Neogit', { desc = 'Open Neogit UI' })
kmap.set('n', '<leader>gg', cmd 'Neogit commit', { desc = 'Neogit Commit' })
kmap.set('n', '<leader>gc', cmd 'Neogit commit', { desc = 'Neogit Commit' })
kmap.set('n', '<leader>gd', cmd 'DiffviewOpen', { desc = 'Diff View' })
kmap.set('n', '<leader>gh', cmd 'DiffviewFileHistory %', { desc = 'File History' })
kmap.set('n', '<leader>gH', cmd 'DiffviewFileHistory', { desc = 'Repo History' })
-- <C-a> : Cria branch <C-d> : Apaga branch
kmap.set('n', '<leader>gB', cmd 'Neogit branch', { desc = 'Neogit Branch Menu' })
kmap.set('n', '<leader>gS', tel 'git_status', { desc = 'Git Status File' })
kmap.set('n', '<leader>gb', tel 'git_branches', { desc = 'Git Branches (Telescope)' })
kmap.set('n', '<leader>gC', tel 'git_commits', { desc = 'Git Commits (Repo)' })
