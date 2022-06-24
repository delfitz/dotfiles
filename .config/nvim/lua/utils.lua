local api = vim.api
local cmd = vim.cmd
local M = {}

function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

function M.set_options(locality, options)
    local scopes = {o = vim.o, b = vim.b, g = vim.g, w = vim.wo}
    local scope = scopes[locality]

    for k, v in pairs(options) do scope[k] = v end
end

function M.map(type, input, output) api.nvim_set_keymap(type, input, output, {}) end

function M.noremap(type, input, output)
    api.nvim_set_keymap(type, input, output, {noremap = true, silent = true})
end

function M.remap(type, input, output)
    api.nvim_set_keymap(type, input, output, {noremap = false, silent = true})
end

function M.nnoremap(input, output) M.noremap('n', input, output) end

function M.inoremap(input, output) M.noremap('i', input, output) end

function M.vnoremap(input, output) M.noremap('v', input, output) end

function M.tnoremap(input, output) M.noremap('t', input, output) end

function M.nmap(input, output) M.remap('n', input, output) end

function M.imap(input, output) M.remap('i', input, output) end

function M.vmap(input, output) M.remap('v', input, output) end

function M.tmap(input, output) M.remap('t', input, output) end

return M
