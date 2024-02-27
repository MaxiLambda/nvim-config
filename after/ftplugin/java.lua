local home = os.getenv('HOME')
local jdtls_setup = require('jdtls.setup')
--maybe add .git
local root_dir = jdtls_setup.find_root({ "pom.xml" })
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_folder = home .. "/.local/share/eclipse/" .. project_name

-- add mapping to clear jdtl cache of current project
vim.keymap("<n>", "<leader>rc", ":!rm -r " .. workspace_folder, { desc = "clear project jdtl cache"})

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
local jar = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", false, false)
local lombok = home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar"
local config = {
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
      },
      project = {
        referencedLibraries = {
          "**/lib/*.jar",
        },
      },
      --configuration = {
      --  runtimes = {
      --    {
      --      name = "JavaSE-21",
      --      path = home .. "/.jdks/graalvm-jdk-21.0.2/"
      --    },
      --  },
      --},
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client, bufnr)
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
    vim.g.on_attach(client, bufnr)
  end,
  --on_init = function(client)
  --  if client.config.settings then
  --    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  --  end
  --end,
  -- stylua: ignore
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. lombok,
    "-jar", jar,
    "-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
    "-data", workspace_folder,
    -- "-Xbootclasspath/a:" .. lombok,
  },
  root_dir = root_dir,
  init_options = {
    bundles = {
      vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    },
    extendedClientCapabilities = extendedClientCapabilities,
  },
}
require("jdtls").start_or_attach(config)
