return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
	  columns = {
		  "permissions",
		  "mtime",
		  "size",
		  -- "icon",
	  },
	  view_options = { 
		  show_hidden = true,
	  },
  },
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, 
  lazy = false,
}
