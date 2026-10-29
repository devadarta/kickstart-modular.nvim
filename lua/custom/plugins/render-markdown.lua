local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'nvim-mini/mini.nvim',
  gh 'MeanderingProgrammer/render-markdown.nvim',
}
-- require('render-markdown').setup({}) -- only mandatory if you want to set custom options
