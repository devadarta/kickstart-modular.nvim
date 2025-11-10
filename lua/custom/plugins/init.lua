-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- Popup commands like cmd (:) search (/) and others
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      presets = {
        command_palette = true, -- On the top
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },

  { -- Colorize the text background according to HTML/RGB/Name/... color. Ex: #a4dd82
    'catgoose/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {
      lazy_load = true,
    },
  },

  { -- Nice green Theme
    'everviolet/nvim',
    name = 'evergarden',
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      theme = {
        variant = 'fall', -- 'winter'|'fall'|'spring'|'summer'
        accent = 'green',
      },
      editor = {
        transparent_background = false,
        sign = { color = 'none' },
        float = {
          color = 'mantle',
          solid_border = false,
        },
        completion = {
          color = 'surface0',
        },
      },
    },
    config = function()
      vim.cmd.colorscheme 'evergarden-winter'
    end,
  },

  -- { -- Nice night dark blue color
  --   'bluz71/vim-nightfly-colors',
  --   name = 'nightfly',
  --   lazy = false,
  --   priority = 1000,
  --   -- config = function()
  --   --vim.cmd.colorscheme 'nightfly'
  --   -- end,
  -- },
  --
}
