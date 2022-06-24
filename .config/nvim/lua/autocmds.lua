local api = vim.api
local cmd = vim.cmd

-- set local path
cmd 'au BufEnter * silent! lcd %:p:h'

cmd 'au BufWritePost _plugins.lua source <afile> | PackerCompile'

-- set conf files to config type
cmd 'au BufRead,BufNewFile *conf setf config'

-- set yaml file indents
cmd 'au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab'

-- add yank highlight
cmd [[au TextYankPost * silent! lua require'highlight'.on_yank("IncSearch", 500, vim.v.event)]]

-- add filetype comments
cmd [[au FileType lua nnoremap <buffer> <leader>c I--<esc>]]

cmd [[au FileType lua nnoremap <buffer> <C-f> :call LuaFormat()<CR> ]]
cmd [[au BufWrite *.lua call LuaFormat() ]]

-- python indent
-- cmd [[au FileType python setlocal indentkeys-=<:>]]
-- cmd [[au FileType python setlocal indentkeys-=:]]
