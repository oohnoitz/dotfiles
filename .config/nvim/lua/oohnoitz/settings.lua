local scopes = { o = vim.o, b = vim.bo, w = vim.wo, g = vim.g }

function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('w', 'colorcolumn', '80,120')
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', 2)
opt('b', 'smartindent', true)
opt('b', 'tabstop', 2)
opt('o', 'autoread', true)
opt('o', 'completeopt', 'menu,menuone,noselect')
opt('o', 'hidden', true)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'mouse', 'a')
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
opt('o', 'termguicolors', true)
opt('o', 'wildmode', 'list:longest')
opt('w', 'list', true)
opt('w', 'listchars', 'eol:¬,nbsp:␣,tab:▸ ,trail:·,precedes:←,extends:→')
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'wrap', false)
opt('o', 'inccommand', 'nosplit')

vim.cmd 'syntax enable'
vim.cmd 'colorscheme kanagawa'

vim.api.nvim_exec([[
  augroup NumberToggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
  augroup END
]], false)

vim.g['python3_host_prog'] = vim.fn.expand('~/.pyenv/versions/neovim3/bin/python')
vim.g['loaded_node_provider'] = 0
vim.g['loaded_perl_provider'] = 0

if os.getenv('WSL_DISTRO_NAME') ~= nil then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf"
    },
    paste = {
      ["+"] = "win32yank.exe -o --crlf",
      ["*"] = "win32yank.exe -o --crlf"
    },
    cache_enable = 0,
  }
end
