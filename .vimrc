	let mapleader=" "
	set inccommand=" "
	set wildmenu
	set showmatch
	filetype plugin indent on
	syntax enable
	let g:vimtex_view_method = 'skim'
	let g:vimtex_compiler_method = 'latexmk'
	set conceallevel=2
	let g:tex_conceal="abdgm"
	let g:Tex_IgnoredWarnings = 
		\'Underfull'."\n".
		\'Overfull'."\n".
		\'specifier changed to'."\n".
		\'You have requested'."\n".
		\'Missing number, treated as zero.'."\n".
		\'There were undefined references'."\n".
		\'Citation %.%# undefined'."\n".
		\'I found no'."\n".
		\'Double space found.'."\n"
	let g:Tex_IgnoreLevel = 8
	let g:vimtex_quickfix_open_on_warning = 0

	set history=4000
	set nocompatible
	set tabstop=4
	set laststatus=2
	set showcmd
	set cursorline
	set softtabstop=4
	set number
	set relativenumber
	set autoindent
	set backspace=eol,indent,start
	set linebreak
	set termguicolors
	set shiftwidth=4
	set hlsearch
	set belloff=all

	set colorcolumn=80
	highlight ColorColumn ctermbg=darkgray

" gets rid of redundant mode display
"	set noshowmode

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

" opens NERDTree automatically when I start vim
	" autocmd VimEnter * NERDTree | wincmd p
	
" this will enable code folding.
" use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

let b:ale_linters = {'javascript': ['eslint'], 'sh': ['shellcheck'], 'rust': ['analyzer']}

let g:opamshare = substitute(system('opam var share'),'\n$','','''')
     execute "set rtp+=" . g:opamshare . "/merlin/vim"

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

call plug#begin('~/.config/nvim/plugged')
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'junegunn/goyo.vim' " readability
	Plug 'preservim/nerdtree' " directory/file viewer
	Plug 'mattn/emmet-vim' " web dev autocomplete/macros
	Plug 'tpope/vim-surround' " bracket, paratheses, etc, autocomplete
	Plug 'tpope/vim-fugitive' " git
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " this is for neovim
	Plug 'dense-analysis/ale'
	Plug 'kylechui/nvim-surround'
	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'MrcJkb/haskell-tools.nvim'
	Plug 'lervag/vimtex'
	Plug 'nightsense/seabird'
	Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
	Plug 'rust-lang/rust.vim'
	Plug 'whonore/Coqtail'
call plug#end()

"}}}

" MAPPINGS ---------------------------------------------------------------- {{{
" For coc
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

" unbind annoying keys
	nmap Q <Nop>

	nnoremap <leader>j :setl noai nocin nosi inde=<CR>

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
	map O :! pdflatex % <CR>

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
	autocmd FileType tex inoremap ,ma $$<++><Esc>T$<Esc>hi
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

set t_Co=256
set background=dark
colorscheme PaperColor

" for vim-airline
let g:airline_theme='seagull'

"}}}

" added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
"let s:opam_share_dir = system("opam config var share")
"let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')
"
"let s:opam_configuration = {}
"
"function! OpamConfOcpIndent()
"  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
"endfunction
"let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')
"
"function! OpamConfOcpIndex()
"  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
"endfunction
"let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')
"
"function! OpamConfMerlin()
"  let l:dir = s:opam_share_dir . "/merlin/vim"
"  execute "set rtp+=" . l:dir
"endfunction
"let s:opam_configuration['merlin'] = function('OpamConfMerlin')
"
"let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
"let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
"let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
"for tool in s:opam_packages
"  " Respect package order (merlin should be after ocp-index)
"  if count(s:opam_available_tools, tool) > 0
"    call s:opam_configuration[tool]()
"  endif
"endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
