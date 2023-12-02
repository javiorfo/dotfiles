local home = os.getenv("HOME")
-- local jdk = '/usr/lib/jvm/java-17-openjdk/bin/java'
local jdk = '/usr/lib/jvm/java-21-openjdk/bin/java'

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
  capabilities = capabilities,
  cmd = {
    jdk,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-javaagent:/usr/local/share/lombok/lombok.jar',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', home .. '/.config/nvim/servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.600.v20231012-1237.jar',
    '-configuration', home .. '/.config/nvim/servers/jdtls/config_linux',
    '-data', home .. '/Documentos/java'
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
    java = {
    }
  },
  init_options = {
    bundles = {
        vim.fn.glob("~/.config/nvim/servers/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.36.0.jar")
    }
  }
}

config['on_attach'] = function(client, _)
  client.server_capabilities.semanticTokensProvider = nil
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

local dap = require('dap')

dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 8787;
  },
}

require('jdtls').start_or_attach(config)
