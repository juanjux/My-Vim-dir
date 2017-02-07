" Plugins used:
" Vundle: plugin manager. To install it:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" git submodule update?
" CtrlP: fuzzy matching on buffers/files/mru
" Jedivim: Python's autocompletion, renaming and symbol jumping (better than ROPE)
" PythonMode: Adds Python motion objects, run code, better syntax highlighting,
"             breakpoints, better indentation, etc. Syntax checking and code
"             completion / refactoring is disabled because I prefer Syntastic + JediVim
"             for that.
" Yankring: register buffer, also allows to copy and paste between different vim instances
" using an external file. ",yy" for seeing the ring, control-p after pasting
" to cycle between previous yanks
" Project: project manager, (,P to open, \C to create new, \R to refresh) (CURRENTLY REMOVED)
" Fugitive: Awesome git support
" Pythoncomplete: better Python completion, needs a Vim with Python support
" Tohtml: converts the buffer to HTML with syntax coloring (:tohtml)
" ZipPlugin: to open zip files
" NERD_commenter: ',c<space>' to toggle comment code
" Gzip: open gzip files
" Matchparen: show the matching parenthesis/bracket/etc
" CSApprox: use GVim colors schemes in console Vim if the console allows for more than 256 colors
" Airline: Cool status bar (need laststatus set to 2)
" Tagbar: tag lists (method, var, classes, etc), ',tb' to toggle
" Syntastic: validates the code on writing (disabled for D, use ',sy' there) and shows the errors
" Easy Motion: jump quickly to any word in the window, ',e' to activate
" Matchit: improves on the Vim % command to understand more things
" Matchtagalways: highlight matching HTML tags (disabled, problems with python3)
" Tabular: align things, ':Tabularize /:' would align by the ':' character, useful to prettify code
" Emmet: quickly write HTML, using '<c-y>,' in insert mode can expand things like
" 'div.bla+div#pok.bla2>ul>li*3>span>a' (see cheatsheet below)
" YouCompleteMe: real time completion, needs Python and Vimproc, doesn't work on Windows
" VimColorschemes: lots of colorschemes
" Surround:
"   ys[object][delim] to add delimiter, like ysiw" for " around inner word
"   S[delim] add delimiter around visual selection
"   yss
"   cs[old][new] change delimiters surrounding: cs'" => ' to ", cs"t => " to html tag
"   ds[delim]: to remove " delimiters
" Jdaddy: json objects (aj), prettyfication (gqaj), pretty pasting (gwaj)
" Gtfo: "gof" for opening a file manager on the buffer's directory, "got" for a
"   terminal
" Repeat: so I can repeat with the "." actions from some plugins like Surround
" EasyOperator: [operator](easymotionselection) => awesome to delete and move things around
" Rename: :rename command to rename current file
" Ag: search with silversearcher
" Better Rainbow Parenthesis: colorized parenthesis
" QuickRun: execute code of several languages in the buffer, range, selection... (:QuickRun)
" VimStartify: Show an useful start screen with recent files, dirs, sessions and
" VimColorSchemeSwitcher: :NextColorScheme, :PrevColorScheme, :RandomColorScheme
" Vinegar: improved the netrw file explorer using a project manager like split:
" - to go to the directory of the current buffer
" I to show the help, gh to toggle dot file hiding
" . (dot)  on a file to write its path at the : command line (for :Ag, !chmod, etc)
" cg to to :cd to the currently edited buffer directory
" ~ to go thome

set nocompatible

" ========================================================
" === VUNDLE PLUGINS CONFIGURATION =======================
" ========================================================
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'klen/python-mode'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'Valloric/MatchTagAlways'
Plugin 'danro/rename.vim'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/rainbow_parentheses.vim'
Plugin 'majutsushi/tagbar'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'tmhedberg/matchit'
Plugin 'vim-scripts/CSApprox'
Plugin 'vim-scripts/reorder-tabs'
Plugin 'vim-airline/vim-airline'
Plugin 'flazz/vim-colorschemes'
Plugin 'easymotion/vim-easymotion'
if !(has("win64") || has("win32"))
    " Doesnt work well for me on Windows
    Plugin 'takac/vim-fontmanager'
