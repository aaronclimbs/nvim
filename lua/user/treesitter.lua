local config_status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not config_status_ok then
	return
end

-- local parsers_status_ok, parsers = pcall(require, "nvim-treesitter.parsers")
-- if not parsers_status_ok then
-- 	return
-- end

-- local parser_configs = parsers.get_parser_configs()

-- parser_configs.norg = {
-- 	install_info = {
-- 		url = "https://github.com/nvim-neorg/tree-sitter-norg",
-- 		files = { "src/parser.c", "src/scanner.cc" },
-- 		branch = "main",
-- 	},
-- }

-- parser_configs.norg_meta = {
-- 	install_info = {
-- 		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
-- 		files = { "src/parser.c" },
-- 		branch = "main",
-- 	},
-- }

-- parser_configs.norg_table = {
-- 	install_info = {
-- 		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
-- 		files = { "src/parser.c" },
-- 		branch = "main",
-- 	},
-- }

configs.setup({
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "norg", "norg_meta", "norg_table", "phpdoc"}, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	playground = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	textsubjects = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-SPC>",
			-- scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
	textobjects = {
		{
			move = {
				enable = true,
				set_jumps = true,

				goto_next_start = {
					["]m"] = "@function.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
				},
			},

			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
		},
	},
})
