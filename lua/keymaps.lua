-- Clear search highlights
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")

-- Close QuickFix windo
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "q", ":cclose<CR>", { buffer = true, noremap = true, silent = true })
	end,
})

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
vim.keymap.set("n", "<C-b>", ":make ", { desc = "Make input", nowait = true })

-- Man
-- vim.keymap.set("n", "<C-m>", ":Man ", { desc = "Manual", nowait = true })

-- File explorer
vim.keymap.set("n", "<C-e>", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Neovim terminal
-- vim.keymap.set("n", "<space>st", function()
-- 	vim.cmd.vnew()
-- 	vim.cmd.term()
-- 	vim.cmd.wincmd("J")
-- 	vim.api.nvim_win_set_height(0, 10)
-- end)

-- Lsp
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "gc", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gs", "<cmd>AerialToggle<cr>", {})

-- Search selection
vim.keymap.set(
	"v",
	"/",
	[[y/\V<C-R>=escape(@", '/\')<CR><CR>]],
	{ noremap = true, silent = true, desc = "Search for visual selection" }
)

-- Dap
vim.keymap.set("n", "<Leader>c", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<Leader>o", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<Leader>i", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<Leader>u", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
	require("dap").set_breakpoint()
end)
vim.keymap.set("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<Leader>dr", function()
	require("dap").repl.open()
end)
vim.keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)

-- vim.keymap.set("n", "<leader>dt", function()
-- 	require("dap").toggle_breakpoint()
-- end, {
-- 	desc = "Debugger: Toggle Breakpoint",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>dc", function()
-- 	require("dap").continue()
-- end, {
-- 	desc = "Debugger: Continue",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>di", function()
-- 	require("dap").step_into()
-- end, {
-- 	desc = "Debugger: Step Into",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>do", function()
-- 	require("dap").step_over()
-- end, {
-- 	desc = "Debugger: Step Over",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>du", function()
-- 	require("dap").step_out()
-- end, {
-- 	desc = "Debugger: Step Out",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>dr", function()
-- 	require("dap").repl.open()
-- end, {
-- 	desc = "Debugger: Open REPL",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>dl", function()
-- 	require("dap").run_last()
-- end, {
-- 	desc = "Debugger: Run Last",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>dq", function()
-- 	require("dap").terminate()
-- 	-- Conditional close for dapui and toggle for virtual-text
-- 	-- to avoid errors if they are not active or loaded.
-- 	local dapui_ok, dapui = pcall(require, "dapui")
-- 	if dapui_ok then
-- 		dapui.close()
-- 	end
-- 	local vtext_ok, vtext = pcall(require, "nvim-dap-virtual-text")
-- 	if vtext_ok then
-- 		vtext.toggle()
-- 	end
-- end, {
-- 	desc = "Debugger: Terminate & Close UI",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>db", function()
-- 	require("dap").list_breakpoints()
-- end, {
-- 	desc = "Debugger: List Breakpoints",
-- 	noremap = true,
-- 	silent = true,
-- })
--
-- vim.keymap.set("n", "<leader>de", function()
-- 	-- dap.set_exception_breakpoints() can take a list of filter IDs.
-- 	-- Common ones are "all", "uncaught". Check your DAP adapter's capabilities.
-- 	require("dap").set_exception_breakpoints({ "all" }) -- or e.g., { "uncaught" }
-- 	-- For Python, for example, you might use:
-- 	-- require("dap").set_exception_breakpoints({ "raised", "uncaught" })
-- 	print("Set exception breakpoints to 'all'") -- Optional feedback
-- end, {
-- 	desc = "Debugger: Set Exception Breakpoints (all)",
-- 	noremap = true,
-- 	silent = false, -- Set to false to see the print message, or true to hide it
-- })
