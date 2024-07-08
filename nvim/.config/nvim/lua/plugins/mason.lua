return {
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "pyright",
                "lemminx",
                "lua_ls",
                "gopls",
                "docker_compose_language_service",
                "tsserver",
                "jdtls", -- also, remember to install "java-debug-adapter" and "java-test" via Mason command
            },
        },
    },
}
