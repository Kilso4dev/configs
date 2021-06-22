local util = require('util')

-- Hex editing
util.command('Hex', '%!xxd')
util.command('Hexrev', '%!xxd -r')

-- convenience write/quit commands
util.command('WQ', 'wq')
util.command('Wq', 'wq')
util.command('W', 'w')
util.command('Q', 'q')

--[[
" automatching brackets:
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O
--]]

--"command Tasks !grep --exclude-dir=.git -rEIn "TODO|FIXME|NOTE" . 2>/dev/null
-- HACK
-- TODO: 
