vim.g.mapleader = " "

vim.opt.number = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmode = false
vim.opt.shortmess = vim.opt.shortmess + { F = true, W = true }

-- Mappings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<Esc>O', opts)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function lsp_icons()
  local signs = { Error = " ", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end
  
require("lazy").setup({
    {
        "javiorfo/nvim-nyctophilia",
        lazy = false,
        config = function()
            vim.cmd[[colorscheme umbra]]
        end
    },
    {
        "javiorfo/nvim-minimaline",
        lazy = false,
        config = function()
            require'minimaline'.setup{
                disabled_filetypes = { "NvimTree*" },
                lsp_colors_enabled = true
            }
        end
    },
--[[        {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function()
            require'lualine'.setup {
                options = {
                    disabled_filetypes = { 'NvimTree' }
                }
            }
        end
    }, ]]
    {
        "javiorfo/nvim-hemingway",
        lazy = true,
        dependencies = { "javiorfo/nvim-popcorn" },
        keys = {
            { "<leader>co", "<Plug>HemingwayComment" },
            { "<leader>co", "<Plug>HemingwayMultiComment", mode = "v" },
        }
    },
    {
        "javiorfo/nvim-fuel",
        lazy = true,
        ft = { "java", "lua", "go", "kotlin", "rust" },
        dependencies = { "javiorfo/nvim-popcorn" },
        config = function()
            require'fuel'.setup { popup = true }
        end,
        keys = {
            { "<leader>ji", "<Plug>Fuel" },
            { "<leader>jc", "<Plug>FuelStop" }
        }
    },
    {
        "javiorfo/nvim-wildcat",
        lazy = true,
        cmd = { "WildcatRun", "WildcatClean", "WildcatUp", "WildcatInfo" },
        dependencies = { "javiorfo/nvim-popcorn" }
    },
    {
        "javiorfo/nvim-soil",
        lazy = true,
        ft = "plantuml"
    },
    {
        "javiorfo/nvim-springtime",
        lazy = true,
        cmd = "Springtime",
        dependencies = { "javiorfo/nvim-popcorn" }
    },
    {
        "javiorfo/nvim-ship",
        lazy = true,
        ft = "ship",
        cmd = { "ShipCreate", "ShipCreateEnv" },
        dependencies = { "javiorfo/nvim-popcorn", "javiorfo/nvim-spinetta" },
        config = function()
            require'ship'.setup {
                response = {
                    window_type = 'p',
                    size = 30
                },
                special = dofile("/path/to/special.lua")
            }
        end,
        keys = {
            { "<leader>sh", "<cmd>Ship<cr>" },
            { "<leader>sc", "<cmd>ShipCloseResponse<cr>" }
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.g.loaded = 1
            vim.g.loaded_netrwPlugin = 1

            require'nvim-tree'.setup {
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
        end,
        keys = {
            { "<C-g>", "<cmd>NvimTreeFindFile<cr>" },
            { "<C-c>", "<cmd>NvimTreeClose<cr>" },
        }
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
            { "gr",         "<cmd>lua require'telescope.builtin'.lsp_references()<cr>" },
            { "<leader>di", "<cmd>lua require'telescope.builtin'.diagnostics()<cr>" }
        }
    },
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        ft = { "lua", "go", "kotlin", "rust" },
        config = function()
            lsp_icons()
          
            local on_attach = function(client, _)
                client.server_capabilities.semanticTokensProvider = nil
            end

            local lsp_config = require'lspconfig'
        
            -- Go
            lsp_config.gopls.setup{ on_attach = on_attach }

            -- Kotlin
            lsp_config.kotlin_language_server.setup {
                on_attach = on_attach,
                root_dir = lsp_config.util.root_pattern("settings.gradle", "settings.gradle.kts", "pom.xml");
            }

            -- Rust
            lsp_config.rust_analyzer.setup { 
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = { command = "clippy" }
                    }
                }
            }

            -- Lua
            lsp_config.lua_ls.setup {
                on_attach = on_attach,
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
        end,
        keys = {
            { 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>' },
            { 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>' },
            { 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>' },
            { 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>' },
            { '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
            { '<leader>e',  '<cmd>lua vim.diagnostic.open_float()<CR>' },
            { '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>' },
            { '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>' },
            { '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>' },
            { '<leader>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>' },
            { '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>' },
            { '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>' },
            { '<leader>f',  '<cmd>lua vim.lsp.buf.format{ async = true }<CR>' }
        }
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "saadparwaiz1/cmp_luasnip",
          "L3MON4D3/LuaSnip"
        },
        config = function()
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
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
        ft = "java"
    },
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        ft = "java"
    }
})
