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
    use 'charkuils/nvim-whisky'
    use 'charkuils/nvim-hemingway'
    use 'charkuils/nvim-wildcat'
    use 'charkuils/nvim-fuel'
    use 'charkuils/nvim-soil'
    use 'charkuils/nvim-mug'
    use 'charkuils/nvim-ship'
    use 'charkuils/nvim-spinetta'
    use 'neovim/nvim-lspconfig'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-jdtls'
    use 'nvim-lualine/lualine.nvim'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
  end
)

-- colorscheme
vim.cmd [[colorscheme malt]]

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

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end
  vim.cmd.cd(data.file)
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Lualine
require'lualine'.setup{
    options = {
        disabled_filetypes = { 'NvimTree' }
    }
}

require'lsp'
require'mappings'
