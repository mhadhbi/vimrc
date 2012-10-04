"
" Author: Ahmed MHADHBI <ahmed@mhadhbi.com>
" Source: http://www.github.com/mhadhbi
"

" Load pathogen {{{
	silent! call pathogen#runtime_append_all_bundles()
" }}}

" Basic configuration {{{
	set nocompatible                " Must come first because it changes other options.
	set modelines=0
	syntax enable                   " Turn on syntax highlighting.
	filetype plugin indent on       " Turn on file type detection.
	runtime macros/matchit.vim      " Load the matchit plugin.
	set hidden                      " hide buffers instead of closing them 
	set t_Co=256										" Explicitly tell vim that the terminal has 256 colors
	set switchbuf=useopen           " reveal already opened files from the
																	" quickfix window instead of opening new
																	" buffers
	set history=1000                " remember more commands and search history
	set undolevels=1000             " use many muchos levels of undo
	if v:version >= 730
			set undofile                " keep a persistent backup file
			set undodir=~/.vim/.undo,~/tmp,/tmp
	endif
	set nobackup                    " do not keep backup files, it's 70's style cluttering
	set noswapfile                  " do not write annoying intermediate swap files,
																	"    who did ever restore from swap files anyway?
	set directory=~/.vim/.tmp,~/tmp,/tmp
																	" store swap files in one of these directories
																	"    (in case swapfile is ever turned on)
	set viminfo='20,\"80            " read/write a .viminfo file, don't store more
																	"    than 80 lines of registers
	set title                       " change the terminal's title
	set visualbell                  " don't beep
	set noerrorbells                " don't beep
	set showcmd                     " show (partial) command in the last line of the screen
																	"    this also shows visual selection info
	set nomodeline                  " disable mode lines (security measure)
	set ttyfast                     " always use a fast terminal
	set cursorline                  " underline the current line, for quick orientation
	" Wild menu {{{
		set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpe?g,*.png,*.xpm,*.gif,.DS_STORE
		set wildmenu									" make tab completion for files/buffers act like bash
		set wildmode=full
	" }}}
" }}}

" Editing behaviour {{{
	set showmode                      " Display the mode you're in.
	set backspace=indent,eol,start    " Intuitive backspacing.
	set autoindent										" always set autoindenting on
	set copyindent										" copy the previous indentation on autoindenting
	set wildmenu                      " Enhanced command line completion.
	set wildmode=list:longest         " Complete files like a shell.
	set showmatch											" set show matching parenthesis
	set ignorecase                    " Case-insensitive searching.
	set smartcase                     " But case-sensitive if expression contains a capital letter.
	set number                        " Show line numbers.
	set ruler                         " Show cursor position.
	set smarttab                      " insert tabs on the start of a line according to
																		" shiftwidth, not tabstop
	set scrolloff=4                   " keep 4 lines off the edges of the screen when scrolling
	set virtualedit=all               " allow the cursor to go in to "invalid" places
	set incsearch                     " Highlight matches as you type.
	set hlsearch                      " Highlight matches.
	set gdefault                      " search/replace "globally" (on a line) by default
	set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
	set nowrap                        " Turn on line wrapping.
	set title                         " Set the terminal's title
	set nowritebackup                 " And again.
	set tabstop=4											" A tab is four spaces 
	set softtabstop=4									" When hitting <BS>, pretend like a tab is removed, even if spaces
	set shiftwidth=2                  " And again, related.
	set expandtab                     " Use spaces instead of tabs
	set shiftround									  " use multiple shiftwidth when indenting with '<' and '>'
	set laststatus=2                  " Show the status line all the time
	" Useful status information at bottom of screen
	" Goodbye :D Welcome Powerline ;)
	"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
" set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
	set nolist                        " don't show invisible characters by default,
																		" but it is enabled for some file types (see later)
	set pastetoggle=<F2>              " when in insert mode, press <F2> to go to
																		" paste mode, where you can paste mass data
																		" that won't be autoindented
	set mouse=a                       " enable using the mouse if terminal emulator
																		" supports it (xterm does)
	set fileformats="unix,dos,mac"
	set formatoptions+=1							" When wrapping paragraphs, don't end lines
																		" with 1-letter words (looks stupid)
" }}}

" Editor layout {{{
	set termencoding=utf-8
	set encoding=utf-8
	set lazyredraw                  " don't update the display while executing macros
	set cmdheight=2                 " use a status bar that is 2 rows high
