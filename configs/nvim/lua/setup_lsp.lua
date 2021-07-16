local util = require('util')
local nvim_lsp = require('lspconfig')

-- nvim-compe setup
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = false;
    treesitter = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true else return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<C-d>"
  end
end

local opts = {expr = true, noremap=true, silent=true}
util.keymap("i", "<Tab>", "v:lua.tab_complete()", opts)
util.keymap("s", "<Tab>", "v:lua.tab_complete()", opts)
util.keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", opts)
util.keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", opts)
--[[
local opts = { expr = true, silent = true }
util.keymap('i', '<TAB>', [[pumvisible() ? "\<C-n>" : "\<TAB>"], opts)
util.keymap('s', '<TAB>', [[pumvisible() ? "\<C-n>" : "\<TAB>"], opts)
util.keymap('i', '<S-TAB>', [[pumvisible() ? "\<C-p>" : "\<C-d>"], opts)
util.keymap('s', '<S-TAB>', [[pumvisible() ? "\<C-p>" : "\<C-d>"], opts)
--]]

-- nvim-lsp-config setup
local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    util.keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    util.keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    util.keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    util.keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    util.keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

    util.keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    util.keymap('n', '<C-p>', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    util.keymap('n', '<C-n>', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    util.keymap('n', '[g', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    util.keymap('n', ']g', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    util.keymap('n', '<space>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts) 

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        cmds = {
            "hi LspReferenceRead cterm=bold,reverse gui=bold,reverse",
            "hi LspReferenceWrite cterm=bold,reverse gui=bold,reverse",
            "hi LspReferenceText cterm=bold,reverse gui=bold,reverse",
            "augroup lsp_document_highlight",
                "autocmd! * <buffer>",
                "autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()",
                "autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()",
            "augroup END",
        }

        for i, ccmd in ipairs(cmds) do
            vim.api.nvim_exec(ccmd, false)
        end
    end

end
-- setup language servers and autocompletion

-- setup/install elixir-ls if not existing:
-- curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
-- unzip elixir-ls.zip -d /path/to/elixir-ls
-- chmod +x /path/to/elixir-ls/language_server.sh


local servers = {
    ['rls'] = {},
    ['rust_analyzer'] = {},
    ['pyright'] = {},
    ['clangd'] = {},
    --['ccls'] = {},
    ['tsserver'] = {},
    ['elixirls'] = {cmd = {'~/.config/nvim/lsps/elixir-ls/language_server.sh'}},
}
local custom_servers = {

}


for lsp, setup in pairs(servers) do
    local setup_pre = setup;
    setup_pre['on_attach'] = on_attach;

    nvim_lsp[lsp].setup(setup_pre)
end
