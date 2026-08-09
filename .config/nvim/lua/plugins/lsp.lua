return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- capabilities = {
      --   textDocument = {
      --     foldingRange = {
      --       dynamicRegistration = false,
      --       lineFoldingOnly = true,
      --     },
      --   },
      -- },
      servers = {
        elixirls = {
          cmd = { vim.loop.os_homedir() .. "/.lsp/elixir-ls/release/language_server.sh" },
          mason = false,
          enabled = false,
        },
        -- lexical = {
        --   cmd = { vim.loop.os_homedir() .. "/.lsp/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
        -- },
        lexical = {
          cmd = { vim.loop.os_homedir() .. "/.lsp/expert/apps/expert/burrito_out/expert_linux_amd64" },
          mason = false,
          enabled = false,
        },
      },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {},
    init = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end,
  },
}
