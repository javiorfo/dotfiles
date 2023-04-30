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

-- Mappings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<Esc>O', opts)
vim.api.nvim_set_keymap('i', '{}', '{}<Left>', opts)
vim.api.nvim_set_keymap('i', '[]', '[]<Left>', opts)
vim.api.nvim_set_keymap('i', '()', '()<Left>', opts)
vim.api.nvim_set_keymap('i', '""', '""<Left>', opts)
vim.api.nvim_set_keymap('i', "''", "''<Left>", opts)

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

require("lazy").setup({
    {
        "javiorfo/nvim-whisky",
        lazy = false,
        config = function()
            vim.cmd[[colorscheme malt]]
        end
    },
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
        ft = { "c", "cpp", "go", "haskell", "java", "kotlin", "lua", "python", "rust", "scala" },
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
        cmd = { "WildcatRun", "WildcatUp", "WildcatInfo" },
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
                    window_type = 'p'
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

            local function open_nvim_tree(data)
              local directory = vim.fn.isdirectory(data.file) == 1
              if not directory then
                return
              end
              vim.cmd.cd(data.file)
              require("nvim-tree.api").tree.open()
            end

            vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
        end,
        keys = {
            { "<C-g>", "<cmd>NvimTreeFindFile<cr>" },
            { "<C-c>", "<cmd>NvimTreeClose<cr>" },
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function()
            require'lualine'.setup {
                options = {
                    disabled_filetypes = { 'NvimTree' }
                }
            }
        end
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
        ft = { "lua", "rust", "c", "haskell" },
        config = function()
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
              local hl = "DiagnosticSign" .. type
              vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            local lsp_config = require'lspconfig'

            -- Rust
            lsp_config.rust_analyzer.setup{}
            
            -- C
            lsp_config.clangd.setup{}
            
            -- Haskell
            lsp_config.hls.setup{}
            
            -- Kotlin
            [[ lsp_config.kotlin_language_server.setup {
                root_dir = lsp_config.util.root_pattern("settings.gradle", "pom.xml");
            } ]]

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
        end,
        keys = {
            { 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>' },
            { 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>' },
            { 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>' },
            { 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>' },
            { '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
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
          "hrsh7th/cmp-buffer",
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
        ft = "java",
        config = function()
            local home = os.getenv("HOME")
            local jdk = '/usr/lib/jvm/java-11-openjdk/bin/java'
--             local jdk = '/usr/lib/jvm/java-17-openjdk/bin/java'

            local config = {
              capabilities = capabilities,
              cmd = {
                jdk,
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-Xms1g',
                '-javaagent:/usr/local/share/lombok/lombok.jar',
                '--add-modules=ALL-SYSTEM',
                '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                '-jar', home .. '/.config/nvim/servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
                '-configuration', home .. '/.config/nvim/servers/jdtls/config_linux',
                '-data', home .. '/Documentos/java'
              },
              root_dir = require('jdtls.setup').find_root({'.git', 'mvnw'}),
              settings = {
                java = {
                }
              },
              init_options = {
                bundles = {
                    vim.fn.glob("~/.config/nvim/servers/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.36.0.jar")
                }
              }
            }

            config['on_attach'] = function(client, bufnr)
              require('jdtls').setup_dap({ hotcodereplace = 'auto' })
            end

            local dap = require('dap')

            dap.configurations.java = {
              {
                type = 'java';
                request = 'attach';
                name = "Debug (Attach) - Remote";
                hostName = "127.0.0.1";
                port = 8787;
              },
            }

            require('jdtls').start_or_attach(config)
        end
    },
    {
        "mfussenegger/nvim-dap",
        lazy = true,
    }
})
