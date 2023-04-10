-- Personal
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
vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>NvimTreeFindFile | NvimTreeFocus<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>NvimTreeClose<CR>', opts)

-- Fuel
vim.api.nvim_set_keymap('n', '<leader>ji', '<Plug>Fuel', opts)
vim.api.nvim_set_keymap('n', '<leader>jc', '<Plug>FuelStop', opts)
