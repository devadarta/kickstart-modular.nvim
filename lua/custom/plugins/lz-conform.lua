--
-- Versão customizada com LazyLoading de kickstart/plugins/conform.lua
--

local function gh(repo) return 'https://github.com/' .. repo end
local lz = require 'custom.lazy'

lz.add { gh 'stevearc/conform.nvim' }

local function conform()
  lz.once('conform', function()
    vim.cmd.packadd 'conform.nvim'
    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- You can specify filetypes to autoformat on save here:
        local enabled_filetypes = {
          lua = true,
          python = true,
          javascript = true,
          html = true,
          css = true,
          sh = true,
          bash = true,
        }
        if enabled_filetypes[vim.bo[bufnr].filetype] then
          return { timeout_ms = 500 }
        else
          return nil
        end
      end,
      default_format_opts = {
        lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
      },
      -- You can also specify external formatters in here.
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
        sh = { 'shfmt' },
      },
    }
  end)
  return require 'conform'
end

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() conform().format { async = true } end, { desc = 'Format buffer' })

-- Garante o format-on-save ativo assim que você abre/cria um arquivo
lz.on_event('conform', { 'BufReadPre', 'BufNewFile', 'InsertEnter' }, function() conform() end)

-- vim: ts=2 sts=2 sw=2 et
