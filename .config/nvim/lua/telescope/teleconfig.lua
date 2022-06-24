require'telescope'.setup {
    pickers = {
        find_files = {theme = 'dropdown'},
        live_grep = {theme = 'dropdown'},
        buffers = {theme = 'ivy'}
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true
        }
    }
}
require'telescope'.load_extension 'fzy_native'

vim.keymap.set('n', 'BB', require'telescope.builtin'.buffers)
vim.keymap.set('n', 'FF', require'telescope.builtin'.find_files)
vim.keymap.set('n', 'GG', require'telescope.builtin'.live_grep)
