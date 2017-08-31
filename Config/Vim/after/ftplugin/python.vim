setlocal softtabstop=4
setlocal colorcolumn=80
highlight ColorColumn ctermbg=0
setlocal shiftwidth=4
vmap Q gq
nmap Q gqap
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
vnoremap < <gv
vnoremap > >gv
