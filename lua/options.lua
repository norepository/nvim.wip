-- [[ Options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Open Oil at startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Only open Oil if no files were specified on the command line
		if #vim.fn.argv() == 0 then
			-- Get the real current working directory
			local cwd = vim.fn.getcwd()

			-- Make sure Oil is loaded before we try to use it
			vim.schedule(function()
				-- Ensure the Oil module is available
				local oil_ok, oil = pcall(require, "oil")
				if oil_ok then
					-- Open Oil with the explicit current working directory
					oil.open(cwd)
				else
					vim.notify("Oil plugin not found", vim.log.levels.WARN)
				end
			end)
		end
	end,
	group = vim.api.nvim_create_augroup("OilOpenCWD", { clear = true }),
	desc = "Open Oil in current directory on startup when no files specified",
})

-- Hide cmd
vim.opt.cmdheight = 0

-- Custom statusline
function search_results()
	-- Check if search mode
	local in_search_mode = vim.fn.mode():match("[/?]") ~= nil

	-- Get the current search data from vim
	local current = vim.fn.searchcount({ recompute = 1, maxcount = -1 })

	-- Only show indicator when actively searching or immediately after
	-- Check both search mode and hlsearch to determine if search is active
	local hlsearch_on = vim.v.hlsearch == 1

	if not (in_search_mode or hlsearch_on) or current.total == 0 then
		return ""
	end

	return string.format("[%d|%d]", current.current, current.total)
end

function filepath()
	local filepath = vim.fn.expand("%:p")

	-- Check if the path starts with "oil://" and crop it
	if vim.startswith(filepath, "oil://") then
		filepath = filepath:gsub("^oil://", "")
		-- Check icloud path
		if vim.startswith(filepath, "/Users/samuele/Library/Mobile Documents/com~apple~CloudDocs/") then
			return filepath:gsub("^/Users/samuele/Library/Mobile Documents/com~apple~CloudDocs/", "ICLOUD_PATH/")
		end
	end
	-- Return original filepath if it doesn't start with "oil://"
	return "%f"
end

local statusline = {
	"%{%v:lua.filepath()%}",
	"%#Normal#",
	"%=",
	"%{%v:lua.search_results()%}",
}

vim.o.statusline = table.concat(statusline, "")

vim.keymap.set("n", "<space>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 10)
end)
-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = false
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- vim: ts=2 sts=2 sw=2 et
