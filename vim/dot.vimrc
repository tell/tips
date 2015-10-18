" Enable syntax highlighting.
syntax on

" Modeline.
set modeline
set modelines=5

" Use case-insensitive search.
set ignorecase
set smartcase

" Use incremental search.
set incsearch
set hlsearch

" Show mode.
set showmode

set title

" Show ruler.
set ruler

" Display the no. of line.
set number

" Show correspondance of parenthesis.
set showmatch

" Enable auto indentation.
set autoindent

" Settings for expandtab.
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Settings for folding.
set foldmethod=marker
set foldcolumn=3

" Visualize special characters.
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<

" Settings for Tab lines {{{
" Ref: https://github.com/tetsuyainfra/dotfiles/blob/master/vimrc
" Ref: https://github.com/honkimi/myvimrc/blob/master/.vimrc
" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
    let s = ''
    for i in range(1, tabpagenr('$'))
	let bufnrs = tabpagebuflist(i)
	let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
	let no = i  " display 0-origin tabpagenr.
	let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
	let title = fnamemodify(bufname(bufnr), ':t')
	let title = '[' . title . ']'
	let s .= '%'.i.'T'
	let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
	let s .= no . ':' . title
	let s .= mod
	let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" }}}

" Settings for cscope. {{{
if has("cscope")
    set nocsverb
    "" add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    "" else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
    set cscopetag
endif
" }}}

" Settings for GNU GLOBAL. {{{
map <C-g> :Gtags
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>
" }}}
