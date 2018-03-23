let g:mapleader = ' '
let g:maplocalleader = '\'

" dein.vim plugin manager

let g:dein_git = 'https://github.com/Shougo/dein.vim.git'
let g:dein_dir = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#filter = 0
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#filetypes = ['jsx', 'vue']

let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'

let g:echodoc#enable_at_startup = 1

let g:gitgutter_diff_args = '-w'

let g:ale_fixers = {
\  'javascript': ['eslint'],
\}

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

let g:fzf_colors = {
\   'bg+':     ['bg', 'Normal'],
\   'fg+':     ['fg', 'Statement'],
\   'hl':      ['fg', 'Underlined'],
\   'hl+':     ['fg', 'Underlined'],
\   'info':    ['fg', 'MatchParen'],
\   'pointer': ['fg', 'Special'],
\   'prompt':  ['fg', 'Normal'],
\   'marker':  ['fg', 'MatchParen']
\ }

let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1

exec 'set runtimepath^='.g:dein_dir

call dein#begin(expand('~/.cache/dein'))

call dein#add(expand(g:dein_dir))
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/echodoc.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('carlitux/deoplete-ternjs', { 'build': 'npm install -g tern' })
call dein#add('junegunn/fzf', { 'build': './install -all', 'merge': 0 })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NERDTreeToggle' })
call dein#add('sheerun/vim-polyglot')
call dein#add('w0rp/ale')
call dein#add('simnalamburt/vim-mundo')
call dein#add('vim-scripts/Rename')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('mhartington/nvim-typescript', { 'build': 'npm install -g typescript' })
call dein#add('slashmili/alchemist.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-commentary')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('mhartington/oceanic-next')
call dein#add('ryanoasis/vim-devicons')
call dein#add('easymotion/vim-easymotion')
call dein#add('majutsushi/tagbar')
call dein#add('moll/vim-bbye')
call dein#add('jiangmiao/auto-pairs')
call dein#add('godlygeek/tabular')
call dein#add('plasticboy/vim-markdown')
call dein#add('reedes/vim-pencil')
call dein#add('dhruvasagar/vim-table-mode')

call dein#end()

if dein#check_install()
  call dein#install()
endif

" Defaults
let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')

filetype plugin indent on
syntax enable
set mouse=a
set splitbelow
set splitright
set autoread

set smartindent
set expandtab
set tabstop=2
set shiftwidth=2

set foldenable
set foldmethod=syntax
set foldlevel=99

set cursorline
set nowrap
set noshowmode
set colorcolumn=80,120

" Editor Configs
set completeopt-=preview
set nobackup
set noswapfile
set undofile
set undodir=~/.nvim/undo
set listchars=eol:$,nbsp:_,tab:>-,trail:~,extends:>,precedes:<
set list

" Theme
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
set number relativenumber
set termguicolors
let g:airline_theme = 'base16_oceanicnext'
let g:airline_powerline_fonts = 1
let g:airline_section_x = '%{PencilMode()}'
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext
exec "hi! Normal ctermbg=NONE guibg=NONE"
exec "hi! NonText ctermbg=NONE guibg=NONE"
exec "hi! LineNr ctermbg=NONE guibg=NONE"
exec "hi! EndOfBuffer ctermbg=NONE guibg=NONE"
highlight NonText guifg=#4A4A4A
highlight SpecialKey guifg=#4A4A4A
highlight ALEErrorSign ctermfg=9 ctermbg=NONE guifg=#C30500 guibg=NONE
highlight ALEWarningSign ctermfg=11 ctermbg=NONE guifg=#ED6237 guibg=NONE

augroup NumberToggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

augroup Pencil
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" Search
set ignorecase
set showmatch
set smartcase

" Bindings
"  Clear
map <F5> :redraw! \| :nohlsearch \| <CR><c-w>=
nnoremap <Leader>L :nohlsearch<CR><C-l>

"  Tab Completion
inoremap <expr><tab> pumvisible() ? '<C-n>' : '<Tab>'

"  Navigation
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <Leader>E :NERDTreeFind<CR>
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>g :grep<space>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>q :Bdelete<CR>

"  Tab Navigation
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" EasyMotion: ALE: Lint Navigation
nmap <A-k> <Plug>(ale_previous_wrap)
nmap <A-j> <Plug>(ale_next_wrap)
nmap <Leader>d <Plug>(ale_fix)

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" EasyMotion: Line Navigation
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)

" EasyMotion: Search Navigaton
nmap s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Fugitive
map <leader>gd :Gdiff<CR>
map <leader>gs :Gstatus<CR>
map <leader>gc :Gcommit -v<CR>
map <leader>gcv :Gcommit --no-verify -v<CR>
map <leader>gt :Gcommit -v -q %:p<CR>
map <leader>go :Git checkout -- %:p
map <leader>gl :Git log -n 5<CR>
map <leader>gw :Gwrite<CR>
map <Leader>gg :Ggrep<space>
map <leader>gp :Git push<CR>
nnoremap <leader>ga :Git add -p<CR>
nnoremap <leader>grm :Git rm %:p<CR><CR>

" Windows
nnoremap <C-w>_ <C-W>v<C-W><Right>
nnoremap <C-w>- <C-W>s<C-W><Down>
nnoremap <C-j> <C-w>+
nnoremap <C-k> <C-w>-
nnoremap <C-h> <C-w><
nnoremap <C-l> <C-w>> 

"  Diff
nnoremap <Leader>w :w !diff -u % -<CR>
nnoremap <F2> :MundoToggle<CR>

"  FZF
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap [fzf] <Nop>
nmap <Leader>f [fzf]
nnoremap <silent> [fzf]h :History<CR>
nnoremap <silent> [fzf]l :BLines<CR>
nnoremap <silent> [fzf]f :Rg<CR>
nnoremap <silent> [fzf]t :Tags<CR>
nnoremap <silent> [fzf]g :GFiles<CR>
nnoremap <silent> [fzf]s :GFiles?<CR>
