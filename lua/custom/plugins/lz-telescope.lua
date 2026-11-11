--
-- Versão customizada com LazyLoading de kickstart/plugins/telescopej.lua
--

local function gh(repo) return 'https://github.com/' .. repo end
local lz = require 'custom.lazy'

---@type (string|vim.pack.Spec)[]
local telescope_plugins = {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
}
if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

-- NOTE: You can install multiple plugins at once
lz.add(telescope_plugins)

local function T()
  lz.once('telescope', function()
    lz.pack('plenary.nvim', 'telescope.nvim', 'telescope-ui-select.nvim', 'telescope-fzf-native.nvim')

    require('telescope').setup {
      defaults = {
        path_display = { 'filename_first' },
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
    }
    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
  end)
  return require 'telescope.builtin'
end

-- Se algo chamar vim.ui.select (ex.: `gra`) antes do Telescope carregar,
-- carrega o Telescope (a extensão ui-select substitui o vim.ui.select) e repete a chamada.
do
  local default_select = vim.ui.select
  vim.ui.select = function(...)
    vim.ui.select = default_select
    T()
    return vim.ui.select(...)
  end
end

-- Comando :Telescope disponível sem carregar nada antes
vim.api.nvim_create_user_command('Telescope', function(opts)
  T()
  vim.cmd('Telescope ' .. opts.args)
end, { nargs = '*' })

local function map(lhs, picker, desc, mode)
  vim.keymap.set(mode or 'n', lhs, function() T()[picker]() end, { desc = desc })
end

map('<leader>sh', 'help_tags', 'Search [H]elp')
map('<leader>sk', 'keymaps', 'Search [K]eymaps')
map('<leader>sf', 'find_files', 'Search [F]iles')
map('<leader>ss', 'builtin', 'Search Select Telescope')
map('<leader>sw', 'grep_string', 'Search current [W]ord', { 'n', 'v' })
map('<leader>sg', 'live_grep', 'Search by [G]rep')
map('<leader>sd', 'diagnostics', 'Search [D]iagnostics')
map('<leader>sr', 'resume', 'Search [R]esume')
map('<leader>s.', 'oldfiles', 'Search Recent Files')
map('<leader>sc', 'commands', 'Search [C]ommands')
map('<leader><leader>', 'buffers', 'Find existing buffers')

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
-- If you later switch picker plugins, this is where to update these mappings.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local function lmap(lhs, picker, desc)
      vim.keymap.set('n', lhs, function() T()[picker]() end, { buffer = event.buf, desc = desc })
    end
    lmap('grr', 'lsp_references', '[G]oto [R]eferences')
    lmap('gri', 'lsp_implementations', '[G]oto [I]mplementation')
    lmap('grd', 'lsp_definitions', '[G]oto [D]efinition')
    lmap('gO', 'lsp_document_symbols', 'Open Document Symbols')
    lmap('gW', 'lsp_dynamic_workspace_symbols', 'Open Workspace Symbols')
    lmap('grt', 'lsp_type_definitions', '[G]oto [T]ype Definition')
  end,
})

-- Override default behavior and theme when searching
vim.keymap.set(
  'n',
  '<leader>/',
  function() T().current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false }) end,
  { desc = 'Fuzzily search c. buffer' }
)

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set(
  'n',
  '<leader>s/',
  function() T().live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end,
  { desc = 'Search [/] in Open Files' }
)

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function() T().find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = 'Search [N]eovim files' })

lz.telescope = T
-- vim: ts=2 sts=2 sw=2 et
