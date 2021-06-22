local M = {}

M.keymap = vim.api.nvim_set_keymap
M.delKeymap = vim.api.nvim_del_keymap

M.cmd = vim.api.nvim_command

function anyCmd(cmd, ...)
    local var_len = select('#', ...)
    local as_str = ' '
    for i = 1, var_len, 1 do
    as_str = as_str..select(i, ...)..(i==var_len and '' or ' ')
    end
    return vim.api.nvim_command(cmd .. as_str)
end

function M.command(...)
    anyCmd('command', ...)
end

function M.colorscheme(...)
    anyCmd('colorscheme', ...)
end

function M.highlight(...)
    anyCmd('highlight', ...)
end

function M.syn_match(groupName, regex)
    anyCmd('syn', 'match', groupName, regex)
end

function M.prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end

    print('Couldn\'t load "'.. ... .. '[...]", ignoring..')
    return nil
end


return M