" }}}

" Folding rules {{{
	set foldenable                  " enable folding
	set foldcolumn=2                " add a fold column
	set foldmethod=marker           " detect triple-{ style fold markers
	set foldlevelstart=0            " start out with everything folded
	set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
																	" which commands trigger auto-unfold
	function! MyFoldText()
			let line = getline(v:foldstart)

			let nucolwidth = &fdc + &number * &numberwidth
			let windowwidth = winwidth(0) - nucolwidth - 3
			let foldedlinecount = v:foldend - v:foldstart

			" expand tabs into spaces
			let onetab = strpart('          ', 0, &tabstop)
			let line = substitute(line, '\t', onetab, 'g')

			let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
			let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
			return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
	endfunction
	set foldtext=MyFoldText()
" }}}

" Shortcut mappings {{{
	let mapleader=","							  " Change the mapleader from \ to ,
	" Quick edit .vimrc {{{
		nnoremap <silent> <Leader>ev :edit   $MYVIMRC<CR>
		nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
	" }}}

	" Buffer mappings {{{
		nnoremap <silent> <Leader>d :bd<CR>
	" }}}

	" Clear search highlighting {{{
		nnoremap <leader><space> :noh<cr>
	" }}}

	" Sudo write {{{
		cmap w!! w !sudo tee % >/dev/null
	" }}}

	" Fix broken vim regexes when searching {{{
		" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines
		nnoremap / /\v
		vnoremap / /\v
		cnoremap s/ s/\v
	" }}}

	" Easier bracket matching {{{
		nnoremap <Tab> %
	" }}}

	" Split window mappings {{{
		nnoremap <leader>w <C-w>v<C-w>l
		nnoremap <C-h> <C-w>h
		nnoremap <C-j> <C-w>j
		nnoremap <C-k> <C-w>k
		nnoremap <C-l> <C-w>l
	" }}}

	" Disable arrow movement keys {{{
		nnoremap <up> <nop>
		nnoremap <down> <nop>
		nnoremap <left> <nop>
		nnoremap <right> <nop>
		inoremap <up> <nop>
		inoremap <down> <nop>
		inoremap <left> <nop>
		inoremap <right> <nop>
	" }}}

	" Tab mappings {{{
		map <leader>tt :tabnew<cr>
		map <leader>te :tabedit
		map <leader>tc :tabclose<cr>
		map <leader>to :tabonly<cr>
		map <leader>tn :tabnext<cr>
		map <leader>tp :tabprevious<cr>
		map <leader>tf :tabfirst<cr>
		map <leader>tl :tablast<cr>
		map <leader>ts :tabs<cr>
		map <leader>td :tabdo
		map <leader>tm :tabmove 
	" }}}

	" Yank/paste to the OS clipboard {{{
		nmap <leader>y "+y
		nmap <leader>Y "+yy
		vmap <leader>y "+y
		vmap <leader>Y "+yy
		nmap <leader>p "+p
		nmap <leader>P "+P
	" }}}

	" Quick alignment of text {{{
		nmap <leader>al :left<cr>
		nmap <leader>ar :right<cr>
		nmap <leader>ac :center<cr>
	" }}}

	" Quickly get out of insert mode {{{
		inoremap jj <esc>
		inoremap jk <esc>
	" }}}
	
	" Delete without adding to the yanked stack {{{
		nmap <silent> <leader>d "_d
		vmap <silent> <leader>d "_d
	" }}}

	" Folding {{{
		nnoremap <space> za
		vnoremap <space> za
	" }}}

	" Strip all trailing whitespace from a file {{{
		nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>
	" }}}

	" Quickly close the current window {{{
		nnoremap <leader>q :q<cr>
	" }}}
	
	" Replace the selected text with the yank register {{{
		vnoremap p <esc>:let current_reg = @"<cr>gvdi<c-r>=current_reg<cr><esc>
	" }}}

	" Creating underline/overline headings for markup languages {{{
	" Inspired by http://sphinx.pocoo.org/rest.html#sections
		nnoremap <leader>1 yyPVr=jyypVr=
		nnoremap <leader>2 yyPVr*jyypVr*
		nnoremap <leader>3 yypVr=
		nnoremap <leader>4 yypVr-
		nnoremap <leader>5 yypVr^
		nnoremap <leader>6 yypVr"
	" }}}

	" pull word under cursor into lhs of a substitute (for quick search and
	" replace)
		nmap <leader>z :%s#\<<c-r>=expand("<cword>")<cr>\>#

	" reselect text that was just pasted with ,v
		nnoremap <leader>v v`]

	" quick yanking to the end of the line
		nmap y y$

	" shortcut to make
		nmap mk :make<cr>
"	}}}

" Common abbreviations / misspellings {{{
	source ~/.vim/autocorrect.vim
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end 
		"}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        autocmd filetype html,htmldjango let b:closetag_html_style=1
        autocmd filetype html,xhtml,xml source ~/.vim/scripts/closetag.vim
    augroup end 
		" }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd filetype python setlocal textwidth=80
        autocmd filetype python match ErrorMsg '\%>80v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>
    augroup end 
		" }}}

    augroup ruby_files "{{{
        au!

        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end 
		" }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end 
		"}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    augroup end 
		"}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end 
		"}}}
endif
" }}}

" Highlighting {{{
    if &t_Co >= 256 || has("gui_running")
		let g:solarized_termtrans=1
		let g:solarized_degrade=1
		colorscheme solarized 
    endif
" }}}

" Restore cursor position upon reopening files {{{
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}

" Plugins settings {{{
	" TagList settings {{{
		nmap <leader>l :TlistClose<CR>:TlistToggle<CR>
		nmap <leader>L :TlistClose<CR>

		" quit Vim when the TagList window is the last open window
		let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
		let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
		let Tlist_WinWidth=40               " set the width
		let Tlist_Inc_Winwidth=1            " increase window by 1 when growing

		" shorten the time it takes to highlight the current tag (default is 4 secs)
		" note that this setting influences Vim's behaviour when saving swap files,
		" but we have already turned off swap files (earlier)
		set updatetime=1000

		" the default ctags in /usr/bin on the Mac is GNU ctags, so change it to the
		" exuberant ctags version in /opt/local/bin
		" For mac user you need to install the exuberant ctags using macports command
		" sudo port install ctags
		let Tlist_Ctags_Cmd = '/opt/local/bin/ctags'

		" show function/method prototypes in the list
		let Tlist_Display_Prototype=1

		" don't show scope info
		let Tlist_Display_Tag_Scope=0

		" show TagList window on the right
		let Tlist_Use_Right_Window=1
	" }}}

	" NERDTree settings {{{
		" Put focus to the NERD Tree with F3 (tricked by quickly closing it and
		" immediately showing it again, since there is no :NERDTreeFocus command)
		nmap <leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
		nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
		nmap <leader>N :NERDTreeClose<CR>

		" Store the bookmarks file
		let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

		" Show the bookmarks table on startup
		let NERDTreeShowBookmarks=1

		" Show hidden files, too
		let NERDTreeShowFiles=1
		let NERDTreeShowHidden=1

		" Quit on opening files from the tree
		let NERDTreeQuitOnOpen=1

		" Highlight the selected entry in the tree
		let NERDTreeHighlightCursorline=1

		" Use a single click to fold/unfold directories and a double click to open
		" files
		let NERDTreeMouseMode=2

		" Don't display these kinds of files
		let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
								\ '\.o$', '\.so$', '\.egg$', '^\.git$' ]
	" }}}

	" Gundo settings {{{
		nnoremap <Leader>g :GundoToggle<CR>
	" }}}
	
	" TaskList settings {{{
		map <leader>T <Plug>TaskList
		" Specifies the position of the window to be opened
		let g:tlWindowPosition = 0
		let g:tlTokenList = ['FIXME', 'TODO', 'XXX', 'HACK']
	" }}}
	
	" Repmo settings {{{
		let g:repmo_key = ";"
		let g:repmo_revkey = "="
	" }}}
	
	" Snipmate settings {{{
		let g:snips_author = 'Ahmed Mhadhbi'
	" }}}
	
	" Buffergator settings {{{
		let g:buffergator_viewport_split_policy = "B"
		let g:buffergator_split_size = 8
	" }}}
	
	" Syntastic settings {{{
		let g:syntastic_enable_signs = 1
		let g:syntastic_auto_loc_list = 0

		" Disable some syntax checkers
		let loaded_javascript_syntax_checker = 1
		let loaded_python_syntax_checker = 1
	" }}}
" }}}


iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor
