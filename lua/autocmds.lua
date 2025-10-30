-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- ===========================================================================
-- [[ AUTOCMDS ]]
-- ===========================================================================

local augroup = vim.api.nvim_create_augroup('UserConfig', {})

-- Return the last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  desc = 'Return to last edit position',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto close terminal when process exits
vim.api.nvim_create_autocmd('TermClose', {
  group = augroup,
  desc = 'Auto close terminal on successful exit',
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  desc = 'Configure terminal buffer settings',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.foldcolumn = '0'
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  desc = 'Create parent directories when saving',
  callback = function()
    local dir = vim.fn.expand '<afile>:p:h'
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
      vim.notify('Created directory: ' .. dir, vim.log.levels.INFO)
    end
  end,
})

-- Spellchek in Markdown, text and no filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', '' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
