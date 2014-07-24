" Plugins used:
" Pathogen: easy plugin installation/removal, just do a git clone on ~/.vim/bundle
" Yankring: register buffer, also allows to copy and paste between different vim instances
" using an external file. ",yy" for seeing the ring, control-p after pasting
" to cycle between previous yanks
" Project: project manager, (,p to open, \C to create new, \R to refresh)
" Pythoncomplete: better Python completion, needs a Vim with Python support
" Tohtml: converts the buffer to HTML with syntax coloring (:tohtml)
" ZipPlugin: to open zip files
" NERD_commenter: ',c<space>' to toggle comment code
" Gzip: open gzip files
" Matchparen: show the matching parenthesis/bracket/etc
" CSApprox: use GVim colors schemes in console Vim if the console allows for more than 256 colors
" Airline: Cool status bar (need laststatus set to 2)
" Tagbar: tag lists (method, var, classes, etc), ',tb' to toggle
" Vimwiki: personal wiki (see cheatsheet inside)
" Vimmultiplecursors: select the same work several times with ctrl-n, v to edit, great for
" renaming vars
" Syntastic: validates the code on writing (disabled for D, use ',sy' there) and shows the errors
" Easy Motion: jump quickly to any word in the window, ',e' to activate
" Unite: fuzzy search on buffers/files/tags/recent files/etc, <space><space> (needs vimproc)
" Matchit: improves on the Vim % command to understand more things
" Matchtagalways: highlight matching HTML tags
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
" Gtfo: gof for opening a file manager on the buffer's directory, got for a
"   terminal
" Ack: Ack [search] [directory]
" Repeat: so I can repeat with the "." actions from some plugins like Surround
" EasyOperator: [operator](easymotionselection) => awesome to delete and move things around
" LustnoMail = "Error: could not get raw email";er: <leader>lj and a number to quickly switch buffers
" Rename: :rename command to rename current file
" ========================================================
" === BASIC CONFIGURATION  ===============================
" ========================================================
" PaThogen
execute pathogen#infect()

set nocompatible
behave xterm
syntax on
filetype plugin on
set novb                       " no bells please
set noerrorbells               " idem
"set list  lcs=tab:»·,eol:¬     " show invisible characters line newline or tabs
set switchbuf=usetab,newtab    " switch to a buffer opened on a tab switches to that tab
filetype plugin indent on
set history=50
set viminfo='50,\"50
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
set guitablabel=\[%N\]\ %t
set wildmenu
set nobackup
set nowritebackup
set noswapfile
set ignorecase
set smartcase
set hlsearch                   " highlight search results
set showmatch
set gdefault                   " default to global substitution, without having to put the /g at the end
set t_Co=256                   " more colors
set relativenumber             " show relative line numbers
set number                     " but show the current linenum at the center
set virtualedit=block          " can select anything inside visual block mode (v + ctrl-v)
set laststatus=2               " needed for powerline/airline
set cursorline                 " highlight the line with the cursor
set autochdir                  " change the cwd to the buffer 

" no mouse without GUI (so I can copy easier when running inside putty)
if has("gui")
    set mouse=a
else
    set mouse=
endif

" when opening a buffer, jump to the last known position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif

" settings by OS
if has("win64") || has("win32")
    set undodir="C:\\installs\\vim\\undodir"
    let $PYTHONPATH="C:\\python27\\lib"
    set wildignore+=.git\*,.hg\*,.svn\*,.bzr\*
