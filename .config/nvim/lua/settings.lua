local opt = vim.opt

vim.keymap.set({'n', 'v'}, ',', '<Nop>', {silent = true})
vim.g.mapleader = ','
vim.g.maplocalleader = ','

opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.updatetime = 250

opt.hidden = true
opt.clipboard = 'unnamedplus'

opt.autoindent = true
opt.wrap = false
opt.joinspaces = false

opt.scrolloff = 4
opt.sidescroll = 10

opt.whichwrap = '<,>,[,]'

opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = 'number'
opt.showmode = false

opt.termguicolors = true
opt.cursorline = true

opt.guicursor = ''

opt.splitright = true

opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true
opt.smartindent = true
