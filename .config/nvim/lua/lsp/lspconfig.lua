local lspconfig = require 'lspconfig'

local diagnostic = function()
    local opts = {
        focusable = false,
        close_events = {'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost'},
        border = 'rounded',
        source = 'always',
        prefix = '<> ',
        scope = 'line'
    }
    vim.diagnostic.open_float(nil, opts)
end

vim.keymap.set('n', ',e', diagnostic)

local on_attach = function(client, bufnr)
    local opts = {buffer = bufnr}
    vim.keymap.set('n', ',g', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', ',s', require('telescope.builtin').lsp_document_symbols,
                   opts)
    client.resolved_capabilities.document_formatting = false
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

vim.lsp.set_log_level('debug')

require'null-ls'.setup {
    sources = {
        require'null-ls'.builtins.formatting.yapf
        -- require'null-ls'.builtins.diagnostics.flake8
    }
}

lspconfig.pylsp.setup {on_attach = on_attach, capabilities = capabilities}

vim.diagnostic.config({
    virtual_text = {prefix = "»", spacing = 2},
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false
})

local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl})
end

vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = 'single'})

vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'single'})

vim.api.nvim_create_autocmd({'BufWritePre'}, {
    command = [[lua vim.lsp.buf.formatting_sync(nil, 500)]]
})
