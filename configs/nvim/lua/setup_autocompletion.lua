local util = require('util')


local opts = { expr = true, silent = true }
vim.o.completeopt = "menuone,noselect"
util.keymap('i', '<TAB>', [[pumvisible() ? "\<C-n>" : "\<TAB>"]], opts)
util.keymap('i', '<S-TAB>', [[pumvisible() ? "\<C-p>" : "\<C-d>"]], opts)

--[[local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
--]]
--[[
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end
--]]
--keymap("s", "<Tab>", "v:lua.tab_complete()", opts)
--keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", opts)
--keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", opts)
--util.keymap('i', '<C-p>', '<Plug>(completion_trigger)', { silent = true })

--util.keymap('i', '<TAB>', [[pumvisible() ? "\<C-n>" : "\<TAB>"]], opts)
--util.keymap('i', '<S-TAB>', [[pumvisible() ? "\<C-p>" : "\<C-d>"]], opts)
