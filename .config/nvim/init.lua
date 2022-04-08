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

local function is_loaded(name)
  if pcall(function() require(name) end) then
    return true
  else
    return false
  end
end

--- PLUGINS -------------------------------------------------
if is_loaded('paq') then
  require('paq') {
    'savq/paq-nvim';

    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';

    'mhartington/oceanic-next';
    'nvim-lualine/lualine.nvim';

     {'nvim-treesitter/nvim-treesitter', run = fn['TSUpdate']};
    'nvim-treesitter/playground';

    'editorconfig/editorconfig-vim';
    'ojroques/nvim-bufdel';
    'ggandor/lightspeed.nvim';
    'windwp/nvim-autopairs';

    'elixir-editors/vim-elixir';

    'b3nj5m1n/kommentary';
    'tpope/vim-eunuch';
    'tpope/vim-repeat';
    'kana/vim-textobj-user';

    'lewis6991/gitsigns.nvim';
    'tpope/vim-rhubarb';

    'neovim/nvim-lspconfig';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-cmdline';
    'hrsh7th/cmp-vsnip';
    'hrsh7th/vim-vsnip';
    'hrsh7th/nvim-cmp';

    'nvim-telescope/telescope.nvim';
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'};

    'kyazdani42/nvim-web-devicons';
    'kyazdani42/nvim-tree.lua';
  }
end

g['python_host_prog'] = fn.expand('~/.pyenv/versions/neovim2/bin/python')
g['python3_host_prog'] = fn.expand('~/.pyenv/versions/neovim3/bin/python')

if is_loaded('kommentary.config') then
  require('kommentary.config').use_extended_mappings()
end

if is_loaded('nvim-web-devicons') then
  require('nvim-web-devicons').setup {
    default = true;
  }
end

if is_loaded('nvim-tree') then
  require('nvim-tree').setup {}
end

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

if is_loaded('lightspeed') then
  require'lightspeed'.setup {}
end

if is_loaded('nvim-autopairs') then
  require('nvim-autopairs').setup {}
end

if is_loaded('gitsigns') then
  require('gitsigns').setup {}
end

if is_loaded('telescope') then
  local telescope = require('telescope')

  telescope.setup {}
  telescope.load_extension('fzf')
end

local has_words_before = function()
  local line, col = unpack(api.nvim_win_get_cursor(0))
  return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

if is_loaded('cmp') then
  local cmp = require'cmp'

  cmp.setup {
    snippet = {
      expand = function(args)
        fn['vsnip#anonymous'](args.body)
      end,
    },
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<S-Tab>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        end
      end, {'i', 's'})
    },
    sources = cmp.config.sources({{ name = 'nvim_lsp' }, { name = 'buffer' }})
  }
end

--- LSP -----------------------------------------------------
if is_loaded('lspconfig') then
  local lsp = require('lspconfig')
  local cap = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  lsp.cssls.setup {
    capabilities = cap
  }

  lsp.elixirls.setup {
    filetypes = { 'elixir', 'eelixir', 'heex' },
    cmd = { vim.loop.os_homedir() .. '/.lsp/elixir-ls/release/language_server.sh' },
    capabilities = cap
  }

  lsp.tsserver.setup {
    capabilities = cap
  }
end

--- LUALINE -------------------------------------------------
if is_loaded('lualine') then
  require('lualine').setup {
    options = {
      component_separators = "",
      icons_enabled = true,
      section_separators = "",
      theme = 'OceanicNext'
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
end

--- HOP ---
if is_loaded('hop') then
  require('hop').setup {
    keys = 'etovxqpdygfblzhckisuran',
    term_seq_bias = 0.5
  }
end

-------------------- TREE-SITTER ---------------------------
if is_loaded('nvim-treesitter.config') then
  require('nvim-treesitter.configs').setup {
    ensure_installed = 'maintained',
    highlight = { enable = true },
    query_linter = { enable = true }
  }
end

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
map('i', '<C-b>', '<Esc>bdwi')

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

map('n', '<space>p', ':Telescope find_files<CR>')
map('n', '<space>g', ':Telescope live_grep<CR>')
map('n', '<space>b', ':Telescope buffers<CR>')
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
