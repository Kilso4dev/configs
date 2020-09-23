if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

set number
set nobackup
set nowritebackup

set cmdheight=2
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


function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction


" Status bar
function! StatusLineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set laststatus=2
set statusline=
set statusline+=%#CursorColumn#
set statusline+=%{StatusLineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ \ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ 
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}


" Folding
set foldenable
set foldlevelstart=20
set foldnestmax=20
set foldmethod=syntax


" Tab and whitespaces
set list
set listchars=tab:\|\ 

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

" HEX Editing
command Hex %!xxd
command Hexrev  %!xxd -r

" Better write/quit
command WQ wq
command Wq wq
command W w
command Q q

"command Q! q!

" automatching brackets:
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O


" PLUG registering
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'

Plug 'tpope/vim-fugitive'

Plug 'sheerun/vim-polyglot'

" Plugin for lsp-protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

Plug 'preservim/nerdtree'

" React JSX syntax highlighting and indenting for vim
Plug 'mxw/vim-jsx'

call plug#end()



" -----------------------------lsp settings for (Conquer of Completion)-----------------------------

set updatetime=300

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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" -----------------------------Nerdtree Setup-----------------------------
" position: right
let g:NERDTreeWinPos = "right"
" close instantly
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open on startup
"autocmd vimenter * NERDTree


" -----------------------------indentLine Setup-----------------------------

let g:indentLine_char = '|'
"let g:indentLine_concealcursor=0


" -----------------------------colorscheme settings-----------------------------
colorscheme slate
set background=dark
set termguicolors
highlight Pmenu ctermbg=Black guibg=Black

" Some colorscheme fixes
highlight Pmenu ctermbg=Black guibg=Black
highlight PmenuSel ctermbg=Grey guibg=Grey
highlight CursorLine ctermbg=DarkGreen guibg=DarkGreen cterm=none
highlight PreProc ctermbg=White guibg=White

"lua vim.api.nvim_command [[autocmd CursorHold   * lua require'gitlens'.blameVirtText()]]
"lua vim.api.nvim_command [[autocmd CursorMoved  * lua require'gitlens'.clearBlameVirtText()]]
"lua vim.api.nvim_command [[autocmd CursorMovedI * lua require'gitlens'.clearBlameVirtText()]]
