vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd Filetype * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _norg
    autocmd!
    autocmd FileType norg setlocal wrap
    autocmd FileType norg setlocal spell
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap linebreak
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown,telekasten nnoremap <silent> <C-space> :lua require('telekasten').toggle_todo()<CR> 
    autocmd FileType markdown,telekasten nnoremap <silent> <CR> :lua vim.lsp.buf.definition()<CR> 
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    autocmd User AlphaReady nnoremap <silent> <buffer> q :q<CR>
  augroup end

  augroup _fold
    autocmd!
    autocmd! BufReadPost * :if line('$') > 20 | set foldlevel=5 | endif
  augroup end

  augroup _guihua
    autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }
    autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }
  augroup end
]])

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
