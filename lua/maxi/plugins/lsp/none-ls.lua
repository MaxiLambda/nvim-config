return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  lazy = true,
  -- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")

    local null_ls = require("null-ls")

    mason_null_ls.setup({
      ensure_installed = {
        "stylua",   -- lua formatter
        "fourmolu", -- lua formatter
      },
    })

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters

    -- configure null_ls
    null_ls.setup({
      -- setup formatters & linters
      sources = {
        formatting.stylua,    -- lua formatter
        formatting.fourmolu,  -- haskell formatting
      },
    })
  end,
}
