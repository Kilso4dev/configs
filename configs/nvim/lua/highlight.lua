--vim.g.vimsyn_embed = 'lPr'
local util = require('util')
-- standard highlighting
vim.o.termguicolors = true

--util.highlight('LineNr', 'ctermbg=NONE', 'guibg=NONE')
--util.highlight('SignColumn', 'ctermbg=NONE', 'guibg=NONE')
--util.highlight('CursorLine', 'ctermbg=darkgrey', 'guibg=darkgrey')


-- '\v\W\zs<(NOTE|INFO|IDEA|TODO|FIXME|CHANGED|XXX|BUG|HACK|TRICKY|WIP)>'
-- BUG
-- DEBUG
-- NOTE
local DEBUG = "DEBUG"

local HI_COL = {
    adv_todo_todo={gui='Red', cterm='Red'},
    adv_todo_fixme={gui='Gold', cterm='Yellow'},
    adv_todo_note={gui='Green', cterm='Green'},
}

local KEYWORDS = {
    ['adv_todo_todo'] = {
        'TODO',
        'CHANGED',
        'XXX',
    },
    ['adv_todo_note'] = {
        'NOTE',
        'IDEA',
        'INFO',
        'DEBUG',
    },
    ['adv_todo_fixme'] = {
        'FIXME',
        'WIP',
        'TRICKY',
        'BUG',
        'HACK',
    },
}

local all_keywords = ''
local i = 1

-- Actual highlighting

-- util.cmd('syntax clear Todo')
-- util.cmd([[au Syntax * syn match Todo /\v(]]..all_keywords..[[)/ containedin=.*Comment,vimCommentTitle]])
-- util.highlight('clear', 'Todo')
-- util.highlight('Todo', 'cterm=bold,underline', 'gui=bold,underline', 'guifg='..'Red',  'ctermfg='..'Red')

util.cmd('syntax clear Todo')
util.cmd('augroup nvim_custom_todo')
util.cmd('  au!')
for group, words in pairs(KEYWORDS) do
    local wregex = [[\v\zs\<(]]
    local wregex = [[\v\zs(]]
    for i, cword in ipairs(words) do
        if i ~= 1 then wregex = wregex..'|' end
        wregex = wregex..cword
    end
    wregex = wregex..[[)]]
    --util.cmd('au Syntax * syn match '..group..' /'..wregex..'/ containedin=.*Comment.*')
    util.cmd('au Syntax * syn match '..'Todo'..' /'..wregex..'/ containedin=.*Comment.*')
end
util.cmd('augroup END')

util.highlight('LspCustomHighlight', 'cterm=bold,reverse', 'gui=bold,reverse')
util.cmd('augroup custom_colors')
util.cmd('  au!')
--util.cmd('  au VimEnter * highlight')
for group, color in pairs(HI_COL) do
    util.cmd('au VimEnter * highlight '..group..' cterm=bold gui=bold guifg='..color['gui']..' ctermfg='..color['cterm'])
    -- util.highlight('def', 'link', 'adv_todo_todo', 'Todo')
    --util.highlight('def', 'link', 'adv_todo_note', 'Todo')
    --util.highlight('def', 'link', 'adv_todo_fixme', 'Todo')
end
util.cmd('augroup END')



-- TODO