endif
Plugin 'justinmk/vim-gtfo'
Plugin 'Shougo/vimproc.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'thinca/vim-quickrun'
Plugin 'mhinz/vim-startify'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-colorscheme-switcher'
Plugin 'tpope/vim-vinegar'
Plugin 'fatih/vim-go'

call vundle#end()

" ========================================================
" === BASIC CONFIGURATION  ===============================
" ========================================================

behave xterm
syntax on
filetype plugin indent on
set novb                       " no bells please
set noerrorbells               " idem
"set list lcs=tab:��,eol:�      " show invisible characters line newline or tabs
set switchbuf=usetab,newtab    " switch to a buffer opened on a tab switches to that tab
set history=50
set viminfo='50,\"50
set modeline                   " enable per-file modelines
set modelines=5
set undofile
set undolevels=1000
set undoreload=10000
set backspace=start,indent,eol
set encoding=utf-8
set scrolloff=5                " minimal number of lines above or below the cursor
set showcmd
set ruler
set hidden                     " allow to change buffers even if current is unsaved
set showmode
set showtabline=1
set guitablabel=\[%N\]\ %t     " Nice format for the tabs, with number and filename
set wildmenu
set nobackup
set nowritebackup
set noswapfile
set ignorecase
set smartcase           " Case insensitive search with lowercase terms, sensitive with uppercase
set hlsearch            " highlight search results
set showmatch
set gdefault            " default to global substitution, without having to put the /g at the end
set t_Co=256            " more colors
set relativenumber      " show relative line numbers
set number              " but show the current linenum at the center
set virtualedit=block   " can select anything inside visual block mode (v + ctrl-v)
set laststatus=2        " needed for powerline/airline
"set cursorline          " highlight the line with the cursor
set autochdir           " change the cwd to the buffer
set undodir="$VIMRUNTIME\\undodir"
set wildignore+=.git\*,.hg\*,.svn\*,.bzr\*
set mouse+=a

" when opening a buffer, jump to the last known position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif

" automatically strip trailing whitespace
fun! <SID>StripTrailingWhitespaces()
   let l = line(".")
   let c = col(".")
   %s/\s\+$//e
   call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,go,nim,d,java autocmd BufWritePre <buffer> 
            \ :call <SID>StripTrailingWhitespaces()

 " Dont go back 1 character when leaving insert mode
 au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

" Use CTRL-S for saving, also in Insert mode
noremap  <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" =========================================================
" === TABS, INDENTATION AND FORMATTING ====================
" =========================================================

" default line length, can be changed depending on the filemode
let my_linelen = 82
set colorcolumn=110   " color text written past the column

" 4 space tabs, anything else is wrong
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

set nowrap
set wh=12

" justify comments inside code; start the next line after a comment as a comment
set formatoptions=qrn
set copyindent        " copy the indentation of the previous line
set foldmethod=indent " fold by indentation (except for python, see below)
set foldnestmax=2     " ...but not more than two levels (class and method)
set foldlevel=99      " start with everything unfolded

function! SetLineLengthOptions(len)
    let &l:tw = a:len
    let &l:colorcolumn = a:len
endfunction

au BufNewFile,BufRead,BufEnter *.md,*.markdown,*.txt,*.me,*.ME,.article*,.followup,.letter*,mutt*
            \ call SetLineLengthOptions(82)
au BufNewFile,BufRead,BufEnter .vimrc,_vimrc,*.d,*.cpp,*.cc,*.py,*.js,*.go,*.nim,*.js,*.java
            \ call SetLineLengthOptions(110)

autocmd FileType html set formatoptions+=l

" Rename tabs to show tab number (change with [number]gt)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    highlight link TabNum Special
endif

" Format for the folded folds line
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    "return line . '-' . repeat(" ",fillcharcount) . foldedlinecount . '-' . ' '
    return line . '   |' . foldedlinecount . ' lines|'
endfunction " }}}
set foldtext=MyFoldText()

