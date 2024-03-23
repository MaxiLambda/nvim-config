local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()

--vim.g.on_attach()
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run,
  { noremap = true, silent = true, buffer = bufnr, desc = "run codelens" })
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<space>cs', ht.hoogle.hoogle_signature,
  { noremap = true, silent = true, buffer = bufnr, desc = "hoogle signature" })
vim.keymap.set('n', '<leader>cr', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
  end,
  { noremap = true, silent = true, buffer = bufnr, desc = "toggle repl for this buffer" })
vim.keymap.set('n', '<leader>ra', function()
  vim.lsp.buf_attach_client(0, 1)
end, { noremap = true, silent = true, buffer = bufnr, desc = "attach buffer to ls with id 1"})

ht.dap.discover_configurations(bufnr, { autodetect = true })
