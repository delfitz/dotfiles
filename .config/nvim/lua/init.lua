local init = function()
    require 'plugins'
    require 'settings'
    require 'configs'
    require 'autocmds'
    require 'mappings'
    require 'themes'
    require 'completion'
    ---
    require 'telescope.teleconfig'
    require 'treesitter.treeconfig'
    require 'lsp.lspconfig'
end

init()