" =========================================================
" === SHORTCUTS ===========================================
" =========================================================

" Important: uncoment any set encoding line before adding new non-ASCII chars
" to vimrc, enable them after

" Vim Reminders:
" <c-o> and <c-i> jump between the history of cursor positions
" <c-o> run a single command while in insert mode
" '. jump to last insert position
" gi jump to last insert location and enter insert mode
" "* register clipboard (Windows)
" "+ register clipboard (Linux)
" "% register with buffer name (only for pasting)
" :goto n: go to the byte in the buffer
" gp paste and move the cursor to the end
" :pu or ,p paste below the current line
" P paste before the cursor
" f / F search for next / prev char in line
" t / T search for next / prev char in line, jump before it
" w start of next word (W for WORD)
" e end of next word (E for WORD)
" b start of prev word (B for WORD)
" d/[search] delete until [search] not including the search terms
" y/[search] yank until [search] not including the search terms
" */# search for next/prev occurrence of word under cursor
" 0/^/$ motions: start of line, start of text, end of line
" gg / G: motions: start of text, end of text
" I move to start of text and enter insert mode
" A move to end of line and enter insert mode (append)
" C change since cursor to the end of line
" cc change entire line
" o/O create new line below / above current
" z= see spelling suggestions for word under cursor
" ]s / [s jump to next / prev misspelled word
" zg add word to spellfile
" gn "select next search match", e.g. cgn deletes and insert on the next search match

" === BASIC ===
let mapleader = ","
" When I use a Spanish keyboard I still want to use these keys
" without pressing shift
"map - /
"nmap � :
"nmap � :
"imap � <esc>
"nmap � ^
"nmap � `

" map Tab/ShiftTab to next/prev tab
nmap <Tab>   gt
nmap <S-Tab> gT

",o / ,O to insert a line below / above and return to normal mode
nmap <leader>o o<esc>
nmap <leader>O O<esc>

" navigate trought wrapped lines easily
nmap j gj
nmap k gk

" w!! to save as root with sudo
cmap w!! w !sudo tee % >/dev/null<cr>

" ==============
" TAGS
" ==============
nmap <leader>tg :set tags=tags<cr>
",ta jump to tag (also the default C-])
nnoremap <leader>ta <C-]>
",cdt (Create D Tags) regenerate tags for a D project, it needs:
"https://github.com/snosov1/ctags-d y modificar tagbar.d with:
"http://blog.adamdklein.com/?p=28 (see Marenz's comment)
nmap <leader>cdt :!ctags -R ~/webmail/backend/source > tags<cr>:set tags=tags<cr>


" TABS AND WINDOWS =====

" ,v (vsplit)
nmap <leader>v :vspl<cr><c-w><c-w>
" ,cv (close other vertical split)
nmap <leader>cv <c-w><c-w>:q<cr>

" ,tn (Tab New)
nmap <leader>tn :tabnew<cr>

" c-h/c-l change to previous/next tab
nmap <c-h> :tabp<cr>
nmap <c-l> :tabn<cr>

" ,bt (buffer tabs) open all buffers as tabs
nnoremap <leader>bt :tab sball<cr>

",tl moves the tab one position to the left
nnoremap <leader>tl :tabm -1<cr>

",tr moves the tab one position to the right
nnoremap <leader>tr :tabm +1<cr>

" COPY/PASTE =====
" Obvious shortcuts so I don't mess with C-V, C-C when using Vim along other
" programs that use these shortcuts for copy/paste (these copy/paste to the
" system clipboard). Taken from mswin.vim.

vnoremap <C-X> "+x
vnoremap <C-C> "+y
map      <C-V> "+gP

" make paste also work in the command line
cmap <C-V> <C-R>+
exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" CTRL-A is Select all
noremap  <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" Use CTRL-Q to do what CTRL-V used to do (block visual mode, escape chars in the command line, etc)
noremap <C-Q> <C-V>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" ,p paste AFTER current line, useful when you're pasting several lines
nnoremap <leader>p :pu<cr>

