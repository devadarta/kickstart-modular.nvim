-- ===========================================================================
-- [[ CUSTOM OPTIONS ]]
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
vim.cmd 'filetype indent on' -- Enable language-specific indentation
vim.o.foldenable = true -- Permite colapsar/dobrar codigo
vim.o.foldlevel = 99 -- Open all folds by default
vim.o.foldmethod = 'expr' -- Use expression for folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use Treesitter for folding. Need TreeSitter installed and configured
vim.opt_local.spelllang = 'pt_br,en' -- setlocal spelllang
--vim.o.writebackup = false -- Don't create temporary backup while writing
vim.o.swapfile = false -- Don't create swap files (good with version control)
-- o.completeopt = "menu,menuone,noselect,noinsert,popup,fuzzy"
-- o.pumheight = 10 -- Maximum height for completion menu
-- o.pumblend = 10 -- Completion menu transparency (0-100)
vim.o.path = '**' -- Search files recursively in subdirectories
vim.g.netrw_liststyle = 3 -- Tree-style directory listing (:e or <leader>e)
vim.o.wildmode = 'longest:full,full' -- Command completion behavior
vim.o.wildignore = '*.o, *.obj,*.pyc,*.class,*.jar'
-- vim.o.diffopt:append { -- Better diff algorithms
--   'linematch:60',
--   'algorithm:patience',
-- }
