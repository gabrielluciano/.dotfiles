local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls",
        "gopls",
        "docker_compose_language_service",
        "tsserver",
        "jdtls",
    },
    handlers = {
        function(server_name)
            if server_name ~= "jdtls" then
                require('lspconfig')[server_name].setup({})
            end
        end,
        -- Specific servers configuration
    },
})

