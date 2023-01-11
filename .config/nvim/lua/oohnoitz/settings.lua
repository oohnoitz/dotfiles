local util = require('oohnoitz.util')

util.opt('w', 'colorcolumn', '80,120')
util.opt('b', 'expandtab', true)
util.opt('b', 'shiftwidth', 2)
util.opt('b', 'smartindent', true)
util.opt('b', 'tabstop', 2)
util.opt('o', 'autoread', true)
util.opt('o', 'completeopt', 'menu,menuone,noselect')
util.opt('o', 'hidden', true)
util.opt('o', 'ignorecase', true)
util.opt('o', 'smartcase', true)
util.opt('o', 'mouse', 'a')
util.opt('o', 'splitbelow', true)
util.opt('o', 'splitright', true)
util.opt('o', 'termguicolors', true)
util.opt('o', 'wildmode', 'list:longest')
util.opt('w', 'list', true)
util.opt('w', 'listchars', 'eol:¬,nbsp:␣,tab:▸ ,trail:·,precedes:←,extends:→')
util.opt('w', 'number', true)
util.opt('w', 'relativenumber', true)
util.opt('w', 'wrap', false)
util.opt('o', 'inccommand', 'nosplit')

vim.cmd 'syntax enable'
vim.cmd 'colorscheme kanagawa'

vim.g['python3_host_prog'] = vim.fn.expand('~/.pyenv/versions/neovim3/bin/python')
vim.g['loaded_node_provider'] = 0
vim.g['loaded_perl_provider'] = 0

vim.api.nvim_exec([[
  augroup NumberToggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
  augroup END
]], false)
