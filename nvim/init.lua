-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- personal config
vim.opt.relativenumber = false
vim.opt.number = true

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- vim.cmd.colorscheme("kanagawa-paper-ink")
vim.cmd("colorscheme github_dark_default")

-- require("lazy").setup({
--   "neovim/nvim-lspconfig",
--   "hrsh7th/nvim-cmp",
--   "hrsh7th/cmp-nvim-lsp",
--   "L3MON4D3/LuaSnip",
--   "saadparwaiz1/cmp_luasnip",
-- })

require("lspconfig_setup")
