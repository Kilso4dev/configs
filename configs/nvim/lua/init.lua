local util = require('util')

--vim.o.guifont='Fantasque Sans Mono,PowerlineSymbols,Unifont,Font Awesome 5 Free:h16'
--vim.o.guifont='Monofur Nerd Font Mono Bold,Unifont,Font Awesome 5 Free,PowerlineSymbols:h14'
vim.o.guifont='agave Nerd Font Mono,Unifont,PowerlineSymbols:h12:b'
--vim.o.guifont='FiraMono Nerd Font Mono,Unifont:h14'
--vim.o.guifont='*'

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.cpoptions = vim.o.cpoptions..'n'

vim.o.backup = false
vim.o.writebackup = false

vim.o.cmdheight = 2
vim.o.shortmess = vim.o.shortmess..'c'
vim.wo.signcolumn = 'yes'

vim.o.showcmd = true
vim.o.wildmenu = true

vim.o.conceallevel = 0
vim.o.updatetime = 300

-- Search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true


-- UI
vim.o.hidden = true
vim.o.showmatch = true
vim.wo.cursorline = true

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- folding
vim.wo.foldenable = true
vim.o.foldlevelstart = 0
vim.wo.foldnestmax = 99
vim.wo.foldmethod = 'syntax'
vim.wo.foldtext = require'fold'.setup()


-- TODO Fix listchars
--vim.o.list = true
--vim.o.listchars = 'tab:|'


-- indentation
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4


util.colorscheme('one')
util.cmd('set background=dark')
--util.colorscheme('torte')

-- custom keymapping
require('keymaps')

-- custom fast-calculator based on lua execution
--require('calc')

require('commands') -- Utility commands
require('statusbar')

require('gitlens') -- Custom gitlens file

require('setup_lsp') -- Lsp and autocompletion setup 

-- Custom highlighting
require('highlight')
