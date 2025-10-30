-- ===========================================================================
-- Usefull funcions that are used in others lua files
-- ===========================================================================
local M = {}

function M.close_or_quit()
  -- If has windows opened, close the window
  if #vim.api.nvim_list_wins() > 1 then
    vim.cmd 'close'
  else
    -- If is the last window, quit the vim
    vim.cmd 'quit'
  end
end

-- ===========================================================================
-- Tab
-- ===========================================================================
function M.open_file_tab()
  vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
    if input and input ~= '' then
      vim.cmd('tabnew ' .. vim.fn.fnameescape(input))
    end
  end)
end

function M.move_tab_right()
  local tab_count = vim.fn.tabpagenr '$'
  if tab_count < 2 then
    return
  end
  if vim.fn.tabpagenr() == tab_count then
    vim.cmd 'tabmove 0'
  else
    vim.cmd 'tabmove +1'
  end
end

function M.move_tab_left()
  local tab_count = vim.fn.tabpagenr '$'
  if tab_count < 2 then
    return
  end
  if vim.fn.tabpagenr() == 1 then
    vim.cmd('tabmove ' .. tab_count)
  else
    vim.cmd 'tabmove -1'
  end
end

-- ===========================================================================
-- Terminal
-- ===========================================================================
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false,
}

function M.floating_terminal()
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
end

function M.close_floating_terminal()
  if terminal_state.is_open then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

function M.bottom_terminal()
  vim.cmd.vnew() -- Create new buffer
  vim.cmd('terminal ' .. (os.getenv 'SHELL' or '/bin/sh')) -- Open terminal on default shell
  vim.cmd 'startinsert' -- Start terminal on Insert Mode
  vim.cmd.wincmd 'J' -- Start terminal on bottom of neovim
  vim.api.nvim_win_set_height(0, 10) -- Set hight of terminal
  -- vim.bo.channel -- Used to get the terminal id to execute some command
end

return M
