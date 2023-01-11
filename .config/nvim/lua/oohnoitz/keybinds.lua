local util = require('oohnoitz.util')

--- DEFAULTS
util.map('n', '<space>L', ':nohlsearch<CR><C-l>')
util.map('n', '<C-s>', ':w<CR>')
util.map('i', '<C-s>', '<Esc>:w<CR>')
util.map('n', ';', ':')
util.map('i', '<C-b>', '<Esc>bdwi')

--- CLIPBOARD
util.map('v', '<space>Y', '"+y')
util.map('n', '<space>Y', '"+y')
util.map('v', '<space>P', '"+p')
util.map('n', '<space>P', '"+p')

--- NAVIGATION
util.map('n', '<C-w>_', '<C-W>v<C-W><Right>')
util.map('n', '<C-w>-', '<C-W>s<C-W><Down>')
util.map('n', '<C-h>', '<C-w>h')
util.map('n', '<C-j>', '<C-w>j')
util.map('n', '<C-k>', '<C-w>k')
util.map('n', '<C-l>', '<C-w>l')

util.map('n', '<space>e', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>')
util.map('n', '<space>E', ':NvimTreeRefresh<CR>:NvimTreeFindFile<CR>')

--- TAB NAVIGATION
util.map('n', 'tn', ':tabnew<Space>')
util.map('n', 'tk', ':tabnext<CR>')
util.map('n', 'tj', ':tabprev<CR>')
util.map('n', 'th', ':tabfirst<CR>')
util.map('n', 'tl', ':tablast<CR>')

util.map('n', '<space>p', ':Telescope find_files<CR>')
util.map('n', '<space>pd', '<cmd>lua require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:h") })<cr>')
util.map('n', '<space>g', ':Telescope live_grep<CR>')
util.map('n', '<space>b', ':Telescope buffers<CR>')
util.map('n', '<space>q', ':BufDel<CR>')

util.map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
util.map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
util.map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
util.map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
util.map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
util.map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
util.map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
util.map('n', '<space>r', ':Telescope lsp_references')
util.map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
