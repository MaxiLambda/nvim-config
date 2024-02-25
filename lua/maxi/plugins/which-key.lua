return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wk = require("which-key")
    wk.setup()

    --register intermediate menu descriptions
    wk.register({
      f = { name = "find" },
      c = {
        name = "code actions",
        b = { name = "breakpoint actions" },
        d = { name = "debug options" },
      },
      e = { name = "file explorer" },
      g = { name = "git" },
      n = { name = "no/hide" },
      s = { name = "window splits" },
      t = { name = "tabs" },
    }, { prefix = "<leader>" })
  end,
}
