
" PLUG registering
call plug#begin()
" statusLine
Plug 'hoob3rt/lualine.nvim'

" Task list(TODOs and similar)
Plug 'vim-scripts/TaskList.vim'


Plug 'Yggdroot/indentLine'

"Git wrapper
Plug 'tpope/vim-fugitive'

" vim languages
Plug 'sheerun/vim-polyglot'

" matching brackets
Plug 'jiangmiao/auto-pairs'
" Rainbow brackets
Plug 'frazrepo/vim-rainbow'

" Plugin for lsp-protocol not usable until nvim 0.5
Plug 'neovim/nvim-lspconfig' 
Plug 'hrsh7th/nvim-compe'
"Plug 'vim-syntastic/syntastic'

Plug 'lervag/vimtex'

" Python folding
Plug 'tmhedberg/SimpylFold'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" Better Filetree
Plug 'preservim/nerdtree'


" React JSX syntax highlighting and indenting for vim
Plug 'mxw/vim-jsx'

" html autoclose tags
Plug 'alvan/vim-closetag'

" Themes
Plug 'wadackel/vim-dogrun'
Plug 'ajmwagar/vim-deus'
Plug 'rakr/vim-one'

call plug#end()



" -----------------------------lsp settings for (Conquer of Completion)-----------------------------


function! Coc_setup()

    set updatetime=300
    inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
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
    nmap <silent> <C-p> <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    nmap <silent> <C-n> <Plug>(coc-diagnostic-next)

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

endfunction

"call Coc_setup()

" -----------------------------Nerdtree Setup-----------------------------
" position: right
let g:NERDTreeWinPos = "left"
" close instantly
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -----------------------------vim-closetag Setup-----------------------------
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*.js'

let g:closetag_shortcut = '>'

let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'typescript.ts': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'javascript.js': 'jsxRegion',
    \ }
let g:jsx_ext_required = 1  

" -----------------------------indentLine Setup-----------------------------

let g:indentLine_char = '|'
"let g:indentLine_concealcursor=0

" -----------------------------rust.vim------------------------------------
syntax enable
filetype plugin indent on

" -----------------------------vimtex------------------------------------

" Start with \ll -> stop with \lk
" open pdf viewer with \lv
" Logs with \le
let g:tex_flavor='latex'
let g:vimtex_compiler_method='latexmk'
"let g:vimtex_view_method='skim'
let g:vimtex_view_general_viewer = 'evince'
let g:tex_fold_enabled=1
let g:tex_conceal = ""

" -----------------------------coc-prettier-----------------------------

-- command! -nargs=0 Prettier :CocCommand prettier.formatFile


" ----------------------------ARM-syntax------------------------------

au BufNewFile,BufRead *.s,*.S set filetype=armv4 " arm = armv6/7 -- armv5/armv4

" -----------------------------colorscheme settings-----------------------------
"colorscheme molokai
"set termguicolors
"highlight Pmenu ctermbg=Black guibg=Black

" Some colorscheme fixes
"highlight LineNr ctermbg=NONE guibg=NONE
"highlight SignColumn ctermbg=NONE guibg=NONE
" Highlight TODO, FIXME, NOTE, etc.
" '\v\W\zs<(NOTE|INFO|IDEA|TODO|FIXME|CHANGED|XXX|BUG|HACK|TRICKY)>'
" TODO add as own little colorscheme
"syn match celTODO /INFO/
"hi celTODO ctermfg=Red guifg=Red

" -----------------------------rainbow brackets-----------------------------
let g:rainbow_active = 1
