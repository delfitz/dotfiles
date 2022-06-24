require'lualine'.setup {
    options = {
        theme = 'auto',
        section_separators = {'', ''},
        component_separators = {'', ''},
        globalstatus = true
    },

    sections = {
        lualine_a = {{'mode', upper = true}},
        lualine_b = {{'branch', icon = ''}},
        lualine_c = {{'filename', path = 2}},
        lualine_x = {{'diagnostics', sources = {'nvim_diagnostic'}}},
        lualine_y = {{'filetype'}},
        lualine_z = {{'location', separator = '|'}, {'progress'}}
    }
}

require'bufferline'.setup {diagnostics = 'nvim_lsp'}

require'material'.setup {
    italics = {comments = true},
    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = true, -- Enable higher contrast text for darker style
        paleocean = true
    },
    disable = {colored_cursor = false},
    lualine_style = 'default',
    custom_highlights = {Cursor = {bg = '#997722'}}

}

require'Comment'.setup {padding = true}

require'indent_blankline'.setup {show_end_of_line = true}

require'nvim-autopairs'.setup()

require'surround'.setup {mappings_style = 'surround'}

require'shade'.setup {overlay_opacity = 80}

require'colorizer'.setup()
