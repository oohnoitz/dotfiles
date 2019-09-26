let g:mapleader = ' '
let g:maplocalleader = '\'

function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " theme/interface
  call minpac#add('mhartington/oceanic-next')
  call minpac#add('ryanoasis/vim-devicons')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')

  " utility
  call minpac#add('easymotion/vim-easymotion')
  call minpac#add('janko/vim-test')
  call minpac#add('jiangmiao/auto-pairs')
  call minpac#add('junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'})
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('majutsushi/tagbar')
  call minpac#add('moll/vim-bbye')
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('simnalamburt/vim-mundo')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-surround')
  call minpac#add('wakatime/vim-wakatime')

  " generic programming support
  call minpac#add('dense-analysis/ale')
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('kana/vim-textobj-user')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('Shougo/deoplete.nvim')
  call minpac#add('Shougo/echodoc.vim')

  " markdown/writing
  call minpac#add('dhruvasagar/vim-table-mode')
  call minpac#add('godlygeek/tabular')
  call minpac#add('plasticboy/vim-markdown')
  call minpac#add('reedes/vim-pencil')

  " git
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-rhubarb')

  " elixir
  call minpac#add('andyl/vim-textobj-elixir')
  call minpac#add('avdgaag/vim-phoenix')
  call minpac#add('elixir-editors/vim-elixir')
  call minpac#add('mmorearty/elixir-ctags')
  call minpac#add('slashmili/alchemist.vim')

  " javascript/typescript
  call minpac#add('HerringtonDarkholme/yats.vim')
  call minpac#add('mhartington/nvim-typescript', {'do': './install.sh'})
endfunction

let g:airline_extensions = ['tabline']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x']]

let g:ale_elixir_elixir_ls_release = $HOME . '/.lsp/elixir-ls/release'
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'javascript.jsx': ['eslint']
\ }
let g:ale_linters = {
\   'elixir': ['credo', 'elixir-ls']
\ }

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

let g:deoplete#enable_at_startup = 1
let g:gitgutter_diff_args = '-w'

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

let g:nvim_typescript#signature_complete = 1

let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['javascript=javascript']

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

set nowrap
set noshowmode
set colorcolumn=80,120

" Editor Configs
set completeopt-=preview
set nobackup
set noswapfile
set undofile
set undodir=~/.nvim/undo
set listchars=eol:¬,nbsp:␣,tab:▸\ ,trail:·,precedes:←,extends:→
set list

" Theme
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
set number relativenumber
set termguicolors
let g:airline_theme = 'base16_oceanicnext'
function! AirlineInit()
  let g:airline_section_x = '%{PencilMode()}'
  let g:airline_section_z = airline#section#create(['windowswap', 'linenr', 'maxlinenr'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
let g:airline_mode_map = {
\   '__' : '-',
\   'n'  : 'N',
\   'i'  : 'I',
\   'R'  : 'R',
\   'c'  : 'C',
\   'v'  : 'V',
\   'V'  : 'V',
\   '' : 'V',
\   's'  : 'S',
\   'S'  : 'S',
\   '' : 'S',
\ }
let g:airline_highlighting_cache = 1
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

"  Save
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

"  Map ; to :
nnoremap ; :

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

"  Clipboard
vnoremap <leader>Y "+y
nnoremap <leader>Y "+y
nnoremap <leader>P "+p
vnoremap <leader>P "+p

"  ALE
nmap <A-k> <Plug>(ale_previous_wrap)
nmap <A-j> <Plug>(ale_next_wrap)
nmap <Leader>ad <Plug>(ale_go_to_definition)
nmap <Leader>ah <Plug>(ale_hover)
nmap <Leader>af <Plug>(ale_fix)
nmap <Leader>ar <Plug>(ale_find_references)

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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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

"  minpac
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
