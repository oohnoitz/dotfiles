--- HELPERS -------------------------------------------------
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local scopes = { o = vim.o, b = vim.bo, w = vim.wo, g = vim.g }

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function is_loaded(name)
  if pcall(function() require(name) end) then
    return true
  else
    return false
  end
end

--- PLUGINS -------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  use 'nvim-telescope/telescope.nvim';
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

  use {'nvim-treesitter/nvim-treesitter', run = fn['TSUpdate']}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'

  use 'editorconfig/editorconfig-vim'
  use 'ojroques/nvim-bufdel'
  use 'ggandor/lightspeed.nvim'
  use 'windwp/nvim-autopairs'
  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  }

  use 'chentoast/marks.nvim'

  use 'folke/twilight.nvim'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'kana/vim-textobj-user'

  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'
  use {
    'TimUntersberger/neogit',
    config = function()
      require('neogit').setup({
        integrations = {
          diffview = true,
        },
      })
    end
  }

  use 'andythigpen/nvim-coverage'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/nvim-cmp'

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({
        default = true;
      })
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        view = {
          adaptive_size = true,
        },
      })
    end
  }

  use {
    'rebelot/kanagawa.nvim',
    commit = 'fc2e308'
  }
  use 'nvim-lualine/lualine.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

g['python3_host_prog'] = fn.expand('~/.pyenv/versions/neovim3/bin/python')
g['loaded_node_provider'] = 0
g['loaded_perl_provider'] = 0

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

if is_loaded('cmp') then
  local cmp = require'cmp'
  local has_words_before = function()
    local line, col = unpack(api.nvim_win_get_cursor(0))
    return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup {
    snippet = {
      expand = function(args)
        fn['vsnip#anonymous'](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
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
    }),
    sources = cmp.config.sources({{ name = 'nvim_lsp' }, { name = 'buffer' }})
  }
end

--- LSP -----------------------------------------------------
if is_loaded('lspconfig') then
  local lsp = require('lspconfig')
  local cap = require('cmp_nvim_lsp').default_capabilities()
  local util = require('lspconfig.util')

  lsp.cssls.setup {
    capabilities = cap
  }

  lsp.elixirls.setup {
    filetypes = { 'elixir', 'eelixir', 'heex' },
    cmd = { vim.loop.os_homedir() .. '/.lsp/elixir-ls/release/language_server.sh' },
    capabilities = cap
  }

  lsp.phpactor.setup {
    cmd = { vim.loop.os_homedir() .. '/.lsp/phpactor/bin/phpactor', 'language-server' },
    capabilities = cap
  }

  lsp.tailwindcss.setup {
    capabilities = cap,
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "classList", "ngClass" },
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning"
        },
        includeLanguages = {
          heex = "html",
        },
        validate = true,
      }
    },
  }

  lsp.tsserver.setup {
    capabilities = cap
  }
end


--- LUALINE -------------------------------------------------
if is_loaded('kanagawa') then
  cmd 'colorscheme kanagawa'
end

if is_loaded('lualine') then
  require('lualine').setup {
    options = {
      component_separators = "",
      icons_enabled = true,
      section_separators = "",
      theme = 'kanagawa'
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
if is_loaded('nvim-treesitter.configs') then
  require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    highlight = { enable = true },
    indent = { enable = true },
    query_linter = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@class.outer'] = '<c-v>',
        },
        include_surrounding_whitespace = true,
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  }
end

--- OPTIONS -------------------------------------------------
g['oceanic_next_terminal_bold'] = 1
g['oceanic_next_terminal_italic'] = 1

local indent = 2
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
opt('w', 'foldmethod', 'expr')
opt('w', 'foldexpr', 'nvim_treesitter#foldexpr()')

cmd 'syntax enable'

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

map('n', '<space>e', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>')
map('n', '<space>E', ':NvimTreeRefresh<CR>:NvimTreeFindFile<CR>')

--- TAB NAVIGATION
map('n', 'tn', ':tabnew<Space>')
map('n', 'tk', ':tabnext<CR>')
map('n', 'tj', ':tabprev<CR>')
map('n', 'th', ':tabfirst<CR>')
map('n', 'tl', ':tablast<CR>')

map('n', '<space>p', ':Telescope find_files<CR>')
map('n', '<space>pd', '<cmd>lua require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:h") })<cr>')
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
map('n', '<space>r', ':Telescope lsp_references')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
