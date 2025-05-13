-- Clear search highlights
vim.keymap.set("n", "<C-c><C-c>", "<cmd>nohlsearch<CR>")

-- Fzf Keymaps
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Fuzzy find files" })
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<cr>", { desc = "Fuzzy grep files" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", { desc = "Fuzzy grep tags in help files" })
vim.keymap.set("n", "<leader>ft", "<cmd>FzfLua btags<cr>", { desc = "Fuzzy search buffer tags" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Fuzzy search opened buffers" })

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Move faster between lines
vim.keymap.set("n", "J", "15j", { desc = "Move 15 lines down" })
vim.keymap.set("n", "K", "15k", { desc = "Move 15 lines up" })

-- Make
vim.keymap.set("n", "<C-b>", "<cmd>make -B<cr>", { desc = "Make build" })

-- Man
vim.keymap.set("n", "<C-m>", ":Man ", { desc = "Manual", nowait = true })

-- File explorer
vim.keymap.set("n", "<C-e>", "<cmd>e .<cr>", { desc = "Open file explorer" })
