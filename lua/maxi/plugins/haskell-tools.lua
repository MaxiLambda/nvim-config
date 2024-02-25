return {
  'mrcjkb/haskell-tools.nvim',
  version = '^3', -- Recommended
  ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  config = function()

    vim.g.on_attach()


    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local lspconfig = require("lspconfig")

    lspconfig["hls"].setup({
      capabilities = capabilities})

    local ht = require('haskell-tools')
    local bufnr = vim.api.nvim_get_current_buf()
    -- haskell-language-server relies heavily on codeLenses,
    -- so auto-refresh (see advanced configuration) is enabled by default
    vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run,
      { noremap = true, silent = true, buffer = bufnr, desc = "run codelens" })
    -- Hoogle search for the type signature of the definition under the cursor
    vim.keymap.set('n', '<space>cs', ht.hoogle.hoogle_signature,
      { noremap = true, silent = true, buffer = bufnr, desc = "hoogle signature" })
  end
}
