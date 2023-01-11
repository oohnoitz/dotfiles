local cap = require('cmp_nvim_lsp').default_capabilities
local function setup(server, settings)
  settings = settings or {}
  settings.capabilties = cap
  require'lspconfig'[server].setup(settings)
end

setup('cssls')

setup('elixirls', {
  filetypes = { 'elixir', 'eelixir', 'heex' },
  cmd = { vim.loop.os_homedir() .. '/.lsp/elixir-ls/release/language_server.sh' },
})

setup('phpactor', {
  cmd = { vim.loop.os_homedir() .. '/.lsp/phpactor/bin/phpactor', 'language-server' },
})

setup('tailwindcss', {
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
})

setup('tsserver')
