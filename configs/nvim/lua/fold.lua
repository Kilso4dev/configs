local M = {}
local util = require('util')

function M.foldtext()
    local lineStr = vim.api.nvim_buf_get_lines(0, vim.v.foldstart-1, vim.v.foldstart, false)[1]
    return (nil and "" or lineStr) .. ' ... (' .. (vim.v.foldend - vim.v.foldstart) .. ') '
end

function M.setup()
    return [[luaeval("require'fold'.foldtext()")]]
end

return M
