require("mason").setup()

local servers = { "lua_ls", "rust_analyzer", "clangd", "pyright"}

require("mason-lspconfig").setup {
    ensure_installed =  servers,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(_, _)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, {})
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, {})
end
local lspconfig = require "lspconfig"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
