return {
  'mrcjkb/haskell-tools.nvim',
  version = '^3', -- Recommended
  t = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  config = function ()
    vim.g.haskell_tools = {
      hls = {
        on_attach = vim.g.on_attach()
      }
    }
  end
}
