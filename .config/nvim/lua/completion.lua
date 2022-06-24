vim.o.completeopt = 'menuone,noselect,noinsert'

local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = ({nvim_lsp = '[LSP]'})
        })
    },
    view = {entries = 'custom'},
    window = {
        -- completion = {border = 'rounded'},
        -- documentation = {border = 'rounded'}
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    sources = {{name = 'nvim_lsp'}}
})
