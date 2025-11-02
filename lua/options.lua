-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- vim: ts=2 sts=2 sw=2 et

-- ===========================================================================
-- [[ CUSTOM OPTIONS ]]
-- ===========================================================================

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
