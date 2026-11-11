--
-- Versão customizada com LazyLoading de kickstart/plugins/debug.lua

local function gh(repo) return 'https://github.com/' .. repo end
local lz = require 'custom.lazy'

lz.add {
  gh '/mfussenegger/nvim-dap',
  gh '/rcarriga/nvim-dap-ui',
  gh '/nvim-neotest/nvim-nio',
  gh '/mason-org/mason.nvim',
  gh '/jay-babu/mason-nvim-dap.nvim',
  gh '/leoluz/nvim-dap-go',
}

local function D()
  lz.once('dap', function()
    lz.mason()
    lz.pack('nvim-nio', 'nvim-dap', 'nvim-dap-ui', 'mason-nvim-dap.nvim', 'nvim-dap-go')

    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      -- see mason-nvim-dap README for more information
      handlers = {},

      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end)
  return require 'dap'
end

-- Basic debugging keymaps, feel free to change to your liking!
vim.keymap.set('n', '<F5>', function() D().continue() end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', function() D().step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function() D().step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function() D().step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() D().toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function() D().set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Set Breakpoint' })
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F7>', function()
  D()
  require('dapui').toggle()
end, { desc = 'Debug: See last session result.' })
