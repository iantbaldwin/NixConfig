set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/a.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rdnetto/YCM-Generator'

call vundle#end()


filetype plugin indent on

" Make VIM look pretty
syntax on
set number
set background=dark
colo solarized
set tabstop=2
set shiftwidth=2
set backspace=2

" begin tagbar options
let g:tagbar_compact = 1
" Change function signature color
highlight TagbarSignature ctermfg=DarkGreen
" Autoopen Tagbar
autocmd VimEnter * nested :call tagbar#autoopen(1)
autocmd FileType * nested :call tagbar#autoopen(0)
autocmd BufEnter * nested :call tagbar#autoopen(0)
" end tagbar options

" Switch windows with F2 instead of C-W C-W
map <F2> <C-w><C-w>

" begin Syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_cursor_column = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 1
let g:syntastic_loc_list_height = 0
" end Syntastic options

" begin vim-airline options
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
" end vim-airline options

" begin YCM options
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" end YCM options