" ,V will select the last pasted text
nnoremap <leader>V `[v`]

" The unnamed buffer (when you yank or cut without naming a register) is the clipboard
set clipboard=unnamed

" OTHER SHORTCUTS =====

" ,ct Clear Trailing : remove trailing whitespace after the end of line
nnoremap <leader>ct :%s/\s\+$//<cr>

" space and backspace pagedown/up
nnoremap <space> <c-f>
nnoremap <bs> <c-b>

" ,sv reload .vimrc
nmap <leader>sv :so $MYVIMRC<cr>

" ,rr: sometimes syntax highlighting fails and put everything as string, this reset it
nmap <leader>rr :syntax sync fromstart<cr>:redraw!<cr>

" Spellchecking:
" ,ss Spanish
" ,se English
" ,sn Disable
" z= to see suggestions
" ]s / [s jump to next/prev misspelled word
" zg add word to the spellfile
nmap <leader>ss :setlocal spell spelllang=es_es<cr>
nmap <leader>se :setlocal spell spelllang=en_en<cr>
nmap <leader>sn :set nospell<cr>

" some aliases for my stupid fingers
nmap :W :w
nmap :q1 :q!
nmap :Q :q
nmap :Q! :q!
nmap :Q1 :q!
nmap :Qa :qa
nmap :QA :qa

" ,<space> to clean search results
nmap <leader><space> :noh<cr>

" ,yy show yanking registers
nnoremap <leader>yy :YRShow<cr>

" F1 = exit insert mode and save
inoremap <f1> <ESC>:update<cr>
nnoremap <f1> :update<cr>
vnoremap <f1> :update<cr>
inoremap <f2> <ESC>:bd!<cr>
nnoremap <f2> :bd!<cr>
vnoremap <f2> :bd!<cr>
inoremap <f3> <ESC>:QuickRun<cr>
nnoremap <f3> :QuickRun<cr>
vnoremap <f3> :QuickRun<cr>

" Netrw, Tagbar and Project toggles
nmap <leader>E :Vex<cr>
nmap <leader>tb :TagbarToggle<cr>
nmap <silent> <leader>P <Plug>ToggleProject

" ,gs (Guarda Sesion) save vim session, ,css (Carga Sesion), load it
nmap <leader>gs :mksession! ~\.vim\session\default<cr>
nmap <leader>css :source ~\.vim\session\default<cr>

" ,sp, ,snp set paste, set no paste modes
nmap <leader>sp :set paste<cr>
nmap <leader>np :set nopaste<cr>

" Manual SyntasticCheck for the languages where I've the check-on-write disabled (like D)
nmap <leader>sy :SyntasticCheck<cr>

" ,1 Put === lines above and below the current line (lame, I know)
nnoremap <leader>1 yyPVr=jyypVr=k

" C-B CtrlPBuffers
nmap <C-b> :CtrlPBuffer<cr>

" F5 open a Markdown preview in Chrome. Needs the "Markdown preview" addon for Chrome
autocmd BufEnter *.md exe 'noremap <F5> :!/usr/bin/env google-chrome %:p<CR>'

" <leader>cp copy the current path to the system clipboard
nmap <leader>cp :let @+ = expand("%:p:h")<cr>:echo @+<cr>

" Replace the timestamp under cursor for a date. Must be a "word" so separate
" using spaces or other word delimiters before calling it
nmap <leader>ts <esc>"mciw<c-r>=strftime("%d/%m/%y %H:%M:%S", @m)

" =========================================================
" COLORS, FONTS AND GUI
" =========================================================
" light background
set background=light
" colors summerfruit256    " white, high contrast
"colors professional " yellow-white, high contrast
"colors ironman            " light gray, medium contrast
"colors PapayaWhip   " yellow-orange, high contrast
colors PaperColor

" dark background
"set background=dark
"colors jelleybeans       " black background, medium contrast
"colors obsidian2         " dark green, low contrast
"colors obsidian         " dark grey, medium contrast
"colors northsky          " dark blue, medium contrast
"colors leo               " black background, medium to high contrast
"colors molokai           " dark, high contrast
"colorss iceberg           " very dark blue, low contrast

