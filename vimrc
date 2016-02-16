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

call vundle#end()


filetype plugin indent on
syntax on
set number
"highlight Comment ctermfg=DarkCyan
colorscheme elflord

set tabstop=2
set shiftwidth=2

set backspace=2

" Autoopen Tagbar
autocmd VimEnter * nested :call tagbar#autoopen(1)

autocmd FileType * nested :call tagbar#autoopen(0)

autocmd BufEnter * nested :call tagbar#autoopen(0)

" Change function signature color
highlight TagbarSignature ctermfg=Green

" Switch windows with F2 instead of C-W C-Wfe
map <F2> <C-w><C-w>

" tagbar options
let g:tagbar_compact = 1

" begin Syntastic options
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
let g:syntastic_cursor_column = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 1
let g:syntastic_loc_list_height = 0
" end Syntastic options

let g:UtilSnipsExpandTrigger="<tab>"

let g:airline#extensions#tabline#enabled = 1

let g:EclimCompletionMethod = 'omnifunc'

let g:ycm_autoclose_preview_window_after_insertion = 1
