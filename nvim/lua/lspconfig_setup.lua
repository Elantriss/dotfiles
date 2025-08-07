
local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=true }
    local map = vim.api.nvim_buf_set_keymap
    map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  end
})