else
    set undodir="$VIMRUNTIME\\undodir"
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.bzr/*
endif


" =========================================================
" === TABS, INDENTATION AND FORMATTING ====================
" =========================================================


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
set foldmethod=indent " fold by indentation
set foldnestmax=2     " ...but not more than two levels (class and method)
set foldlevel=99      " start with everything unfolded
set colorcolumn=94     " color text written past the column
"autocmd FileType python,html,javascript,css,c,d,cpp,java,xhtml,htmldjango,ruby,lua,make,markdown,mel,perl,perl6,php,samba,xml set foldlevel=0
" 82 chars indentation for text files
au BufNewFile,BufRead,BufEnter *.txt,*.me,*.ME,.article*,.followup,.letter*,mutt*  set tw=82
au BufNewFile,BufRead,BufEnter *.d,*.cpp,*.cc,*.py,*.js set tw=90
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
" gn "next search match", e.g. cgn deletes and insert on the next search match

" === BASIC ===
    let mapleader = ","
    " I use a Spanish keyboard but still want to use these keys without pressing shift
    map - /
    nmap ñ :
    nmap Ñ :
    imap º <esc>
    nmap ç ^
    nmap ¡ `
    ",o / ,O to insert a line below / above and return to normal mode
    nmap <leader>o o<esc>
    nmap <leader>O O<esc>

    " navigate trought wrapped lines easily
    nmap j gj
    nmap k gk

    " w!! to save as root with sudo
    cmap w!! w !sudo tee % >/dev/null<cr>

" === TAGS ===
    nmap <leader>tg :set tags=tags<cr>
    ",ta jump to tag (also the default C-])
    nnoremap <leader>ta <C-]>
    ",cdt (Create D Tags) regenerate tags for a D project, it needs:
    "https://github.com/snosov1/ctags-d y modificar tagbar.d with:
    "http://blog.adamdklein.com/?p=28 (see Marenz's comment)
    nmap <leader>cdt :!ctags -R /home/juanjux/webmail/backend/source > tags<cr>:set tags=tags<cr>


" === TABS AND WINDOWS ===
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

" === COPY/PASTE ===
    " Obvious shortcuts so I don't mess with C-V, C-C when using Vim along other
    " programs that use these shortcuts for copy/paste (these copy/paste to the
    " system clipboard)
    nmap <C-V> "+gp
    imap <C-V> <ESC><C-V>i
    vmap <C-C> "+y

    " ,p paste AFTER current line, useful when you're pasting several lines
    nnoremap <leader>p :pu<cr>

    " ,V will select the last pasted text
    nnoremap <leader>V `[v`]

" === OTHER ===
    " ,ct Clear Trailing : remove trailing whitespace after the end of line
    nnoremap <leader>ct :%s/\s\+$//<cr>

    " c-j c-k pagedown/up, I find these more 'vimish' than c-f/c-b
    nnoremap <c-j> <c-f>
    nnoremap <c-k> <c-b>

    " ,sv reload .vimrc
    nmap <leader>sv :so $MYVIMRC<cr>

    " ,rr: sometimes syntax highlighting fails and put everything as string, this reset it
    nmap <leader>rr :syntax off<cr>:syntax on<cr>

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


    " Make arrow keys work in Windows gvim
    if has("win64") || has("win32")
        vnoremap <Left> h
        vnoremap <Right> l
        vnoremap <Up> k
        vnoremap <Down> j
    endif

    " some aliases for stupid fingers
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

    " disable help with f1, I hit it alot instead of ESC
    inoremap <f1> <ESC>
    nnoremap <f1> <ESC>
    vnoremap <f1> <ESC>

    " Netrw, Tagbar and Project toggles
    nmap <leader>E :Vex<cr>
    nmap <leader>tb :TagbarToggle<cr>
	nmap <silent> <leader>P <Plug>ToggleProject

    " ,gs (Guarda Sesion) save vim session, ,css (Carga Sesion), load it
    if has("win64") || has("win32")
        nmap <leader>gs :mksession! c:\sesiones\vim_session <cr>
        nmap <leader>css :source c:\sesiones\vim_session" <cr>
    else
        nmap <leader>gs :mksession! ~/vim_session <cr>
        nmap <leader>css :source ~/vim_session <cr>
    endif

    " ,sp, ,snp set paste, set no paste modes
    nmap <leader>sp :set paste<cr>
    nmap <leader>np :set nopaste<cr>

    " Manual SyntasticCheck for the languages where I've the check-on-write disabled (like D)
    nmap <leader>sy :SyntasticCheck<cr>

    " ,1 Put === lines above and below the current line
    nnoremap <leader>1 yyPVr=jyypVr=k

    " =========================================================
    " === COLORS, FONTS AND GUI ===============================
    " =========================================================

    "colors summerfruit
    "colors molokai
    colors professional
    hi NonText guifg=#b2b2b2

    " EasyMotion Colors
    hi link EasyMotionTarget ErrorMsg
    hi link EasyMotionShade  Comment
    hi link EasyMotionTarget2First ErrorMsg
    hi link EasyMotionTarget2Second Define

    " Font
    if has("win64") || has("win32")
        let g:fontman_font = "Monaco"
        let g:fontman_size = 10
    else
        let g:fontman_font = "DejaVu Sans Mono"
        let g:fontman_size = 9
    endif
        

    " GVIM options: copied registers go to system clipboard too; use icon; include toolbar
    set guioptions-=Tai
    set guioptions=egmrt


" =========================================================
" === AUTOCOMPLETE ========================================
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
" === PLUGIN's OPTIONS ========================
" =============================================

" XML Plugin:
    let xml_use_xhtml = 1

" Tagbar:
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

" Project:
    " default flags
    let g:proj_flags="imstvcg"
    " wait a little longer for commands
    set timeout timeoutlen=5000 ttimeoutlen=100

" Yankring:
    " default file
    if has("win64") || has("win32")
        let g:yankring_history_dir="c:\\installs\\vim"
    else
        let g:yankring_history_dir="/home/juanjux/.vim"
    endif

" Emmet:
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


" VimWiki:
    " ,ww: index
    " ,wt: index on new tab
    " ,whh: convert to HTML and open in browser
    " <enter> with something selected will create a new wiki page, over an already
    " linked page the same key will jump to its page
    " ,wr: rename current wiki page
    " ,wd: delete current wiki page
    " alt-up/down to jump between links
    " <leader><enter> open link in new tab
    "
    " FORMAT:
    " [ ] create a checklist enter, <c-space> to enable/disable
    " = for headers (= is h1, == is h2, etc). Spaces before the = will center the tittle
    " * for unnumbered lists
    " # for numbered lists
    " + 'decorates' links: converts URL to link, word to wikilink
    " gl[symbol] to insert symbols uses by vimwiki as *, #, -, 1, etc
    " :VimwikiTable rows/columns: create a table, TAB to change between cells, alt+arrow to move a colum
    " *bold*
    " _italitc__
    " ~~striked~~
    " `code`
    " super^script
    " sub,,script,,
    " {{{ preformatted multiline text}}}
    " quotes indented by 4 spaces
    " ----- is an <hr>
    " [[link]]
    " [[link|with description]]
    "
    if has("win64") || has("win32")
        let g:vimwiki_list = [{'path': 'c:\\Program Files\\ilionData\Users\\juanjo.alvarez\\My Documents\\My Dropbox\\Wiki',
                               \ 'path_html': 'c:\\Program Files\\ilionData\Users\\juanjo.alvarez\\My Documents\\My Dropbox\\Wiki\html'}]
    else
        let g:vimwiki_list = [{'path': '~/btsync/Wiki',
                               \ 'path_html': '~/btsync/wiki/html'}]
    endif
    nnoremap <leader><CR> :VimwikiTabnewLink<cr>

" Syntastic: :Error to show the error listing windows
    let g:syntastic_error_symbol = '>>'
    let g:syntastic_warning_symbol = 'W>'
    let g:syntastic_d_check_header = 0
    let g:syntastic_d_compiler = "$HOME/bin/dub-syntastic"
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['d'] }



" EasyMotion:
    nmap <leader>e <Plug>(easymotion-bd-w)
    nmap d<leader>e <Plug>(easyoperator-line-delete)
    nmap y<leader>e <Plug>(easyoperator-line-yank)
    nmap v<leader>e <Plug>(easyoperator-line-select)
    " ,f easy motion search character 
    nmap <leader>f <Plug>(easymotion-bd-f)
    " ,j easy motion line 
    nmap <leader>j <Plug>(easymotion-bd-jk)

" Unite:
    " <space> and...
        " another <space> to search in buffers and recent files
        " g: grep
        " f: files
        " b:buffers
        " m: mru
        " t: tags
        " y yank history
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])

    let g:unite_source_history_yank_enable = 1
    let g:unite_force_overwrite_statusline = 0
    if executable('ag')
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
      let g:unite_source_grep_recursive_opt = ''
    endif

    call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.svn/',
      \ '\.dub/',
      \ '\.sass-cache/',
      \ '\vendor/',
      \ '\node_modules/',
      \ ], '\|'))

    " Custom mappings for the unite buffer
    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      let b:SuperTabDisabled=1
      imap <buffer> <c-a> <Plug>(unite_choose_action)

      imap <silent><buffer><expr> <C-s> unite#do_action('split')
      imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
      imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

      nmap <buffer> <ESC> <Plug>(unite_exit)
    endfunction

    " The prefix key
    nnoremap [unite] <Nop>
    nmap <space> [unite]

    " General purpose
    nnoremap [unite]<space> :Unite -start-insert buffer file_mru<cr>
    nnoremap [unite]b :Unite -start-insert buffer<cr>
    nnoremap [unite]m :Unite -start-insert file_mru<cr>
    nnoremap [unite]f :Unite -start-insert file_rec/async<cr>
    nnoremap [unite]g :Unite grep:.<cr>
    nnoremap [unite]d :Unite grep:.:-s:\(TODO\|FIXME\|XXX\)<cr>
    nnoremap [unite]t :Unite -start-insert -auto-preview tag<cr>
    nnoremap [unite]o :Unite -start-insert -auto-preview outline<cr>
    nnoremap [unite]l :Unite -start-insert line<cr>
    nnoremap [unite]y :Unite history/yank<cr>
