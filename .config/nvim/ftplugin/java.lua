local home = os.getenv("HOME")

local config = {
  capabilities = capabilities,
  cmd = {
    'java',
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
    '-jar', home .. '/.config/nvim/bin/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', home .. '/.config/nvim/bin/jdtls/config_linux',
    '-data', home .. '/Documentos/java'
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw'}),
  settings = { java = {} },
  init_options = {
    bundles = {
		  vim.fn.glob(home .. "/.config/nvim/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.36.0.jar")
	  }
  }
}

config['on_attach'] = function(client, bufnr)
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

require('dap').configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 8787;
  }
}

require('jdtls').start_or_attach(config)