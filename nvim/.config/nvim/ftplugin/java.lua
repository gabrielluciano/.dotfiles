-- jdtls path
local jdtls_path = require('mason-registry').get_package('jdtls'):get_install_path()

-- Lombok jar
local lombok_jar = jdtls_path .. '/lombok.jar'

-- Java Debug Adapter
local java_debug_path = require('mason-registry').get_package('java-debug-adapter'):get_install_path()
local bundles = {
  vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true),
}

-- Java Test
local java_test_path = require('mason-registry').get_package('java-test'):get_install_path()
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar', true), '\n'))

local config = {
  cmd = {
    jdtls_path .. '/bin/jdtls',
    string.format('--jvm-arg=-javaagent:%s', lombok_jar),
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  init_options = {
    bundles = bundles,
  },
}

require('jdtls').start_or_attach(config)
