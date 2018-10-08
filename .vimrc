"## ===================================================================== ##
"#  | -------------------------------------------------------------------
"#  | >> Maintainer: KcTeaC
"#  | >> Revised Last: 2018, October 7
"#  | >> ---------------------------------------------------------------- ##
"## ===================================================================== ##

" enable the many benefits of filetype detection
filetype plugin indent on

function! ToggleSyntax()
	if exists('g:syntax_on')
		syntax off
	else
		syntax enable
	endif
endfunction
nnoremap <silent> ts :call ToggleSyntax()<cr>

function! ToggleNumber()
	if &number
		exe 'set nonumber'
	else
		exe 'set number'
	endif
endfunction
nnoremap <silent> tn :call ToggleNumber()<cr>

set backspace=indent,eol,start	" make backspace function properly
set history=50			" keep 50 lines of command history
set hidden			" do not automatically unload inactive buffers
set splitright			" vnew opens to the right
set wildmenu			" press tab in command mode for a completion menu
set wildmode=list:longest
set nobackup
set nowritebackup
set noswapfile

"assign a mapleader
let g:mapleader=";"

if has('persistent_undo')
	set undodir=$HOME/.vim/.undofile
	set undofile
	if !isdirectory(&undodir)
		call mkdir(&undodir, 'p')
	endif
endif

set statusline=[%F[%Y]%r%m%h]:[%L] 	" path, type, flags, and total lines
set statusline+=\ -\			" separator
set statusline+=Paste:			" paste mode indicator label
set statusline+=[%{HasPaste()}]         " paste mode indicator
set statusline+=%=
set statusline+=\ -\			" separator
set statusline+=Current:                " label
set statusline+=[%l[%c]]
set statusline+=

function! HasPaste()
	if &paste
		return 'PASTE'
	else
		return ''
	endif
endfunction

function! StripWhitespace()
	if &ft != "diff"
		let b:curcol = col(".")
		let b:curline = line(".")
		silent! %s/\s\+$//
		silent! %s/\(\s*\n\)\+\%$//
		call cursor(b:curline, b:curcol)
	endif
endfunction
nnoremap <silent> <F12> :call StripWhitespace()<cr>
augroup whitespace
	au!
	autocmd bufwritepre *.hs,*.py,*.sh :call StripWhitespace()
augroup END

augroup formatting
	au!
	autocmd bufnewfile,bufread *
				\ set expandtab	| " turn tabs into spaces
				\ set tabstop=2	| " two spaces per tab
				\ set softtabstop=2 | " two spaces per tab key press in insert mode
				\ set shiftwidth=2 |
				\ set autoindent | " copy indentation from one line to the next
                                \ set formatoptions-=t  |
				\ set formatoptions+=02l1 |
				\ set listchars=tab:>
augroup END

" easier vimrc edits and reloads
nnoremap <leader>ev :vsp ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
augroup vimrc
	au!
	autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

augroup pastE
	au!
	autocmd insertleave * :set nopaste
augroup END

if !has('gui_running')
	set ttimeoutlen=10
	augroup fastescape
		au!
		autocmd insertenter * :set timeoutlen=0
		autocmd insertleave * :set timeoutlen=250
	augroup END
endif

function! Highlight_cursor()
	set cursorline
	redraw
	sleep 10
	set nocursorline
endfunction
augroup cursor_properties
	au!
	autocmd focusgained * :call Highlight_cursor
	autocmd bufreadpost * if &ft != 'gitcommit' && line("'\"") > 0 |
				\ if line("'\"") <= line("$") |
				\  exe("norm '\"") |
				\ else |
				\ exe "norm $" |
				\ endif |
				\ endif
augroup END

" remap <esc> to jk
"inoremap <esc> <nop>

" quick save
nnoremap <leader>w :w!<cr>

" Split switch and resize
nnoremap <C-j> <C-W>j<C-W>_
nnoremap <C-k> <C-W>k<C-W>_
nnoremap <C-l> <C-W>l<C-W><bar>
nnoremap <C-h> <C-W>h<C-W><bar>
set wmw=0
set wmh=0

" go to beginning/end of line
nnoremap B ^
nnoremap E $

" yank from cursor to end of line
nnoremap Y y$

" join lines and restore cursor location
nnoremap J  mjJ' j
" movew better around long, wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" delete entire line
nnoremap - dd

" select a word
nnoremap <space> viw

" Get filetime
function! GetFileTime()
	let file = expand("%")
	if "" == file
		return ""
	endif
	let lastmodify = getftime(file)
	let str = strftime('%Y/%m/%d %H:%M:%S', lastmodify)
	let Y = strftime('%Y', lastmodify)
	let m = strftime('%m', lastmodify)
	let d = strftime('%d', lastmodify)
	let H = strftime('%H', lastmodify)
	let M = strftime('%M', lastmodify)
	let S = strftime('%S', lastmodify)

	echomsg str
	return str
endfunction
"command -nargs=0 LastModify :call GetFiletime()

" disable arrow keys
"inoremap <Down> <nop>
"inoremap <Up> <nop>
"inoremap <Right> <nop>
"inoremap <Left> <nop>

nnoremap <Down> <nop>
nnoremap <Up> <nop>
nnoremap <Right> <nop>
nnoremap <Left> <nop>

" easier brackets
nnoremap $" viw<esc>a"<esc>bi"<esc>lel
nnoremap $' viw<esc>a'<esc>bi'<esc>lel
nnoremap $[ viw<esc>a]<esc>bi[<esc>lel
nnoremap $$ viw<esc>a]]<esc>bi[[<esc>lel
nnoremap ${ viw<esc>a}<esc>bi{<esc>lel
nnoremap $( viw<esc>a)<esc>bi(<esc>lel

" Haskell
augroup HSK
        au!
        autocmd bufenter *.hs compiler ghc
        autocmd filetype haskell setlocal formatoptions+=t
augroup END

