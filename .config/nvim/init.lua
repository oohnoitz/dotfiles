--- HELPERS -------------------------------------------------
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- PLUGINS -------------------------------------------------
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt = true}

paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}

paq {'mhartington/oceanic-next'}
paq {'hoob3rt/lualine.nvim'}

paq {'nvim-treesitter/nvim-treesitter', run = fn['TSUpdate']}
paq {'nvim-treesitter/playground'}

paq {'editorconfig/editorconfig-vim'}
paq {'ojroques/nvim-bufdel'}
paq {'phaazon/hop.nvim'}
paq {'junegunn/fzf', run = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'windwp/nvim-autopairs'}

paq {'elixir-editors/vim-elixir'}

paq {'b3nj5m1n/kommentary'}
paq {'tpope/vim-eunuch'}
paq {'tpope/vim-repeat'}
paq {'blackCauldron7/surround.nvim'}
paq {'kana/vim-textobj-user'}

paq {'lewis6991/gitsigns.nvim'}
paq {'tpope/vim-fugitive'}
paq {'tpope/vim-rhubarb'}

paq {'neovim/nvim-lspconfig'}
paq {'hrsh7th/nvim-compe'}
paq {'nvim-telescope/telescope.nvim'}

paq {'kyazdani42/nvim-web-devicons'}
paq {'kyazdani42/nvim-tree.lua'}

g['python_host_prog'] = fn.expand('~/.pyenv/versions/neovim2/bin/python')
g['python3_host_prog'] = fn.expand('~/.pyenv/versions/neovim3/bin/python')

require('kommentary.config').use_extended_mappings()
require('nvim-web-devicons').setup {
  default = true;
}

local check_backspace = function()
  local col = fn.col('.') - 1

  if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
    return true
  else 
    return false
  end
end

local t = function(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

require('surround').setup {}
require('nvim-autopairs').setup {}
require('gitsigns').setup {}

require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = true;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
    treesitter = true;
  };
}

_G.tab_complete = function()
  if fn.pumvisible() == 1 then
    return t("<C-n>")
  elseif check_backspace() then
    return t("<Tab>")
  else
    return fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if fn.pumvisible() == 1 then
    return t("<C-p>")
  else
    return t("<S-Tab>")
  end
end

--- LSP -----------------------------------------------------
local lsp = require('lspconfig')

lsp.cssls.setup {}

lsp.elixirls.setup {
  cmd = { vim.loop.os_homedir() .. '/.lsp/elixir-ls/release/language_server.sh' }
}

lsp.tsserver.setup {}

--- LUALINE -------------------------------------------------
require('lualine').setup {
  options = {
    component_separators = "",
    icons_enabled = true,
    section_separators = "",
    theme = 'oceanicnext'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

--- HOP ---
require('hop').setup {
  keys = 'etovxqpdygfblzhckisuran',
  term_seq_bias = 0.5
}

-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = { enable = true },
  query_linter = { enable = true }
}

--- OPTIONS -------------------------------------------------
local indent = 2
cmd 'colorscheme OceanicNext'
cmd 'syntax enable'
opt('w', 'colorcolumn', '80,120')
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', indent)
opt('b', 'smartindent', true)
opt('b', 'tabstop', indent)
opt('o', 'autoread', true)
opt('o', 'completeopt', 'menuone,noinsert,noselect')
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

g['oceanic_next_terminal_bold'] = 1
g['oceanic_next_terminal_italic'] = 1

api.nvim_exec([[
  augroup NumberToggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
  augroup END
]], false)


--- KEYBINDS ------------------------------------------------
--- DEFAULTS
map('n', '<space>L', ':nohlsearch<CR><C-l>')
map('n', '<C-s>', ':w<CR>')
map('i', '<C-s>', '<Esc>:w<CR>')
map('n', ';', ':')
map('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

--- CLIPBOARD
map('v', '<space>Y', '"+y')
map('n', '<space>Y', '"+y')
map('v', '<space>P', '"+p')
map('n', '<space>P', '"+p')

--- NAVIGATION
map('n', '<C-w>_', '<C-W>v<C-W><Right>')
map('n', '<C-w>-', '<C-W>s<C-W><Down>')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<space>e', ':NvimTreeToggle<CR>')
map('n', '<space>E', ':NvimTreeFindFile<CR>')

--- TAB NAVIGATION
map('n', 'tn', ':tabnew<Space>')
map('n', 'tk', ':tabnext<CR>')
map('n', 'tj', ':tabprev<CR>')
map('n', 'th', ':tabfirst<CR>')
map('n', 'tl', ':tablast<CR>')

map('n', '<space>p', ':Files<CR>')
map('n', '<space>g', ':grep<space>')
map('n', '<space>b', ':Buffers<CR>')
map('n', '<space>t', ':TagbarToggle<CR>')
map('n', '<space>q', ':BufDel<CR>')

map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
