local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		["<space>"] = "SPC",
		["<cr>"] = "RET",
		["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
		n = { "d", "s" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	a = { "<cmd>Alpha<cr>", "Alpha" },
	e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	w = { "<cmd>w!<CR>", "Save" },
	q = { "<cmd>q!<CR>", "Quit" },
	c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	h = { "<cmd>nohlsearch<CR>", "No Highlight" },
	f = { "<cmd>lua require('user.telescope.custom-finders').find_project_files()<cr>", "Find files" },
	P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	Z = { "<cmd>ZenMode<cr>", "Zen" },
	O = { "<cmd>SymbolsOutline<cr>", "Outline" },
	["<space>"] = { "PrevBuffer" },
	S = { "<cmd>lua _NCSPOT_TOGGLE()<cr>", "Spotify" },
	r = { "zR", "Open All Folds" },
	v = { "<c-w>v", "Vertical Split" },
	H = { "<c-w>s", "Horizontal Split" },
	u = { "<cmd>UndotreeToggle<cr>", "Undotree" },

	C = {
		name = "Copilot",
		e = { "<cmd>Copilot enable<cr>", "Enable Copilot" },
		d = { "<cmd>Copilot disable<cr>", "Disable Copilot" },
	},

	b = {
		name = "Buffers",
		j = { "<cmd>BufferLinePick<cr>", "Jump" },
		f = { "<cmd>Telescope buffers<cr>", "Find" },
		b = { "<cmd>b#<cr>", "Previous" },
		d = { "<cmd>bd<cr>", "Delete" },
		e = { "<cmd>%bd|e#<cr>", "Close all but current" },
		h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
		l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
		D = {
			"<cmd>BufferLineSortByDirectory<cr>",
			"Sort by directory",
		},
		L = {
			"<cmd>BufferLineSortByExtension<cr>",
			"Sort by extension",
		},
	},

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		-- l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		y = "Link",
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		l = { "<cmd>GitBlameToggle<cr>", "Blame" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		B = { "<cmd>Telescope git_bcommits<cr>", "Checkout buffer commits" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
		n = { "<cmd>Neogit<cr>", "Neogit" },

		e = {
			name = "edit",
			m = { "<cmd>lua require('igs').edit_modified()<cr>", "modified" },
			s = { "<cmd>lua require('igs').edit_staged()<cr>", "staged" },
			a = { "<cmd>lua require('igs').edit_all()<cr>", "all" },
		},

		q = {
			name = "qf",
			m = { "<cmd>lua require('igs').qf_modified()<cr>", "modified" },
			s = { "<cmd>lua require('igs').qf_staged()<cr>", "staged" },
			a = { "<cmd>lua require('igs').qf_all()<cr>", "all" },
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format {async = true}<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
		R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
	},

	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		o = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		y = { "<cmd>Telescope resume<cr>", "Resume" },
		r = { "<cmd>Telescope frecency<cr>", "Frecency" },
		P = { "<cmd>lua require('telescope').extensions.packer.plugins(opts)<cr>", "Packer" },
		t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
		x = { "<cmd>lua require('user.telescope.custom-finders').find_dotfiles()<cr>", "Dotfiles" },
		g = {
			name = "git",
			s = { "<cmd>Telescope git_status<cr>", "Git status" },
			B = { "<cmd>Telescope git_branches<cr>", "Git branches" },
			c = { "<cmd>Telescope git_commits<cr>", "Git commits" },
			b = { "<cmd>Telescope git_bcommits<cr>", "Git bcommits" },
			t = { "<cmd>Telescope git_stash<cr>", "Git stash" },
			l = { "<cmd>Telescope resume<cr>", "Last Search" },
		},
	},

	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},

	T = {
		name = "Treesitter",
		h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
		p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
	},

	m = {
		name = "Marks",
		a = { "<cmd>BookmarkAnnotate<cr>", "Annotate" },
		-- b = { "<cmd>lua require('telescope').extensions.vim_bookmarks.current_file({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>", "Show Buffer" },
		c = { "<cmd>BookmarkClear<cr>", "Clear" },
		h = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon Mark" },
		u = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon Menu" },
		m = { "<cmd>BookmarkToggle<cr>", "Toggle" },
		j = { "<cmd>BookmarkNext<cr>", "Next" },
		k = { "<cmd>BookmarkPrev<cr>", "Prev" },
		-- q = { "<cmd>BookmarkShowAll<cr>", "Show QF" },
		s = {
			"<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
			"Show All",
		},
		x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
	},

	-- nvim-zk
	o = {
		-- Open the link under the caret.
		-- ["<CR>"] = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Go to link" },
		-- Open notes.
		o = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Open notes" },
		-- Open notes associated with the selected tags.
		t = { "<Cmd>ZkTags<CR>", "Open notes with selected tags" },

		-- Search for the notes matching a given query.
		f = { "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", "Search for notes" },
		-- Search for the notes matching the current visual selection.
		-- Create a new note after asking for its title.

		-- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
		n = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') } <CR>", "New Note" },

		-- Open notes linking to the current buffer.
		b = { "<Cmd>ZkBacklinks<CR>", "Current Backlinks" },
		-- Alternative for backlinks using pure LSP and showing the source context.
		--map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

		-- Open notes linked by the current buffer.
		l = { "<Cmd>ZkLinks<CR>", "Current Links" },

		-- New MOC note
		m = { ':ZkNew { dir = "moc" }<CR>', "New note" },

    j = {
      name="Journal",
      j ={ ':ZkNew { dir = "daily", date = "today" }<CR>', "Today" },
      p ={ ':ZkNew { dir = "daily", date = "yesterday" }<CR>', "Yesterday" },
      n ={ ':ZkNew { dir = "daily", date = "tomorrow" }<CR>', "Tomorrow" },
      -- w ={ ':ZkNew { dir = "journal/weekly", date = "tomorrow" }<CR>', "This Week" },

    }
	},

	-- Neorg
	-- o = {
	-- 	name = "Organization",
	-- 	a = { "<cmd>Neorg inject-metadata<cr>", "Add Metadata" },
	-- 	m = {
	-- 		name = "Mode",
	-- 		h = { "Traverse Heading" },
	-- 		n = { "Neorg Normal" },
	-- 		t = { "Concealers" },
	-- 	},
	-- 	n = {
	-- 		name = "Create",
	-- 		n = { "Note" },
	-- 	},
	-- 	j = {
	-- 		name = "Journal",
	-- 		j = { "<cmd>Neorg journal today<cr>", "Today" },
	-- 		p = { "<cmd>Neorg journal yesterday<cr>", "Yesterday" },
	-- 		n = { "<cmd>Neorg journal tomorrow<cr>", "Tomorrow" },
	-- 	},
	-- 	s = {
	-- 		name = "Search",
	-- 		l = { "<cmd>Telescope neorg find_linkable<cr>", "Linkables" },
	-- 		h = { "<cmd>Telescope neorg search_headings<cr>", "Headings" },
	-- 	},
	-- 	t = {
	-- 		name = "GTD",
	-- 		c = { "Capture" },
	-- 		e = { "Edit" },
	-- 		v = { "Views" },
	-- 	},
	-- 	l = { "<cmd>Telescope neorg insert_link<cr>", "Insert Link" },
	-- },

	-- Telekasten
	-- o = {
	-- 	name = "Organization",
	-- 	o = { ":lua require('telekasten').follow_link()<CR>", "Follow Link" },
	-- 	y = { ":lua require('telekasten').yank_notelink()<CR>", "Yank Link" },
	-- 	p = { ":lua require('telekasten').panel()<CR>", "Panel" },
	-- 	["#"] = { ":lua require('telekasten').show_tags()<CR>", "Show Tags" },
	-- 	n = {
	-- 		name = "Create",
	-- 		n = { ":lua require('telekasten').new_note()<CR>", "New Note" },
	-- 		N = { ":lua require('telekasten').new_templated_note()<CR>", "New Templated Note" },
	-- 		l = { ":lua require('telekasten').insert_link()<CR>", "Insert Link" },
	-- 	},
	-- 	j = {
	-- 		name = "Journal",
	-- 		j = { ":lua require('telekasten').goto_today()<CR>", "Today" },
	-- 		w = { ":lua require('telekasten').goto_thisweek()<CR>", "This Week" },
	-- 		c = { ":lua require('telekasten').show_calendar()<CR>", "Calendar Panel" },
	-- 		C = { ":CalendarT<CR>", "Calendar Full" },
	-- 	},
	-- 	s = {
	-- 		name = "Search",
	-- 		f = { ":lua require('telekasten').find_notes()<CR>", "Find Notes" },
	-- 		d = { ":lua require('telekasten').find_daily_notes()<CR>", "Find Daily Notes" },
	-- 		t = { ":lua require('telekasten').search_notes()<CR>", "Find Note Text" },
	-- 		w = { ":lua require('telekasten').find_weekly_notes()<CR>", "Find Weekly Notes" },
	-- 		b = { ":lua require('telekasten').show_backlinks()<CR>", "Show Backlinks" },
	-- 		l = { ":lua require('telekasten').find_friends()<CR>", "Find Target Friends" },
	-- 	},
	-- 	t = {
	-- 		name = "tasks",
	-- 		t = { ":lua require('telekasten').toggle_todo()<CR>", "Toggle Task" },
	-- 	},
	-- },
}

which_key.setup(setup)
which_key.register(mappings, opts)
