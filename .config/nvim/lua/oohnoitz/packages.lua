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

require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    use 'nvim-telescope/telescope.nvim';
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    use {'nvim-treesitter/nvim-treesitter', run = vim.fn['TSUpdate']}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'

    use 'editorconfig/editorconfig-vim'

    use 'ojroques/nvim-bufdel'
    use 'mbbill/undotree'

    use 'ggandor/lightspeed.nvim'

    use 'windwp/nvim-autopairs'
    use {
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup()
      end
    }

    use 'folke/twilight.nvim'
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup()
      end
    }

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }
    use 'kana/vim-textobj-user'

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }

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

    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},         -- Required
        {'hrsh7th/cmp-nvim-lsp'},     -- Required
        {'hrsh7th/cmp-buffer'},       -- Optional
        {'hrsh7th/cmp-path'},         -- Optional
        {'saadparwaiz1/cmp_luasnip'}, -- Optional
        {'hrsh7th/cmp-nvim-lua'},     -- Optional

        -- Snippets
        {'L3MON4D3/LuaSnip'},             -- Required
        {'rafamadriz/friendly-snippets'}, -- Optional
      }
    }

    use {
      'nvim-tree/nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup({
          default = true;
        })
      end
    }
    use {
      'nvim-tree/nvim-tree.lua',
      config = function()
        require('nvim-tree').setup({
          view = {
            adaptive_size = true,
          },
        })
      end
    }

    use {'rebelot/kanagawa.nvim', commit = 'fc2e308'}
    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('oohnoitz.packages.lualine')
      end
    }

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    snapshot_path = require('packer.util').join_paths(vim.fn.stdpath('config'), 'snapshot')
  }
})
