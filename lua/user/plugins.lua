local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  log = { level = warn },
  git = {
    clone_timeout = 300,
    subcommands = {
      -- this is more efficient than what Packer is using
      fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
    },
  },
  max_jobs = 50,
  -- display = {
  -- 	open_fn = function()
  -- 		return require("packer.util").float({ border = "rounded" })
  -- 	end,
  -- },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff
  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")
  use("nvim-lualine/lualine.nvim")
  use("akinsho/toggleterm.nvim")
  use("ahmedkhalf/project.nvim")
  use("lewis6991/impatient.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("goolord/alpha-nvim")
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

  use("folke/which-key.nvim")
  -- use({
  -- 	"jedi2610/nvim-rooter.lua",
  -- 	config = function()
  -- 		require("nvim-rooter").setup({
  -- 			rooter_patters = {
  -- 				".git",
  -- 				"Makefile",
  -- 				"_darcs",
  -- 				".hg",
  -- 				".bzr",
  -- 				".svn",
  -- 				"node_modules",
  -- 				"CMakeLists.txt",
  -- 			},
  -- 		})
  -- 	end,
  -- })

  use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", ft = { "markdown" } })

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use("lunarvim/darkplus.nvim")
  use("folke/tokyonight.nvim")
  use("rebelot/kanagawa.nvim")

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")

  --[[ use("github/copilot.vim") ]]
  use({
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })
  -- productivity
  use("christoomey/vim-tmux-navigator")
  use({
    "folke/zen-mode.nvim",
    config = function()
      require("user.zen").config()
    end,
  })
  use("chaoren/vim-wordmotion")

  use({
    "ThePrimeagen/harpoon",
  })
  -- NOTE: Whichkey breaks this unfortunately
  use({
    "MattesGroeger/vim-bookmarks",
    config = function()
      -- highlight BookmarkSign ctermbg=NONE ctermfg=160
      -- highlight BookmarkLine ctermbg=194 ctermfg=NONE
      vim.g.bookmark_sign = ""
      vim.g.bookmark_annotation_sign = "☰"
      vim.g.bookmark_no_default_key_mappings = 1
      vim.g.bookmark_auto_save = 0
      vim.g.bookmark_auto_close = 0
      vim.g.bookmark_manage_per_buffer = 0
      vim.g.bookmark_save_per_working_dir = 0
      -- vim.g.bookmark_highlight_lines = 1
      vim.g.bookmark_show_warning = 0
      vim.g.bookmark_center = 1
      vim.g.bookmark_location_list = 0
      vim.g.bookmark_disable_ctrlp = 1
      vim.g.bookmark_display_annotation = 0
    end,
    commit = "a86f6387a5dabf0102b4cab433b414a29456f792",
  })
  use({
    "tom-anders/telescope-vim-bookmarks.nvim",
  })

  use({
    "simrat39/symbols-outline.nvim",
    config = function()
      require("user.outline").config()
    end,
  })

  use({
    "folke/todo-comments.nvim",
    config = function()
      require("user.todo_comments").config()
    end,
  })

  use({
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  })
  use({
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
  })

  -- editor
  use({
    "jeffkreeftmeijer/vim-numbertoggle",
  })
  -- use({
  -- 	"ggandor/lightspeed.nvim",
  -- 	config = function()
  -- 		require("lightspeed").setup({
  -- 			ignore_case = true,
  -- 		})
  -- 	end,
  -- })
  use({
    "phaazon/hop.nvim",
    requires = "unblevable/quick-scope",
    config = function()
      require("user.hop").config()
    end,
  })
  use({
    "tpope/vim-repeat",
  })

  -- use({
  -- 	"ur4ltz/surround.nvim",
  -- 	config = function()
  -- 		require("surround").setup({})
  -- 	end,
  -- })

  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  })

  use("tpope/vim-unimpaired")

  use({
    "mbbill/undotree",
  })
  use({
    "mattn/emmet-vim",
  })
  use({
    "derektata/lorem.nvim",
    requires = "vim-scripts/loremipsum",
  })
  use({
    "AckslD/nvim-neoclip.lua",
    requires = { "kkharji/sqlite.lua", module = "sqlite" },
    config = function()
      require("neoclip").setup({
        history = 1000,
        enable_persistent_history = false,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        filter = nil,
        preview = true,
        default_register = '"',
        content_spec_column = false,
        on_paste = {
          set_reg = false,
        },
        keys = {
          telescope = {
            i = {
              select = "<cr>",
              paste = "<c-m>",
              paste_behind = "<c-M>",
              custom = {},
            },
            n = {
              select = "<cr>",
              paste = "p",
              paste_behind = "P",
              custom = {},
            },
          },
          fzf = {
            select = "default",
            paste = "ctrl-p",
            paste_behind = "ctrl-k",
            custom = {},
          },
        },
      })
    end,
  })
  use("junegunn/vim-easy-align")
  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      require("user.matchup")
    end,
  })
  use({
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("user.numb").config()
    end,
  })
  use({
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      require("user.dial").config()
    end,
  })

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig" })
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
  use({
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          cmd = { vim.fn.stdpath("data") .. "/lsp_servers/rust/rust-analyzer" },
          on_attach = require("user.lsp.handlers").on_attach,
        },
      })
    end,
    ft = { "rust", "rs" },
  })
  use({
    "ray-x/lsp_signature.nvim",
    requires = "nvim-lua/lsp-status.nvim",
    config = function()
      require("lsp_signature").setup({
        -- log_path = vim.fn.expand("$HOME") .. "/tmp/sig.log",
        debug = true,
        hint_enable = false,
        handler_opts = { border = "single" },
        max_width = 80,
      })
    end,
  })

  -- use({
  -- 	"nvim-neorg/neorg",
  -- 	config = function()
  -- 		require("neorg").setup({
  -- 			load = {
  -- 				["core.defaults"] = {}, -- Load all the default modules
  -- 				["core.norg.dirman"] = { -- Manage your directories with Neorg
  -- 					config = {
  -- 						workspaces = {
  -- 							vault = "~/neorg",
  -- 						},
  -- 						autochdir = true, -- Automatically change the directory to the current workspace's root every time
  -- 						index = "index.norg", -- The name of the main (root) .norg file
  -- 						last_workspace = vim.fn.stdpath("cache") .. "/neorg_last_workspace.txt", -- The location to write and read the workspace cache file
  -- 					},
  -- 				},
  -- 				["core.norg.completion"] = {
  -- 					config = {
  -- 						engine = "nvim-cmp",
  -- 					},
  -- 				},
  -- 				["core.norg.concealer"] = {
  -- 					config = {
  -- 						markup = {
  -- 							enabled = false,
  -- 						},
  -- 					},
  -- 				},
  -- 				["core.keybinds"] = { -- Configure core.keybinds
  -- 					config = {
  -- 						default_keybinds = true, -- Generate the default keybinds
  -- 						neorg_leader = "<Leader>o",
  -- 					},
  -- 				},
  -- 				["core.integrations.telescope"] = {},
  -- 				["core.gtd.ui"] = {},
  -- 				["core.gtd.queries"] = {},
  -- 				["core.gtd.base"] = {
  -- 					config = {
  -- 						workspace = "vault",
  -- 						default_lists = {
  -- 							inbox = "inbox.norg",
  -- 						},
  -- 					},
  -- 				},
  -- 				["core.norg.journal"] = {
  -- 					config = {
  -- 						workspace = "vault",
  -- 						strategy = "flat",
  -- 					},
  -- 				},
  -- 				["core.norg.esupports.metagen"] = {
  -- 					config = {
  -- 						type = "auto",
  -- 					},
  -- 				},
  -- 				["core.norg.manoeuvre"] = {},
  -- 			},
  -- 		})
  -- 	end,
  -- 	requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
  -- })
  -- use("renerocksai/calendar-vim")
  use({
    "renerocksai/telekasten.nvim",
    config = function()
      require("user.zettel").config()
    end,
  })
  use({
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup({
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "telescope",
        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },
          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })
    end,
  })

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-packer.nvim")
  -- use({
  -- "nvim-telescope/telescope-frecency.nvim",
  -- requires = { "kkharji/sqlite.lua" },
  -- })
  use({
    "nvim-telescope/telescope-cheat.nvim",
    requires = { "kkharji/sqlite.lua" },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use({
    "nvim-treesitter/playground",
    event = "BufRead",
  })

  use("nvim-treesitter/nvim-treesitter-context")

  use({
    "windwp/nvim-ts-autotag",
    config = function()
      require("user.autotag").config()
    end,
    -- event = "InsertEnter",
  })
  use("harrisoncramer/jump-tag")

  -- Git
  use("lewis6991/gitsigns.nvim")
  use({
    "rmagatti/igs.nvim",
    config = function()
      require("igs").setup({})
    end,
  })
  use({
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_date_format = "%r"
      vim.g.gitblame_message_template = "<summary> • <date> • <author>"
      vim.g.gitblame_highlight_group = "LineNr"
    end,
  })
  use({
    "ruifm/gitlinker.nvim",
    event = "BufRead",
    config = function()
      require("user.gitlinker").config()
    end,
  })
  use({
    "sindrets/diffview.nvim",
    event = "BufRead",
  })
  use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

  use({ "mg979/vim-visual-multi" })
  use({ "wellle/targets.vim", requires = { "wellle/line-targets.vim" } })

  -- testing plugins

  use({
    "https://gitlab.com/yorickpeterse/nvim-window.git",
    -- config = get_config("nvim-window"),
  })

  use({
    "waylonwalker/Telegraph.nvim",
    -- config = function()
    -- 	require("telegraph").setup({})
    -- end,
  })

  use({ "rhysd/conflict-marker.vim" })

  use({
    "edluffy/specs.nvim",
    -- config = get_config("specs")
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
