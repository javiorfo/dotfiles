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
    use 'javiorfo/nvim-whisky'
    use 'javiorfo/nvim-hemingway'
    use 'javiorfo/nvim-wildcat'
    use 'javiorfo/nvim-fuel'
    use 'javiorfo/nvim-soil'
    use 'javiorfo/nvim-springtime'
    use 'javiorfo/nvim-ship'
    use 'javiorfo/nvim-spinetta'
    use 'javiorfo/nvim-popcorn'
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
        group_empty = true
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

-- Fuel
require'fuel'.setup {
    popup = true
}

-- LSP configuration
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lsp_config = require'lspconfig'

-- Rust
lsp_config.rust_analyzer.setup{}

-- Haskell
lsp_config.hls.setup{}

-- Lua
lsp_config.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = {'vim'}
            },
            telemetry = {
                enable = false
            }
        }
    }
}

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local luasnip = require 'luasnip'

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Mappings
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<Esc>O', opts)
vim.api.nvim_set_keymap('i', '{}', '{}<Left>', opts)
vim.api.nvim_set_keymap('i', '[]', '[]<Left>', opts)
vim.api.nvim_set_keymap('i', '()', '()<Left>', opts)
vim.api.nvim_set_keymap('i', '""', '""<Left>', opts)
vim.api.nvim_set_keymap('i', "''", "''<Left>", opts)

-- LSP
--[[ vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts) ]]

vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr',         '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>di', '<cmd>lua require("telescope.builtin").diagnostics()<CR>', opts)

-- Hemingway
vim.api.nvim_set_keymap('n', '<leader>co', '<Plug>HemingwayComment', opts)
vim.api.nvim_set_keymap('v', '<leader>co', '<Plug>HemingwayMultiComment', opts)

-- NvimTree
vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>NvimTreeFindFile', opts)
vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>NvimTreeClose<CR>', opts)

-- Fuel
vim.api.nvim_set_keymap('n', '<leader>ji', '<Plug>Fuel', opts)
vim.api.nvim_set_keymap('n', '<leader>jc', '<Plug>FuelStop', opts)