hi NonText guifg=#b2b2b2

" EasyMotion Colors
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First ErrorMsg
hi link EasyMotionTarget2Second Define

" Font
" On gvim we can use :set guifont=* to show a font picker window
" TIP for changing the font in the .vimrc: to get the guifont value copied to the current
" buffer as text do :put =&guifont
let g:fontman_font = "DejaVu Sans Mono"
let g:fontman_size = 9

" GVIM options ====

" Negated:
" !a: dont autocopy VISUAL regions to the clipboard
set guioptions-=a
" !T: dont show the toolbar
set guioptions-=T
" !i: dont use an icon
set guioptions-=i
" !e: dont use graphic tabs (they look nicer with text tabs can be reordered by dragging with the plugin)
"set guioptions-=e
" !m: dont show menu bar
set guioptions-=m
" !h: dont use the cursorline as size reference for the horizontal scrollbar
set guioptions-=h

" Enabled:
" g: show inactive menu items greyed
set guioptions+=g
" r: show graphic scrollbar
set guioptions+=r
" b: show horizontal scrollbar
set guioptions+=b

" Only show the horizontall scrollbar when its actually needed:
" MaxWidth() - Return length of longest line in current buffer
function! <SID>MaxWidth()
  return max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
endfunction

" TextWidth() - Return width of actual text area in current window
function! <SID>TextWidth()
  return winwidth(0) - &l:foldcolumn -
    \ ((&l:number || &l:relativenumber) ? &numberwidth : 0)
endfunction

" ToggleBottomScrollbar() - Toggle horizontal scrollbar on/off as required
function! <SID>ToggleBottomScrollbar()
  if !&l:wrap && <SID>MaxWidth() > <SID>TextWidth()
    if &l:guioptions !~# "b"
      setlocal guioptions+=b
    endif
  elseif &l:guioptions =~# "b"
    setlocal guioptions-=b
  endif
endfunction

augroup autoscrollbar
  au!
  au CursorHold * :call <SID>ToggleBottomScrollbar()
  au CursorHoldI * :call <SID>ToggleBottomScrollbar()
  au VimResized * :call <SID>ToggleBottomScrollbar()
augroup END

" =========================================================
" AUTOCOMPLETE
" =========================================================

" By language
au BufNewFile,BufRead,BufEnter *.d  setf d
autocmd filetype python set omnifunc=pythoncomplete#Complete
autocmd filetype javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd filetype html set omnifunc=htmlcomplete#CompleteTags
autocmd filetype css set omnifunc=csscomplete#CompleteCSS
autocmd filetype d set omnifunc=dcomplete#Complete

" show omni menu even when there is only a single entry and don't autocomplete with the first one
set completeopt=longest,menuone

" not infernal-pink color for the complete menu
highlight Pmenu guibg=brown gui=bold


" =============================================
" PLUGIN's OPTIONS AND CHEAT SHEETS
" =============================================

" Jedi Vim (for Python): ====

" <leader>d: go to definition
" <leader>re: rename
" <leader>u: list symbol usages
" Control-Space: complete symbol
" Writing a '.' will also trigger completion
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>go"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>re"

" Don't complete function parameters, it's annoying
autocmd FileType python setlocal completeopt-=preview

" Tagbar: =====
" right side frame (left one is used for Project)
let Tlist_Use_Right_Window = 1

" minimum tag frame size
let Tlist_WinWidth = 40

" get focus when opening
let Tlist_GainFocus_On_ToggleOpen = 1

let g:tagbar_type_d = {
    \ 'ctagstype': 'D',
    \ 'kinds'    : [
        \ 'o:objects',
        \ 'f:functions',
        \ 'a:arrays',
        \ 's:strings'
    \ ]
\ }

" Project: =====
" default flags
let g:proj_flags="imstvcg"
" wait a little longer for commands
set timeout timeoutlen=5000 ttimeoutlen=100

