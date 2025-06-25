-- PDF Zathura Opener for Neovim
-- Place this in ~/.config/nvim/lua/pdf-opener.lua or add to your init.lua

local M = {}

-- Function to check if zathura is available
local function is_zathura_available()
	local handle = io.popen("which zathura 2>/dev/null")
	local result = handle:read("*a")
	handle:close()
	return result ~= ""
end

-- Function to open PDF with zathura
local function open_with_zathura(filepath)
	if not is_zathura_available() then
		vim.notify("Zathura is not installed or not in PATH", vim.log.levels.ERROR)
		return
	end

	-- Use vim.fn.jobstart for non-blocking execution
	vim.fn.jobstart({ "zathura", filepath }, {
		detach = true,
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				vim.notify("Failed to open PDF with Zathura", vim.log.levels.ERROR)
			end
		end,
	})

	-- Close the buffer after opening with zathura
	vim.schedule(function()
		vim.cmd("bdelete")
	end)
end

-- Function to check if file is a PDF
local function is_pdf_file(filepath)
	return filepath and filepath:match("%.pdf$") ~= nil
end

-- Auto command to handle PDF files
local function setup_pdf_autocmd()
	vim.api.nvim_create_augroup("PDFOpener", { clear = true })

	vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
		group = "PDFOpener",
		pattern = "*.pdf",
		callback = function(args)
			local filepath = args.file
			if filepath and vim.fn.filereadable(filepath) == 1 then
				open_with_zathura(filepath)
				return true -- Prevent normal buffer loading
			end
		end,
	})
end

-- Manual command to open current buffer with zathura
local function create_user_command()
	vim.api.nvim_create_user_command("OpenPDF", function()
		local filepath = vim.fn.expand("%:p")
		if is_pdf_file(filepath) then
			open_with_zathura(filepath)
		else
			vim.notify("Current file is not a PDF", vim.log.levels.WARN)
		end
	end, {
		desc = "Open current PDF file with Zathura",
	})
end

-- Setup function
function M.setup(opts)
	opts = opts or {}

	-- Set up auto command by default
	if opts.auto_open ~= false then
		setup_pdf_autocmd()
	end

	-- Create user command
	create_user_command()

	-- Optional: Create a keybinding
	if opts.keymap then
		vim.keymap.set("n", opts.keymap, ":OpenPDF<CR>", {
			desc = "Open PDF with Zathura",
			silent = true,
		})
	end
end

-- Direct setup call if used as a standalone script
M.setup()

return M
