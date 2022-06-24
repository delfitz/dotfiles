vim.keymap.set('n', '<C-l>', ':noh<CR>zz')
vim.keymap.set('n', '<leader><leader>', ':bn<CR>')
vim.keymap.set('n', '<leader><Tab>', ':b#<CR>')
vim.keymap.set('n', '<leader>x', ':bw<CR>')

vim.keymap.set('n', 'J', ':m .+1<CR>==')
vim.keymap.set('n', 'K', ':m .-2<CR>==')
vim.keymap.set('n', '<C-k>', '<C-w>w')
vim.keymap.set('n', '<leader>d', ':join<CR>')

-- readline keys
vim.keymap.set('i', '<C-e>', '<C-o>A')
vim.keymap.set('i', '<C-a>', '<C-o>I')

vim.keymap.set('n', 'WW', ':update<CR>')
vim.keymap.set('i', 'WW', '<Esc>:update<CR>')
vim.keymap.set('n', 'QQ', ':qa<CR>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'jk', '<C-G>U<Right>')
vim.keymap.set('i', 'kj', '<C-G>U<Left')

-- material color themes
vim.keymap.set('n', 'mm',
               function() require'material.functions'.toggle_style() end)

-- comment.nvim
vim.keymap.set('n', 'CC',
               function() require'Comment.api'.toggle_current_linewise() end)
vim.keymap.set('v', 'CC',
               '<CMD>lua require("Comment.api").call("toggle_linewise_op")<CR>g@')
vim.keymap.set('v', 'XX',
               '<CMD>lua require("Comment.api").call("uncomment_linewise_op")<CR>g@')
