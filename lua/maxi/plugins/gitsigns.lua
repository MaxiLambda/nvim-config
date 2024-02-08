return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup()

    vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<cr>",
      { desc = "show git diff", noremap = true, silent = true })
  end,
}
