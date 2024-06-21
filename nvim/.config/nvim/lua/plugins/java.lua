return {
    {
        "mfussenegger/nvim-jdtls",
        opts = function()
            local home = os.getenv("HOME")
            local workspace_path = home .. "/.local/share/jdtls-workspace"
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), "p:h:t")
            local workspace_dir = workspace_path .. project_name
            return {
                -- How to find the root dir for a given filename. The default comes from
                -- lspconfig which provides a function specifically for java projects.
                root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,

                -- How to find the project name for a given root dir.
                project_name = function(root_dir)
                    return root_dir and vim.fs.basename(root_dir)
                end,

                -- Where are the config and workspace dirs for a project?
                jdtls_config_dir = function(project_name)
                    return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
                end,
                jdtls_workspace_dir = function(project_name)
                    return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
                end,

                -- How to run jdtls. This can be overridden to a full java command-line
                -- if the Python wrapper script doesn't suffice.
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xmx1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens",
                    "java.base/java.util=ALL-UNNAMED",
                    "--add-opens",
                    "java.base/java.lang=ALL-UNNAMED",
                    "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
                    "-jar",
                    vim.fn.glob(
                        home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
                    ),
                    "-configuration",
                    home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
                    "-data",
                    workspace_dir,
                },
                full_cmd = function(opts)
                    local cmd = vim.deepcopy(opts.cmd)
                    return cmd
                end,

                -- These depend on nvim-dap, but can additionally be disabled by setting false here.
                dap = { hotcodereplace = "auto", config_overrides = {} },
                dap_main = {},
                test = true,
                settings = {
                    java = {
                        inlayHints = {
                            parameterNames = {
                                enabled = "all",
                            },
                        },
                    },
                },
            }
        end,
    },
}
