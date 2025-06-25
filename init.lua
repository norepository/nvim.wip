require("config.lazy")

require("keymaps")

require("options")

require("pdf-opener").setup({
	auto_open = true, -- Automatically open PDFs with zathura
	keymap = "<leader>pf", -- Optional: set a keybinding
})
