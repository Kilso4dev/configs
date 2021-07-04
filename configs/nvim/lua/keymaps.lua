local utils = require('util')

local opts = { silent = true, noremap = true }

local maps = {
  -- Emacs 
  {'i', '<C-A>', '<esc>^i', opts},
  {'i', '<C-E>', '<esc>$a', opts},

  -- exit modes
  {'', '<C-c>', '<esc>', opts},

  -- Convenience maps for alternate buffer
  {'i', '<C-^>', ':e #', opts},

  -- Building
  {'', '<F2>', ':make<CR>', opts}, -- Build via Makefile
  {'', '<F3>', ':make run<CR>', opts}, -- Build and run via Makefile
}

for c in ipairs(maps) do
  utils.keymap(unpack(maps[c]))
end


--[[
utils.keymap('i', '<C-F>', '<esc>li', opts)
utils.keymap('i', '<A-F>', '<esc>wi', opts)


utils.keymap('i', '<C-B>', '<esc>hi', opts)
utils.keymap('i', '<A-B>', '<esc>bi', opts)

utils.keymap('i', '<C-P>', '<esc>ki', opts)
utils.keymap('i', '<C-N>', '<esc>ji', opts)
--]]
-- utils.keymap('', '<F2>', '', { silent=true, noremap=true })
--utils.keymap('', '<C-v><F12>', '<C-R>=make run<CR>', { silent=true, noremap=true, expr=true })

