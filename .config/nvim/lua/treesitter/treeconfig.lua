require'nvim-treesitter.configs'.setup {
    highlight = {enable = true},
    indent = {enable = true},

    textsubjects = {
        enable = true,
        prev_selection = ',',
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner'
        }
    }
}
