-- Map Leader
vim.g.mapleader = " "

-- Basics
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Split Orientation
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- Plugins
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'javi-7/nvim-osfa'
    use 'javi-7/nvim-nyctovim'
    use 'javi-7/nvim-hemingway'
    use 'javi-7/nvim-wildcat'
    use 'javi-7/nvim-executor'
    use 'javi-7/nvim-modelizer'
    use 'javi-7/nvim-spraven'
    use 'javi-7/nvim-vurl'
    use 'neovim/nvim-lspconfig'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-jdtls'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'nvim-lualine/lualine.nvim'
  end
)

-- colorscheme
vim.cmd [[colorscheme silentium]]

-- NvimTree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require'nvim-tree'.setup{
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true
    },
    renderer = {
        group_empty = true,
        icons = {
            glyphs = {
                folder = {
                    arrow_open = "",
                    arrow_closed = ""
                }
            }
        }
    },
    filters = {
        dotfiles = true
    }
}

-- Lualine
require'lualine'.setup{
    options = {
        disabled_filetypes = { 'NvimTree' }
    }
}

require'lsp'
require'mappings'
