local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- keymap("n", "s", "<Nop>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)


-- Navigate buffers
keymap("n", "L", ":bnext<CR>", opts)
keymap("n", "H", ":bprevious<CR>", opts)

-- Open last buffer
keymap("n", "<space><space>", "<c-^>", opts)

-- Ex-mode is weird and not useful so it seems better to repeat the last macro
keymap("n", "Q", "@@", opts)

-- Lucky Spelling
keymap("n", "zl", "1z=", opts)

-- Repurpose arrow keys for quickfix list movement
keymap("n", "<up>", ":cprevious<cr>", opts)
keymap("n", "<down>", ":cnext<cr>", opts)

-- navigate merge conflict markers
keymap("n", "]n", [[:call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'w')<cr>]], opts)
keymap("n", "[n", [[:call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'bw')<cr>]], opts)

-- Navigate loclist
keymap("n", "]l", ":lnext<cr>", opts)
keymap("n", "[l", ":lprev<cr>", opts)

-- Bookmarks
keymap("n", "ma", "<cmd>BookmarkAnnotate<cr>", opts)
keymap("n", "mc", "<cmd>BookmarkClear<cr>", opts)
keymap("n", "mm", "<cmd>BookmarkToggle<cr>", opts)
keymap("n", "mh", '<cmd>lua require("harpoon.mark").add_file()<cr>', opts)
keymap("n", "mj", "<cmd>BookmarkNext<cr>", opts)
keymap("n", "mk", "<cmd>BookmarkPrev<cr>", opts)
keymap(
	"n",
	"ms",
	'<cmd>lua require("telescope").extensions.vim_bookmarks.all({ hide_filename=false, prompt_title="bookmarks", shorten_path=false })<cr>',
	opts
)
keymap("n", "mx", "<cmd>BookmarkClearAll<cr>", opts)
keymap("n", "mu", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)

-- Jump-tag
keymap("n", "<leader>55", ':lua require("jump-tag").jumpParent()<CR>', opts)
keymap("n", "<leader>5n", ':lua require("jump-tag").jumpNextSibling()<CR>', opts)
keymap("n", "<leader>5p", ':lua require("jump-tag").jumpPrevSibling()<CR>', opts)
keymap("n", "<leader>5c", ':lua require("jump-tag").jumpChild()<CR>', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

keymap("n", "g<", "<cmd>:messages<cr>", opts)


-- ZK --
-- Search for the notes matching the current visual selection.
keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
-- Create a new note in the same directory as the current buffer, using the current selection for title.
keymap("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
keymap(
	"v",
	"<leader>znc",
	":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
	opts
)

-- RANGE FORMAT
keymap("v", "<leader>lf", ":'<,'>lua vim.lsp.buf.range_formatting()<CR>", opts)

--- TEXT OBJECTS
-- Around line: with leading and trailing whitespace
keymap("v", "al", ":<c-u>silent! normal! 0v$<cr>", opts)
keymap("o", "al", ":normal val<cr>", { noremap = false, silent = true })

-- Inner line: without leading or trailing whitespace
keymap("v", "il", ":<c-u>silent! normal! ^vg_<cr>", opts)
keymap("o", "il", ":normal vil<cr>", { noremap = false, silent = true })

-- Whole file, jump back with <c-o>
keymap("v", "ae", "[[:<c-u>silent! normal! m'gg0vg$<cr>]]", opts)
keymap("o", "ae", ":normal Vae<cr>", { noremap = false, silent = true })

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Better window navigation

-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
keymap("n", "<C-j>", "<cmd>NavigateDown<cr>", opts)
keymap("n", "<C-k>", "<cmd>NavigateUp<cr>", opts)
keymap("n", "<C-l>", "<cmd>NavigateRight<cr>", opts)

