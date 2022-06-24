return require'packer'.startup({
    function()
        use 'wbthomason/packer.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use 'fladson/vim-kitty'
        use 'andrejlevkovitch/vim-lua-format'
        use 'nvim-lualine/lualine.nvim'
        use 'akinsho/bufferline.nvim'
        use 'rainbowhxch/beacon.nvim'
        use 'sunjon/shade.nvim'
        use 'lukas-reineke/indent-blankline.nvim'
        use 'ur4ltz/surround.nvim' -- needs work
        use 'windwp/nvim-autopairs'
        use 'numToStr/Comment.nvim'
        use 'norcalli/nvim-colorizer.lua'
        use 'chriskempson/base16-vim'
        use 'marko-cerovac/material.nvim'

        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/plenary.nvim'}}
        }
        use {'nvim-telescope/telescope-fzy-native.nvim'}

        use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
        use {'RRethy/nvim-treesitter-textsubjects'}

        use 'neovim/nvim-lspconfig'
        use 'jose-elias-alvarez/null-ls.nvim'

        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/nvim-cmp'
        use 'onsails/lspkind-nvim'

    end,
    config = {profile = {enable = true, theshold = 1}}
})
