""" Welcome to my vim config file! 
""" colors by junegunn. file-specific mappings heavily inspired/taken from
""" Luke Smith.

	let mapleader=" "
	set scrolloff=15
	set wildmenu            
	set showmatch           
	filetype plugin on      
	filetype indent on      
	set history=8026
	set nocompatible
	set tabstop=4
	set laststatus=2        
	set showcmd 
	set cursorline          
	set softtabstop=4
	set relativenumber
	set number
	set autoindent
	set backspace=eol,indent,start
	set linebreak           
	set termguicolors
	set shiftwidth=4
	set hlsearch

" columns being < 80 is best practice
	set colorcolumn=80
	highlight ColorColumn ctermbg=darkgray

" gets rid of redundant mode display
	set noshowmode

" intuitive window splitting
	set splitbelow          
	set splitright

" autocomplete
	set wildmode=longest,list,full
	set wildignore=*.docx,*.jpg,*.png,*.gif,*.pyc,*.exe,*.flv,*.img,*.xlsx
	set wildmenu

" splits new windows at the bottom and right
	set splitbelow splitright

" explicitly setting 256 terminal colors
	set t_Co=256

" Opens NERDTree automatically when I start vim
	" autocmd VimEnter * NERDTree | wincmd p
	
" this will enable code folding.
" use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

call plug#begin('~/.vim/plugged')
	Plug 'junegunn/goyo.vim' " readability
	Plug 'junegunn/seoul256.vim' " pleasant colorscheme
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'preservim/nerdtree' " directory/file viewer
	Plug 'mattn/emmet-vim' " web dev autocomplete/macros
	Plug 'tpope/vim-surround' " bracket, paratheses, etc, autocomplete
    Plug 'itchyny/lightline.vim' " more minimal version of vim-airline-theme
	Plug 'https://github.com/Valloric/YouCompleteMe'
call plug#end()
" }}}

" MAPPINGS ---------------------------------------------------------------- {{{
" unbind annoying keys
	nmap Q <Nop>

" Very useful for not killing my pointer finger.
	inoremap kj  <esc>

" Replace all is aliased to S
	noremap S :%s/foo/bar/g<Left><Left>

" Move to start/end of line from home row
	nmap H ^
	nmap L $

" Goyo plugin gets rid of numbered lines and adds margins
	map <leader>g :Goyo \| set linebreak<CR>

" Toggle nerdtree
	map <leader>n :NERDTreeToggle<CR>

" Spellcheck
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Automatically compiles w/ pdflatex....
	map I :! pdflatex % <CR><CR>

" Shortcutting split window navigation
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l	

" Open file explorer
	map <leader>e :Explore<CR>

" Open my bib file in split
	map <leader>b :vsp<space>~/Desktop/Notes/uni.bib<CR>

" Split screen to right
	map <leader>s :vsp<space>./new.txt<CR>

" Navigating with placeholders
	map <Space><Tab> :keepp /<++><CR>ca<
	imap <Space><Tab> <esc>:keepp /<++><CR>ca<

" up and down is always visual
	map j gj
	map k gk

"""LaTeX bindings
	autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ct \autocite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,li <Enter>\item<Space>
	autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd Filetype tex inoremap ,q \begin{quote}<Enter><Enter>\end{quote}<Enter><Enter><++><Esc>3kf}i

"""BIBER bindings
	autocmd Filetype bib inoremap ,a a

"""HTML bindings
	autocmd FileType html inoremap ,b <b></b><Space><++><Esc>FbT>i
	autocmd FileType html inoremap ,it <em></em><Space><++><Esc>FeT>i
	autocmd FileType html inoremap ,p <p></p><Space><++><Esc>02kf>a

"}}}

" COLOR SCHEME --------------------------------------------------------------- {{{

" set background=dark
" let g:seoul256_background = 234
" colo seoul256

set background=dark
colorscheme PaperColor

if !has('gui_running')
  set t_Co=256
endif

" if has('gui_running')
" 	set background=light
" else
" 	set background=dark
" endif

" for lightline

let g:lightline = {
            \ 'colorscheme': 'PaperColor',
            \ }
" }}}i

" PLUGIN CONFIGS --------------------------------------------------------------- {{{

" }}}
