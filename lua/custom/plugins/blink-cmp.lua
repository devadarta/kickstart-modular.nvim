--
-- Versão customizada com LazyLoading de kickstart/plugins/telescopej.lua
--

local function gh(repo) return 'https://github.com/' .. repo end
local lz = require 'custom.lazy'

-- NOTE: You can also specify plugin using a version range for its git tag.
--  See `:help vim.version.range()` for more info
lz.add {
  { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  gh 'rafamadriz/friendly-snippets',
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
}

-- BufReadPre/BufNewFile: carrega antes do LSP subir (FileType vem depois), para manter as capabilities.
-- InsertEnter/CmdlineEnter: cobre o nvim vazio e o `:`.
lz.on_event('blink', { 'BufReadPre', 'BufNewFile', 'InsertEnter', 'CmdlineEnter' }, function()
  lz.pack('LuaSnip', 'friendly-snippets', 'blink.cmp')

  require('luasnip').setup {}
  require('luasnip.loaders.from_vscode').lazy_load()

  require('blink.cmp').setup {
    keymap = {
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See `:help blink-cmp-config-keymap` for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }
end)

-- vim: ts=2 sts=2 sw=2 et
