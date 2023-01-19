local telescope = require('telescope.builtin')

vim.keymap.set('n', '<space>L', ':nohlsearch<CR><C-l>')
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>')
vim.keymap.set('n', ';', ':')
vim.keymap.set('i', '<C-b>', '<Esc>bdwi')

vim.keymap.set('v', '<space>Y', '"+y')
vim.keymap.set('n', '<space>Y', '"+y')
vim.keymap.set('v', '<space>P', '"+p')
vim.keymap.set('n', '<space>P', '"+p')

vim.keymap.set('n', '<C-w>_', '<C-W>v<C-W><Right>')
vim.keymap.set('n', '<C-w>-', '<C-W>s<C-W><Down>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('n', '<space>e', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>')
vim.keymap.set('n', '<space>E', ':NvimTreeRefresh<CR>:NvimTreeFindFile<CR>')

vim.keymap.set('n', 'tn', ':tabnew<Space>')
vim.keymap.set('n', 'tk', ':tabnext<CR>')
vim.keymap.set('n', 'tj', ':tabprev<CR>')
vim.keymap.set('n', 'th', ':tabfirst<CR>')
vim.keymap.set('n', 'tl', ':tablast<CR>')

vim.keymap.set('n', '<space>p', function() telescope.find_files() end)
vim.keymap.set('n', '<space>pd', function() telescope.find_files({ cwd = vim.fn.expand("%:h") }) end)
vim.keymap.set('n', '<space>g', function() telescope.live_grep() end)
vim.keymap.set('n', '<space>b', function() telescope.buffers() end)
vim.keymap.set('n', '<space>q', ':BufDel<CR>')

vim.keymap.set('n', '<space>tt', ':Twilight<CR>')
vim.keymap.set('n', '<space>tz', ':ZenMode<CR>')
vim.keymap.set('n', '<F5>', ':UndotreeToggle<CR>')

vim.keymap.set('n', '<space>,', function() vim.lsp.diagnostic.goto_prev() end)
vim.keymap.set('n', '<space>;', function() vim.lsp.diagnostic.goto_next() end)
vim.keymap.set('n', '<space>a', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', '<space>d', function() vim.lsp.buf.definition() end)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.formatting() end)
vim.keymap.set('n', '<space>h', function() vim.lsp.buf.hover() end)
vim.keymap.set('n', '<space>m', function() vim.lsp.buf.rename() end)
vim.keymap.set('n', '<space>s', function() vim.lsp.buf.document_symbol() end)
vim.keymap.set('n', '<space>r', ':Telescope lsp_references<CR>')