" Yankring: use c-j and c-k to paste prev/next from the ring =====
" default file
let g:yankring_history_dir="$VIMRUNTIME"
let g:yankring_replace_n_pkey = '<c-j>'
let g:yankring_replace_n_nkey = '<c-k>'

" Emmet: =====
" <c-y>, to expand abbreviations like div#page>div.logo+ul#navigation>li*5>a
" <c-y>n jump to next editable point
" <c-y>N jump to previous editable point
" <c-y>k remove current tag
" <c-y>/ comment tag
" <c-y>a convert URL to <a> tag (needs correct URL with http://)
" <c-y>A convert URL to quote with the page title and description
" <c-y>c convert code to prettified code with css classes by type
" <c-y>, with some selection to wrap inside tags (it will ask for the tag)
" <c-y>d select the tag surrounding the cursor position, hit multiple times to expand
" <c-y>D select the next inside tag or the next tag if there is none inside the current one
" <c-y>i update image size, it loads urls or files and check the real size
" <c-y>j join/separate block => <div></div> => <div/>
" <c-y>, if you write 'lorem' it will expand to a lorem ipsum


" Syntastic:  ====
" :Error to show the error listing windows
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 0
let g:syntastic_debug = 0
let g:syntastic_error_symbol             = 'E>'
let g:syntastic_warning_symbol           = 'W>'
let g:syntastic_d_check_header           = 0
let g:syntastic_d_compiler               = "$HOME/bin/dub-syntastic"
let g:syntastic_python_checkers          = ['flake8']
let g:syntastic_mode_map                 = { 'mode': 'active', 'passive_filetypes': ['d'] }
let g:syntastic_python_flake8_post_args  = '--ignore=E501,E221,E265,E303,E302,E701,E251,E241,'
let g:syntastic_python_flake8_post_args .= 'E128,E401,E301,E126,E225,E211,E226,E261,E127,E702,'
let g:syntastic_python_flake8_post_args .= 'E123,E124,E129,E201,E231,E262,E202,E203,E125,E228,'
let g:syntastic_python_flake8_post_args .= 'E272,E131,E402,E114,E116,E266'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 0
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0

" PythonMode: =====
" Motions
" [[ / ]] previous / next class or function
" [M / ]M previous / next class or method
" aC / iC Python class objects
" aM / iM Python function of method objects
" Functions
" <leader>ru run buffer or selection
" <leader>br set breakpoint
"
let g:pymode_python = 'python'
let g:pymode                  = 1
let g:pymode_syntax           = 0
let g:pymode_syntax_all       = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_max_line_length  = 119
let g:pymode_indent           = 1
let g:pymode_folding          = 0
let g:pymode_run_bind         = '<leader>ru'
" These things are better done by jedi-vim or Syntastic
let g:pymode_rope            = 0
let g:pymode_rope_completion = 0
let g:pymode_doc             = 0
" Better done by Syntastic
let g:pymode_lint            = 0


" EasyMotion: ====
nmap <leader>e  <Plug>(easymotion-bd-w)
nmap d<leader>e <Plug>(easyoperator-line-delete)
nmap y<leader>e <Plug>(easyoperator-line-yank)
nmap v<leader>e <Plug>(easyoperator-line-select)
" ,f easy motion search character
nmap <leader>f  <Plug>(easymotion-bd-f)
" ,j easy motion line
nmap <leader>j  <Plug>(easymotion-bd-jk)

" CtrlP: ====
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_match_window = 'top, order:ttb,min:1,max:20,results:20'
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_lazy_update = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_show_hidden = 0

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_custom_ignore = {
  "\ 'dir':  '\v[\/]\.(git|hg|svn)$',
  "\ 'file': '\v\.(exe|so|dll)$',
  "\ 'link': 'some_bad_symbolic_links',
  "\ }

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore ''.git'' -g "">>'

" PyMatcher for CtrlP:  =====
if has('python')
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" Rainbox Parenthesis: ====
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
call g:rainbow_parentheses#activate()

" Indent Guides:  ====
"let g:indent_guides_enable_on_vim_startup = 1

" Vim Markdown: ====
let vim_markdown_preview_toggle=2
