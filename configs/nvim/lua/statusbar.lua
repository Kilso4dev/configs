
require('lualine')
    .setup{
    options = {
-- i.e:       
        section_separators = '',
        component_separators = '',
        theme = 'onedark',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {
        { 
            'diagnostics',
            sources = {'nvim_lsp','coc'}
        },
        'encoding',
        'fileformat',
        'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {  },
    },
    extensions = { 'fugitive', 'nerdtree' }
}
