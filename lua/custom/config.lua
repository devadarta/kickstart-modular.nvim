-- ===========================================================================
-- OPTIONS
-- ===========================================================================

vim.o.relativenumber = true
vim.o.sidescrolloff = 10 -- Minimal number of screen characters to keep before and after at the side of the cursor
vim.o.wrap = false -- Wrap long lines
vim.o.synmaxcol = 300 -- Defaul is 3000
vim.o.shiftwidth = 0 -- Follow tabstop value
vim.o.tabstop = 2 -- Visual width of a tab character
vim.o.softtabstop = 2 -- Spaces inserted/removed in INSERT mode
vim.o.expandtab = true -- Use spaces instead of tab character
vim.o.shiftround = true -- Round indent to multiple of shiftwidth
-- vim.o.smartindent = true -- Smart auto-indent on new lines
-- vim.o.cindent = true -- Advanced C-style indentation
vim.cmd 'filetype indent on' -- Enable language-specific indentation
vim.o.foldenable = true -- Permite colapsar/dobrar codigo
vim.o.foldlevel = 99 -- Open all folds by default
vim.o.foldmethod = 'expr' -- Use expression for folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use Treesitter for folding. Need TreeSitter installed and configured

-- ===========================================================================
-- KEYMAPS
-- ===========================================================================

vim.keymap.set('n', '<leader>r', ':', { desc = 'Run command [:]' })

vim.keymap.set('n', '<leader>ww', '<cmd>write<cr>', { desc = 'Save buffer' }) -- Save
vim.keymap.set('n', '<leader>wq', '<cmd>wq<cr>', { desc = 'Save buffer and exit' }) -- Save and exit (ZZ)
vim.keymap.set('n', '<leader>c', function() -- Close window or quit nvim
  if #vim.api.nvim_list_wins() > 1 then
    vim.cmd 'close' -- Close the window
  else
    vim.cmd 'quit' -- If is the last window, quit the vim
  end
end, { desc = 'Close window or Quit nvim' })
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Go to last accessed buffer' })

-- Center screen when jumping
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Move lines up/down
vim.keymap.set({ 'n', 'x' }, '<M-j>', ':move +1<cr>', { desc = 'Move Line Down' })
vim.keymap.set({ 'n', 'x' }, '<M-k>', ':move -2<cr>', { desc = 'Move Line Up' })
vim.keymap.set('i', '<M-j>', '<C-o>:move +1<cr>', { desc = 'Move Line Down' })
vim.keymap.set('i', '<M-k>', '<C-o>:move -2<cr>', { desc = 'Move Line Up' })
-- This dont work very well
vim.keymap.set('v', '<M-j>', ":move '>+1<cr>gv=gv'", { desc = 'Move selection down' })
vim.keymap.set('v', '<M-k>', ":move '<-2<cr>gv=gv'", { desc = 'Move selection up' })

--
-- /// KEYMAPS TERMINAL ///
--
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false,
}

vim.keymap.set('n', '<leader>ter', function()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = terminal_state.buf })
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.api.nvim_set_option_value('winblend', 0, { win = terminal_state.win })

  -- Set transparent background for the window
  vim.api.nvim_set_option_value('winhighlight', 'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder', { win = terminal_state.win })

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, 'FloatingTermNormal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'FloatingTermBorder', { bg = 'none' })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= '' then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.cmd('terminal ' .. (os.getenv 'SHELL' or '/bin/sh'))
  end

  terminal_state.is_open = true
  vim.cmd 'startinsert'

  -- Set up auto-close on buffer leave
  vim.api.nvim_create_autocmd('BufLeave', {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true,
  })
end, {
  noremap = true,
  silent = true,
  desc = 'Floating terminal',
})
vim.keymap.set('t', '<Esc>', function()
  if terminal_state.is_open then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end, {
  noremap = true,
  silent = true,
  desc = 'Close floating terminal from terminal mode',
})

-- Open small terminal on bottom of window.
vim.keymap.set('n', '<leader>T', function()
  vim.cmd.vnew() -- Create new buffer
  vim.cmd('terminal ' .. (os.getenv 'SHELL' or '/bin/sh')) -- Open terminal on default shell
  vim.cmd 'startinsert' -- Start terminal on Insert Mode
  vim.cmd.wincmd 'J' -- Start terminal on bottom of neovim
  vim.api.nvim_win_set_height(0, 10) -- Set hight of terminal
  -- vim.bo.channel -- Used to get the terminal id to execute some command
end, { desc = 'Bottom terminal' })

vim.api.nvim_set_keymap('t', '<C-n>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Enter normal mode' }) -- Normal mode on terminals

--
-- /// KEYMAPS TABS ///
--
local opts = { silent = true }

-- Tab creating
vim.keymap.set('n', '<leader>ti', ':tabnew<CR>', vim.tbl_extend('force', opts, { desc = '[I]nsert empty tab' }))
vim.keymap.set('n', '<leader>to', function()
  vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
    if input and input ~= '' then
      vim.cmd('tabnew ' .. vim.fn.fnameescape(input))
    end
  end)
end, { desc = 'Open file in new tab' })

-- Tab navigation
vim.keymap.set('n', '<A-l>', ':tabnext<CR>', vim.tbl_extend('force', opts, { desc = 'Go to next tab' })) -- Built-in gt
vim.keymap.set('n', '<A-h>', ':tabprevious<CR>', vim.tbl_extend('force', opts, { desc = 'Go to previous tab' })) -- Built-in gT
vim.keymap.set('n', '<leader>tt', 'g<Tab>', vim.tbl_extend('force', opts, { desc = 'Go to last accessed [t]ab' })) -- REVIEW: Maybe t1 to go the first tab and tt go to next tab

-- Quick tab access (Alt + number for first 9 tabs)
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', i .. 'gt', vim.tbl_extend('force', opts, { desc = 'Go to tab ' .. i }))
end

-- Tab moving
vim.keymap.set('n', '<A-S-l>', function()
  local tab_count = vim.fn.tabpagenr '$'
  if tab_count < 2 then
    return
  end
  if vim.fn.tabpagenr() == tab_count then
    vim.cmd 'tabmove 0'
  else
    vim.cmd 'tabmove +1'
  end
end, vim.tbl_extend('force', opts, { desc = 'Move tab right' }))

vim.keymap.set('n', '<A-S-h>', function()
  local tab_count = vim.fn.tabpagenr '$'
  if tab_count < 2 then
    return
  end
  if vim.fn.tabpagenr() == 1 then
    vim.cmd('tabmove ' .. tab_count)
  else
    vim.cmd 'tabmove -1'
  end
end, vim.tbl_extend('force', opts, { desc = 'Move tab left' }))

-- ===========================================================================
-- AUTOCMDS
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
