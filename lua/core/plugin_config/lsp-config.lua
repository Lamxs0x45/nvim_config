require("mason").setup()

local servers = { "lua_ls", "pyright", "cssls", "tsserver" , "rust_analyzer" }

require("mason-lspconfig").setup {
    ensure_installed = servers,
}

local capabilities = require('blink.cmp').get_lsp_capabilities()
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

local clangd_cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--fallback-style=llvm",
    "--header-insertion=never",
}

lspconfig["hls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
lspconfig["gdscript"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
lspconfig["clangd"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = clangd_cmd,
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
