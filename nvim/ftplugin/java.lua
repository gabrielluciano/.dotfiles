-- local config = {
--     cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
--    root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", "mvnw", ".git" }, { upward = true })[1]),
-- }
-- require("jdtls").start_or_attach(config)

local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/jdtls-workspace"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), "p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
    return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
        "-jar", vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
        "-data", workspace_dir
    },

    root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),

    settings = {
        java = {
            signatureHelp = { enabled = true },
            extendedClientCapabilities = extendedClientCapabilities,
        }
    },

    init_options = {
        bundles = {}
    },
}

require("jdtls").start_or_attach(config)

