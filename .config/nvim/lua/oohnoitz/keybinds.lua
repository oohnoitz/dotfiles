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

vim.keymap.set('n', '<space>p', ':Telescope find_files<CR>')
vim.keymap.set('n', '<space>pd', '<cmd>lua require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:h") })<cr>')
vim.keymap.set('n', '<space>g', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<space>b', ':Telescope buffers<CR>')
vim.keymap.set('n', '<space>q', ':BufDel<CR>')

vim.keymap.set('n', '<space>t', ':Twilight<CR>')
vim.keymap.set('n', '<F5>', ':UndotreeToggle<CR>')

vim.keymap.set('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<space>r', ':Telescope lsp_references')
vim.keymap.set('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
