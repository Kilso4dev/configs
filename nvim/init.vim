set number
set nobackup
set nowritebackup

set cmdheight=4
set shortmess+=c
set signcolumn=yes

set showcmd

set wildmenu

" search
set hlsearch
set incsearch
set ignorecase

" UI
set hidden
set showmatch
set cursorline

set laststatus=2

" Folding
set foldenable
set foldlevelstart=20
set foldnestmax=20
set foldmethod=syntax


" Tab and whitespaces
set list
set listchars=tab:\|\ ,space:·

" indentation
set smartindent
"set tabstop=2
set expandtab
set shiftwidth=4
set softtabstop=4

" Emacs imaps
inoremap <C-A> <esc>^i
inoremap <C-E> <esc>$a


inoremap <C-F> <Right>
inoremap <A-F> <w>

inoremap <C-B> <Left>
inoremap <A-B> <b>

inoremap <C-P> <Up>
inoremap <C-N> <Down>

" inoremap <C-V> <esc><C-d>i
" map <A-V> <esc><C-u>i


" automatching brackets:
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


" PLUG registering
call plug#begin()

Plug 'skielbasa/vim-material-monokai'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

call plug#end()



" -----------------------------lsp settings for (Conquer of Completion)-----------------------------
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" autocompletion on tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	  let col = col('.') - 1
	    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion  on Ctrl-Space
noremap <silent><expr> <c-space> coc#refresh()

" -----------------------------colorscheme settings-----------------------------
set background=dark
set termguicolors
colorscheme material-monokai

lua vim.api.nvim_command [[autocmd CursorHold   * lua require'gitlens'.blameVirtText()]]
lua vim.api.nvim_command [[autocmd CursorMoved  * lua require'gitlens'.clearBlameVirtText()]]
lua vim.api.nvim_command [[autocmd CursorMovedI * lua require'gitlens'.clearBlameVirtText()]]


