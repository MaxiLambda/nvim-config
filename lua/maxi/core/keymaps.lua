-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General Keymaps -------------------

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>nr", ":noae<CR>", { desc = "disable automatic resizing" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- imporved yank actions
keymap.set("n", "yp", "yyp", { desc = "duplicate line" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>tt", "<c-w>s<cmd>term<CR><cmd>resize 12<CR>", { desc = "open a terminal" })

-- experimental
-- replace word under cursor in file
keymap.set("n", "<leader>fw", "yiw:%s/<c-r>0/", { desc = "replace word under cursor" })

-- refresh buffer
keymap.set("n", "<leader>br", "<cmd>w|bd|e#<CR>", { desc = "refresh buffer" })
keymap.set("n", "<leader>bc", "<cmd>wa|%bd|e#|bd#<CR>", { desc = "close all but this buffer" })
keymap.set("n", "<leader>ba", "<cmd>wa|%bd<CR>", { desc = "close all buffers" })

-- exit termianls
keymap.set("t", "<C-s>", '<C-\\><C-n>', { desc = "exit terminal" })

-- git mappings
vim.keymap.set("n", "<leader>gb", ":Flog<CR>", { desc = "show branches", noremap = true, silent = true });
vim.keymap.set("n", "<leader>gs", ":Flogsplit<CR>", { desc = "show branches in split", noremap = true, silent = true });
