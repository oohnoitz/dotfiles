local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<space>vca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<space>vrr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<space>vrn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<space>vd', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<space>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.configure('elixirls', {
 cmd = { vim.loop.os_homedir() .. '/.lsp/elixir-ls/release/language_server.sh' },
})

lsp.setup()
