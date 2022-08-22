" If Vim is started normally and no user vimrc file is found, the
" $VIMRUNTIME/defaults.vim script is loaded. This will set 'compatible' off,
" switch on syntax highlighting and a few more things. See the script for
" details.
" https://vi.stackexchange.com/questions/22944/how-to-keep-defaults-yet-make-customization
" unlet! skip_defaults_vim
" source $VIMRUNTIME/defaults.vim

" Disable a lot of unnecessary internal plugins
" why? cuz the average reaction time for humans is 250 ms to a visual stimulus
" maybe when i get older my eyes won't be able to tell the difference /shrug
" https://www.reddit.com/r/neovim/comments/p1qlbn/help_speeding_up_startup_time_disabling_builtin/
" https://groups.google.com/g/vim_use/c/-Gm374FDLCE
" https://github.com/lervag/dotvim/blob/master/vimrc#L229
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1

" identify os
" let s:darwin = has('mac')
" let s:windows = has('win32') || has('win64')

" EXPERIMENTAL
" let mapleader=','

" ============================================================================
" VIM-PLUG
" ============================================================================
" Install vim-plug if it doesn't installed yet
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" directory for the plugins
call plug#begin('~/.vim/plugged')
" fzf ftw
" fzf#install() makes sure that you have the latest binary, but it's optional,
" so you can omit it if you use a plugin manager that doesn't support hooks.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" run raw Rg commands with :RgRaw
Plug 'jesseleite/vim-agriculture'

" ride the coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ride the coc with fzf
Plug 'antoinemadec/coc-fzf'

" disabling in favor of netrw
" Plug 'preservim/nerdtree'

" use <C-W>m to toggle window zoom
" Plug 'dhruvasagar/vim-zoom'

" :BClose - lightweight alternative for vim-bufkill but not updated recently
" Plug 'rbgrouleff/bclose.vim'

" :BD to delete buffer but keep window/split intact
Plug 'qpkorr/vim-bufkill'

" :UndotreeToggle
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    let g:undotree_WindowLayout = 2
    nnoremap U :UndotreeToggle<CR>

" use `dd` in quickfix list to delete entries
Plug 'TamaMcGlinn/quickfixdd'

" tbh anything by tpope should be integrated into vim by now
" cs/ds/ysiw/yss & S in visual
Plug 'tpope/vim-surround'

" add more power to `.` repeat
Plug 'tpope/vim-repeat'

" gcc for line & gc for a visual selection.
Plug 'tpope/vim-commentary'
    map  gc  <Plug>Commentary
    nmap gcc <Plug>CommentaryLine

" Ctrl-a/Ctrl-x whole dates - 2022-06-10
Plug 'tpope/vim-speeddating'

" Pair of handy bracket mapppings
" [u & ]u for url encode/decode is very handy
Plug 'tpope/vim-unimpaired'

" powershell syntax
Plug 'pprovost/vim-ps1'

" golang syntax and :GoRun, :GoBuild, etc.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }

" kinda lame ... temporarily disabling this plugin
" Plug 'vim-python/python-syntax', { 'on': [] }

" colors
Plug 'sjl/badwolf'
Plug 'jacoborus/tender.vim'
Plug 'joshdick/onedark.vim'
Plug 'hzchirs/vim-material'
Plug 'junegunn/seoul256.vim'
" new gruvbox - use this instead
Plug 'gruvbox-community/gruvbox'
" gruvbox with much better contrast
Plug 'sainnhe/gruvbox-material'
Plug 'preservim/vim-colors-pencil'
Plug 'arcticicestudio/nord-vim'

" show buffers as tabs - vs airline is much faster
" Plug 'ap/vim-buftabline'

" [c & ]c to jump between hunks
Plug 'airblade/vim-gitgutter'

" all git stuff inside of vim
Plug 'tpope/vim-fugitive'

" Enables :GBrowse from fugitive.vim to open GitHub URLs
" Plug 'tpope/vim-rhubarb'

" :GV for better git commit browsing
Plug 'junegunn/gv.vim'

" toggle distraction free writing with :Goyo
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
" Plug 'junegunn/goyo.vim', { 'for': 'markdown', 'on': 'Goyo' }

" paste image/screenshot from clipboard to your markdown file
Plug 'ferrine/md-img-paste.vim', { 'for': 'markdown'}
    " <leader>p to paste image/screenshot from clipboard
    " for osx use ctrl + shift + cmd + 4 to take screenshot and save in clipboard
    " << MAYBE CHANGE THIS CUZ ,p AND ,P ARE MAPPED TO CUSTOM PASTE >>
    autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

    " directory to store images in - `attachments` under current directory
    " where *.md file is being edited
    " let g:mdip_imgdir = 'attachments'
    let g:mdip_imgdir = 'images'
    " filename prefix for images - saved file will have name
    " `image_TIME-STAMP.png`
    let g:mdip_imgname = 'image'

" use pre build, add 'vim-plug' to the filetype list so vim-plug can update
" this plugin, see: https://github.com/iamcco/markdown-preview.nvim/issues/50
" preview markdown in browser with :MarkdowPreview or :MarkdowPreviewToggle
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" junegunn has this
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }

" brew install markdown
" brew install pandoc
" Plug 'JamshedVesuna/vim-markdown-preview'
    " let vim_markdown_preview_toggle=1
    " let vim_markdown_preview_pandoc=1
    " let vim_markdown_preview_perl=1
    " let vim_markdown_preview_browser='Google Chrome'
    " Default: '<C-p>'
    " Example: Mapping Control M.
    " let vim_markdown_preview_hotkey='<C-m>'

" https://www.reddit.com/r/vim/comments/cdcm5e/comment/etyl6hz/?utm_source=share&utm_medium=web2x&context=3
" https://github.com/CrossR/dotfiles/blob/23c96d4de5929647820b9abef37b7d941b08d619/neovim/.config/nvim/config/plugins/wiki.vim#L7-L18
Plug 'lervag/wiki.vim'

" adds some nice extra's for working with markdown documents
" don't use this plugin for markdown syntax highlighting even though it offers
" that feature, cuz its not meant to be used like that (even the author says so)
Plug 'SidOfc/mkdx', { 'for': 'markdown'}
    " set { 'highlight': { 'enable': 0 } since we are using
    " preservim/vim-markdown for syntax highlighting
    " let g:mkdx#settings = { 'highlight': { 'enable': 0 },
    "                      \ 'enter': { 'shift': 1 },
    "                      \ 'links': { 'external': { 'enable': 1 } },
    "                      \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
    "                      \ 'fold': { 'enable': 1 },
    "                      \ 'tokens': { 'strike': '~~'},
    "                      \ 'tab': { 'enable': 1}}


    let g:mkdx#settings = { 'highlight': { 'enable': 0 },
                         \ 'enter': { 'shift': 0 },
                         \ 'links': { 'fragment': { 'complete': 0 } },
                         \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                         \ 'fold': { 'enable': 1 },
                         \ 'tokens': { 'strike': '~~'},
                         \ 'tab': { 'enable': 1}}

    " disable insert mode autocompletion ... let wiki.vim's coc source handle it
    " let g:mkdx#settings = { 'highlight': { 'enable': 0 },
    "                      \ 'links': { 'fragment': { 'complete': 1 } },

    " for vim-polyglot users, it loads Plasticboy's markdown
    " plugin which unfortunately interferes with mkdx list indentation.
    let g:polyglot_disabled = ['markdown']

" adjust tab structure
" Plug 'godlygeek/tabular', {'for': 'markdown'}

" literally only using this for syntax highlighting and strikethrough visuals
" for better editing features use SidOfc/mkdx
" Plug 'preservim/vim-markdown', { 'for': 'markdown'}
    " you will see a strikethrough while editing in additon to
    " ~~Scratch this line~~
    let g:vim_markdown_strikethrough = 1

    " disable default key mappings
    " i'm using the mappings from wiki.vim and mkdx plugins
    let g:vim_markdown_no_default_key_mappings = 1

    " SET THIS TO 0 IF USING SidOfc/mkdx ELSE IT'LL CAUSE PROBLEMS
    " Do not automatically insert bulletpoints ... use mkdx to do that
    let g:vim_markdown_auto_insert_bullets = 0

    " SET THIS TO 0 IF USING SidOfc/mkdx ELSE IT'LL CAUSE PROBLEMS
    " set the new list item indent to 0 as well, or you will have to remove an
    " indent each time you add a new list item
    let g:vim_markdown_new_list_item_indent = 0

    " syntax concealing
    " https://github.com/preservim/vim-markdown#syntax-concealing
    " set conceallevel=2

" EXPERIMENTAL - apparently turns off vim's default syntax highlighting for
" markdown files ... we want preservim/markdown to handle it
" double syntax highlight from two different plugin takes a perfomance hit
" https://coderwall.com/p/bh4rwg/vim-disable-syntax-highlighter-only-for-markdown
" autocmd BufRead,BufNewFile {*.markdown,*.mdown,*.mkdn,*.md,*.mkd,*.mdwn,*.mdtxt,*.mdtext,*.text}
" set filetype=markdown
" au

" default vim markdown
" let g:markdown_minlines = 100
" let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" vim-startuptime, now you know which script file takes time to run. What you
" should do next is :Profile
" Plug 'dstein64/vim-startuptime'
" $ vim --cmd 'profile start profile.log' --cmd 'profile! file /path/to/slow_script.vim' -c quit
" alternative golang program
" https://github.com/rhysd/vim-startuptime
call plug#end()

" ============================================================================
" COLOR SETTINGS
" ============================================================================

" Enable 24-bit true colors if your terminal supports it
if (has("termguicolors"))
    " https://github.com/vim/vim/issues/993#issuecomment-255651605
    " Sometimes setting 'termguicolors' is not enough and one has to set the
    " |t_8f| and |t_8b| options explicitly``
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    set termguicolors
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When set to "dark", Vim will try to use colors that look good on a
" dark background
set background=dark

" gruvbox-material
" Set contrast.
" This configuration option should be placed before `colorscheme
" gruvbox-material`. Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'

" disable italic comments
" let g:gruvbox_material_disable_italic_comment = 1

" Control the |hl-Visual| and the |hl-VisualNOS| highlight group - default grey
let g:gruvbox_material_visual = 'red background'

" Customize the background color of |hl-PmenuSel| and |hl-WildMenu|. - default
let g:gruvbox_material_menu_selection_background = 'purple'

" For better performance
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material
" colorscheme gruvbox

" badwolf
" let g:badwolf_tabline = 2
" let g:badwolf_html_link_underline = 0
" colorscheme badwolf

" hack to get italics for colorschemes that don't have inherent support
" helps with colorschemes like badwolf et al.
" highlight Comment cterm=italic
" highlight Comment gui=italic
" highlight Todo cterm=italic
" highlight Todo gui=italic

" ============================================================================
" STATUSLINE SETTINGS
" ============================================================================

" junegunn's statusline
function! s:statusline_expr()
    let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
    let ro  = "%{&readonly ? '[RO] ' : ''}"
    let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
    let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
    let sep = ' %= '
    let pos = ' %-12(%l : %c%V%) '
    let pct = ' %P'

    return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction

let &statusline = s:statusline_expr()

" ============================================================================
" BASIC SETTINGS
" Research any of these by running :help <setting>
" ============================================================================

" display line number & relativenumber
set number
set relativenumber

" lazily redraw screen while executing macros, and other commands
set lazyredraw
" more characters will be sent to the screen for redrawing
set ttyfast
" highlight current line - apparently affects perfomance if set but idc
set cursorline

" always show the status line
if has("nvim")
    " nvim supports the value `3` which shares one statusline between splits
    set laststatus=3
else
    set laststatus=2
endif

" show keystrokes in the last line of the screen
" set this option off if your terminal is slow
set showcmd
" set noshowcmd
" set visualbell
set noerrorbells visualbell t_vb=

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" You WANT this! else ESC and some other key presses will be slow
" https://vi.stackexchange.com/questions/24925/usage-of-timeoutlen-and-ttimeoutlen
" timeout for mappings
set timeout
" set to 500 if 1000 is too much
set timeoutlen=1000
" timeout for keycodes
set ttimeout
" set to 50 or 100 if 5 is too little
set ttimeoutlen=5

" Changing vim’s option for updatetime from the default of 4000 to ~100 makes
" having longer updatetime leads to noticeable delays
" the gutter signs appear more responsive with ~100
" set to 50 if 100 is too high
set updatetime=100

" Allow specified keys that move the cursor left/right to move to the
" previous/next line when the cursor is on the first/last character in
" the line. Concatenate characters to allow this for these keys:
set whichwrap=b,s

" Don't pass messages to |ins-completion-menu|.
" https://stackoverflow.com/questions/19580157/to-hide-user-defined-completion-message-at-vim
set shortmess+=c

" search options
" https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/cbe1fb5b5505e17bd7709669168c367903d94cd4/.vimrc#L217
set incsearch
set ignorecase
set smartcase
set hlsearch

" beter search highlighting
" https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/cbe1fb5b5505e17bd7709669168c367903d94cd4/.vimrc#L221
highlight clear Search
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
highlight    IncSearch    ctermfg=White  ctermbg=Red    cterm=bold

" hide buffers instead of closing them even if they contain unwritten changes
set hidden

" better menu with completion in command mode
set wildmenu
" bash like completion
" set wildmode=list:longest,full
" i like this one better - much cleaner and less distracting
set wildmode=longest:full,full

" tabs & indentation
" To change all the existing tab characters to match the current tab settings
" use :retab
" 1 tab = 4 spaces
set tabstop=4 shiftwidth=4
" expand tab into spaces
set expandtab
" insert/delete correct number of spaces when using <TAB> and <BS> keys
set softtabstop=4
" Use shiftwidths at left margin, tabstops everywhere else
set smarttab
" Always indent/outdent to nearest tabstop
set shiftround

" auto indent
set autoindent
" even better autoindent (e.g. add indent after '{')
set smartindent

" Make sure that coursor is always centered on j/k moves
set scrolloff=999

" enable utf8 support
set encoding=utf8
" the encoding written to file.
set fileencoding=utf-8

" define how special characters are displayed when using
" the command :list or :set list
set listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:+,eol:$

" change how `C-v` visual block selection behaves
" https://medium.com/usevim/vim-101-virtual-editing-661c99c05847
" set virtualedit=block
set virtualedit=all

" don't add extra spaces after sentences (lines ending in !, ?, or .)
" while joining them with `J`
set nojoinspaces

" Always use vertical diffs
" set diffopt+=vertical
" set diffopt=filler,vertical

" https://begriffs.com/posts/2019-07-19-history-use-vim.html#diffs-and-patches
set diffopt+=internal,algorithm:patience

" shortcuts for 3-way merge
map <Leader>d1 :diffget LOCAL<CR>
map <Leader>d2 :diffget BASE<CR>
map <Leader>d3 :diffget REMOTE<CR>

" reload on external file changes
" However, if the file is deleted, it will not be re-read to keep the content
" from before it was deleted
set autoread

" Write the contents of the file, if it has been modified, on each
" `:next`, `:rewind`, `:last`, `:first`, `:previous`, `:stop`, etc.
" set autowrite

" enable copy/paste with system clipboard
" https://stackoverflow.com/a/30691754
" `unnamedplus` is for linux
set clipboard=unnamed,unnamedplus
" also for linux you need vim-gtk or vim-gtk3 (what i used on debian-based
" distros) ... this installs gvim too but oh well /shrug
" other option is to compile from source with `+clipboard`
" compile notes --> https://gist.github.com/joshukraine/b9085aeb3dd762cf1d1e1c356974032f
" https://stackoverflow.com/a/11489440

" fold manually
set foldmethod=manual
" don't fold by default
set nofoldenable
" Don't start new buffers folded
set foldlevelstart=99

" this should be the result of :verb set complete?
" set complete=.,w,b,u,t,i

" The i option states that it will “scan current and included files”, which might
" pollute the autocomplete results if your current file includes a lot of other
" files. As such, it makes sense to disable this option.
" set complete-=i

" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" default
" set completeopt=menu,preview

" other completeopts to play with
" set completeopt=noinsert,noselect,menuone
" set completeopt=menu,menuone,noinsert,noselect

" Enable Ctrl-A/Ctrl-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha,bin

" silent! set cryptmethod=blowfish2

" String to put at the start of lines that have been wrapped
" works well with :ToggleWrap
if has('patch-7.4.338')
    let &showbreak = '↳ '
    set breakindent
    set breakindentopt=sbr
endif

" https://www.reddit.com/r/vimdailytips/comments/ihqmii/modeline/
" put comments containing Vim settings in any file and Vim can read and execute these settings
" eg: " vim: fdm=marker fmr=<<<,>>>
" prevents some security exploits having to do with modelines in files
" I never use modelines so I don't miss any functionality here.
" https://alioth-lists-archive.debian.net/pipermail/pkg-vim-maintainers/2007-June/004020.html
set modelines=0

" Maximum column in which to search for syntax items. In long lines the
" text after this column is not highlighted and following lines may not
" be highlighted correctly, because the syntax state is cleared.
" This helps to avoid very slow redrawing for an XML file that is one
" long line. Set to zero to remove the limit. Default=3000
set synmaxcol=1000

" define ctags file names
" set tags=./tags;/
" set tags=./tags,tags;
" vim default
" set tags=./tags,tags

" stop looking for tags `;` if already found in ./tags
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" disable backup & swap files
" set nobackup
" set noswapfile
" set nowritebackup

" swap, backups and undo
" https://stackoverflow.com/a/4331812
" https://begriffs.com/posts/2019-07-19-history-use-vim.html#backups-and-undo
" Protect changes between writes. Default values of updatecount (200
" keystrokes) and updatetime (4 seconds) are fine
set swapfile
" create swap directory if it doesn't exist
if !isdirectory("/tmp/.vim/swap")
    call mkdir("/tmp/.vim/swap", "p", 0700)
endif
" set swap directory
set directory=/tmp/.vim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" create backup directory if it doesn't exist
if !isdirectory("/tmp/.vim/backup")
    call mkdir("/tmp/.vim/backup", "p", 0700)
endif
" consolidate the writebackups -- not a big deal either way, since they usually
" get deleted
set backupdir=/tmp/.vim/backup//

" create undo directory if it doesn't exist
if !isdirectory("/tmp/.vim/undo")
    call mkdir("/tmp/.vim/undo", "p", 0700)
endif
" semi persistent undo
" even after closing buffers or vim itself (until reboot - cuz /tmp)
set undodir=/tmp/.vim/undo//
set undofile
set undolevels=9999

" Shift-tab on GNU screen
" http://superuser.com/questions/195794/gnu-screen-shift-tab-issue
" set t_kB=[Z

" enable mouse support in term for [a]ll modes
set mouse=a
" adding condition as ttymouse causes errors in nvim
if !has("nvim")
    " make mouse mode work while using vim inside of tmux
    set ttymouse=xterm2
endif

" Keep the cursor on the same column while browsing up/down
" set nostartofline

" formatoptions - from rwxrob
" set formatoptions=tcqrn1
" Just the defaults, these are changed per filetype by plugins.
set fo-=t   " don't auto-wrap text using text width
set fo+=c   " autowrap comments using textwidth with leader
set fo-=r   " don't auto-insert comment leader on enter in insert
set fo-=o   " don't auto-insert comment leader on o/O in normal
set fo+=q   " allow formatting of comments with gq
" set fo-=w   " don't use trailing whitespace for paragraphs
" set fo-=a   " disable auto-formatting of paragraph changes
" set fo-=n   " don't recognized numbered lists
" set fo+=j   " delete comment prefix when joining
" set fo-=2   " don't use the indent of second paragraph line
" set fo-=v   " don't use broken 'vi-compatible auto-wrapping'
" set fo-=b   " don't use broken 'vi-compatible auto-wrapping'
" set fo+=l   " long lines not broken in insert mode
" set fo+=m   " multi-byte character line break support
" set fo+=M   " don't add space before or after multi-byte char
" set fo-=B   " don't add space between two multi-byte chars
" set fo+=1   " don't break a line after a one-letter word

" Delete comment character when joining commented lines
set formatoptions+=j

" formatoptions for linewrapping etc
" set formatoptions-=cro                           "disable auto comments on new lines
" set formatoptions-=t                             " prevent auto word wrapping
" set statusline=...[%{&fo}]...                    " show formatting options in statusline

" display text width column
set textwidth=79
" add visual cue as column
set colorcolumn=80
" disable wrapping
set nowrap

" checks if Vim is compiled with syntax and if the global variable syntax_on
" already exists. The goal is to avoid turning on syntax multiple times if it was
" already enabled.
if has('syntax') && !exists('g:syntax_on')
    " enable syntax highlightning
    syntax enable
endif

" enable filetype detection
filetype plugin indent on

" show matching brackets
set showmatch

" sane vim splits
set splitbelow
set splitright

" let airline handle mode display in statusline
" set noshowmode
set showmode

" give more space for displaying messages
" you can also view truncated messages with :messages
set cmdheight=2

" sensible.vim
" https://towardsdatascience.com/explaining-every-line-of-vim-sensible-b776affec51a
set sidescrolloff=5
set display+=lastline
set history=1000
set tabpagemax=50

" save and restore global variables that start with uppercase letter and don’t
" have any lowercase letter in them.
" Alternatively, if you want to run Vim in a kind of private mode, you can
" disable the viminfo functionality by using the command set viminfo=.
if !empty(&viminfo)
  set viminfo^=!
endif

" Searches wrap around the end of the file. Also applies to |]s| and
" |[s|, searching for spelling mistakes.
set wrapscan

" mark trailing spaces as errors
" works well with :Chomp
match IncSearch '\s\+$'

" ============================================================================
" BASIC MAPPINGS
" ============================================================================

" https://www.reddit.com/r/vimdailytips/comments/ik6fo1/for_a_complete_list_of_mappings_stored_in_a_file/
" For a complete list of mappings stored in a file...
" :redir! > vim_keys.txt
" :silent verbose map
" :redir END

" remap leader key to `,`
" define this before defining any custom mappings
" else they'll map to dear old `\`
let mapleader=','

" Fuck you, help key
" I always hit F1 when trying to hit ESC
noremap  <F1> <nop>
inoremap <F1> <nop>

" Easier to type, and I never use the default behavior
noremap H ^
noremap L $
vnoremap L g_

" Open new line below and above current line and exit insert mode
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" save
" :up/:update writes only if something is changed
" vs :w that writes regardless of changes
nnoremap <leader>w :up<cr>
inoremap <leader>w <C-c>:up<cr>

" i do this often to put it in here
cnoreabbrev W :up
cnoreabbrev Q :q

" quit
nnoremap <leader>qq :q!<cr>
inoremap <leader>qq <C-c>:q!<cr>
nnoremap <Leader>Q :qa!<cr>

" save & quit
" nnoremap <leader>zz :wq<cr>
inoremap <leader>zz <C-c>:wq<cr>

" toggle paste mode
" set pastetoggle=<F4>

" Keep cursor at the bottom of the visual selection after you yank it.
" vmap y ygv<Esc>

" Format paragraph (selected or not) to 80 character lines.
" nnoremap <Leader>g gqap
" xnoremap <Leader>g gqa

" Disable CTRL-A on tmux or on screen
" if $TERM =~ 'screen'
"   nnoremap <C-a> <nop>
"   nnoremap <Leader><C-a> <C-a>
" endif

" Jump list (to newer position) ... opposite of C-o
nnoremap <C-p> <C-i>

" <leader>n | Toggle NERD Tree
" nnoremap <leader>n :NERDTreeToggle<cr>

" <leader>n | Toggle Netrw
nnoremap <leader>n :Lexplore<CR>

" <ESC> key lies too far on the keyboard
" jk | Escaping! - inset and command mode ... visual mode kinda dookie with jk
inoremap jk <Esc>
" inoremap jj <Esc>
cnoremap jk <C-c>
" cnoremap jj <C-c>
" xnoremap jk <Esc>

" make Y consistent with C and D
nnoremap Y y$

" hit qq to record, q to stop recording, and Q to apply.
" This mapping also allows you to play macros across a visual selection with Q.
nnoremap Q @q
vnoremap Q :norm @q<cr>

" reselect last inserted/pasted text
" pairs really well with `gv` which selects last visual selection
" https://vimtricks.com/p/reselect-pasted-text/
nnoremap gp `[v`]

" reload .vimrc
nnoremap <leader>r :source ~/.vimrc<CR>

" toggles :set list
map <leader>l :set list!<CR>

" single key to enter command mode
" hit ';' to enter command mode from normal & visual modes
" nnoremap ; :
" vnoremap ; <Esc>:

" ----------------------------------------------------------------------------
" Markdown headings
" https://github.com/junegunn/dotfiles/blob/master/vimrc#L501
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => text editing & navigation mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Duplicate a line/selection and comment out the original
nmap <Leader>cc yypkgccj
vmap <Leader>cc <Esc>yypkgccj

" Uppercase/lowercase current word
" use ~ to toggle case of current character
" Normal mode
nnoremap <leader>cu <esc>gUiw
nnoremap <leader>cl <esc>guiw
" Insert mode
inoremap <leader>cu <esc>gUiw
inoremap <leader>cl <esc>guiw

" paste last thing you yanked, not deleted
" you can still paste last deleted thing with p (default behaviour)
" paste after cursor
nmap <leader>p "0p
" paste before cursor
nmap <leader>P "0P

" Increment/decrement numbers holding shift-`+/-` keys instead of ctrl-`a/x`
" cuz Ctrl-a is set as tmux prefix
" nmap + <C-a>
" nmap _ <C-x>
" vmap + <C-a>
" vmap _ <C-x>

" ----------------------------------------------------------------------------
" Quickfix/Location list navigation
" ----------------------------------------------------------------------------

nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" <Leader>c Close quickfix/location window
" ----------------------------------------------------------------------------

" nnoremap <leader>c :cclose<bar>lclose<cr>

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" view next buffer
" noremap <tab> :bn<CR>
" view previous buffer
" noremap <S-tab> :bp<CR>
" toggle between last visited buffers
" noremap <leader>bl :b#<CR>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------

nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" Splits
" ----------------------------------------------------------------------------

" Vertical split
map tv :vsplit<CR>
nmap <silent> <Leader>vv :vsplit<CR>
" Horizontal split
map ts :split<CR>
nmap <silent> <Leader>vh :split<CR>

" swap splits
" nmap <silent> <Leader>vs <C-w>r
" toggle between splits
" nmap <silent> <Leader>vt <C-w>w

" ----------------------------------------------------------------------------
" Circular windows navigation | <tab> / <s-tab>
" ----------------------------------------------------------------------------

nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W
" close splits with <leader>o
" nnoremap <Leader>o <C-w>o

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------

" visual shifting (does not exit Visual mode)
xnoremap > >gv
xnoremap < <gv

" Move line(s) up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------

" cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
" cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
" cnoremap        <M-b> <S-Left>
" cnoremap        <M-f> <S-Right>
" silent! exe "set <S-Left>=\<Esc>b"
" silent! exe "set <S-Right>=\<Esc>f"

" start of line
cnoremap <C-A>  <Home>
" end of line
cnoremap <C-E>  <End>
" back one character
cnoremap <C-B>  <Left>
" forward one character
cnoremap <C-F>  <Right>
" delete character under cursor
cnoremap <C-D>  <Del>
" recall newer command-line
cnoremap <C-N>  <Down>
" recall previous (older) command-line
cnoremap <C-P>  <Up>
" back one word
cnoremap <C-c><C-B> <S-Left>
" cnoremap <Esc><C-B> <S-Left>
" forward one word
cnoremap <C-c><C-F> <S-Right>
" cnoremap <Esc><C-F> <S-Right>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Window resize
" Remap 'Ctrl + arrow keys' to resize window
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <C-W><Up> :resize -5<CR>
nnoremap <silent> <C-W><Down> :resize +5<CR>
nnoremap <silent> <C-W><Right> :vertical resize -5<CR>
nnoremap <silent> <C-W><Left> :vertical resize +5<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Highlight search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" you can also press 'enter' after searching to clear the highlighted results
nnoremap <CR> :noh<CR><CR>

" but this in more permanent
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    map <C-L> :let @/ = ""<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search & Replace
" you need to enter 'search' term and 'replace' value
" https://github.com/nickjj/dotfiles/blob/725c9b1d42686cf3ebc34dd5636bcc30c2df3b31/.vimrc#L453
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" search and replace and require confirmation for each candidate
nnoremap <leader>sc :%s:::gc<Left><Left><Left><Left>
" search and replace without confirmmation
nnoremap <leader>sr :%s:::g<Left><Left><Left>

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
" requires confirmation
nnoremap <Leader>sc :%s///gc<Left><Left><Left>
" doesn't require confirmation
nnoremap <Leader>sr :%s///g<Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>sc :s///gc<Left><Left><Left>
xnoremap <Leader>sr :s///g<Left><Left>

" Press s* to select and clear word under cursor
" Next, type a replacement term and press `.` to repeat the replacement again.
" Useful for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" search for trailing whitespaces at end of line
" keep hitting 'n' to find next occurence and then you can delete them manually
nnoremap <leader>sw :s/\s\+$//e<CR>
" hit `,st` to remove all trailing whitespace
" nnoremap <silent> <Leader>st :%s/\s\+$//<CR><c-o>

" List all matches of word under cursor and prompt to jump to one.
nnoremap <leader>co [I:let nr = input("Match: ")<Bar>exe "normal ".nr."[\t"<CR>

" ============================================================================
" FUNCTIONS & COMMANDS
" ============================================================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => :SudoWrite - writes file with sudo privs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! SudoWrite :execute ':silent w !sudo tee % > /dev/null' | :edit!
" Use :w!! instead of :SudoWrite
cnoreabbrev w!! SudoWrite

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => :Vimrc - call :Vimrc to edit ~/.vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! Vimrc edit $MYVIMRC

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => :VersionSort - very useful for file containing long uris or numbers
" sort the buffer removing duplicates
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! VersionSort %!sort -u --version-sort

" ----------------------------------------------------------------------------
" :Chomp - chomp trailing whitespace
" ----------------------------------------------------------------------------

command! Chomp %s/\s\+$// | normal! ``

" ----------------------------------------------------------------------------
" :Count - count number of matches e.g. :Count wordtosearch
" ----------------------------------------------------------------------------

command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``

" ----------------------------------------------------------------------------
" :FormatJSON - formats json file to make it look pretty
" ----------------------------------------------------------------------------

command! FormatJSON %!python3 -m json.tool

" this one requires `jq` to be installed
command! FormatJSONjq %!jq

" ----------------------------------------------------------------------------
" :AutoIndent - fixes/indents the entire document with current tab/indentation
" settings
" Go to the start of the page gg and autoindent to the end of the page =G
" gg=G
" ----------------------------------------------------------------------------

command! AutoIndent :normal gg=G

" ----------------------------------------------------------------------------
" :TimeStamp - inserts current date/time stamp under cursor
" https://stackoverflow.com/a/57789091
" ----------------------------------------------------------------------------

command TimeStamp execute "normal i<C-R>=strftime('%Y-%m-%d %a %I:%M %p')<CR><ESC>"

" ----------------------------------------------------------------------------
" Zoom - now you can toggle pane zoom with <leader>z
" no need for external plugin
" ----------------------------------------------------------------------------

function! s:zoom()
    if winnr('$') > 1
        tab split
    elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                \ 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
    endif
endfunction

nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------

function! s:root()
    let root = systemlist('git rev-parse --show-toplevel')[0]
    if v:shell_error
        echo 'Not in git repo'
    else
        execute 'lcd' root
        echo 'Changed directory to: '.root
    endif
endfunction
command! Root call s:root()

" ----------------------------------------------------------------------------
" :Profile
" Profile Vim by running this command once to start it and again to stop it.
" ----------------------------------------------------------------------------

function! s:profile(bang)
    if a:bang
        profile pause
        noautocmd qall
    else
        profile start /tmp/profile.log
        profile func *
        profile file *
    endif
endfunction
command! -bang Profile call s:profile(<bang>0)

" ----------------------------------------------------------------------------
" AreThereTrailingSpaces
" calculates trailing whitespace and prints to statusline
" ----------------------------------------------------------------------------

function! AreThereTrailingSpaces()
    " :help getline() to grab the lines in the buffer in a list,
    " :help filter() to only keep the interesting ones,
    " :help =~ is a regexp operator, yes, it blew my mind too,
    " :help len() to see if there is a line with trailing spaces,
    " :help 'statusline' to integrate the output of our function.
    return len(filter(getline(1,'$'), 'v:val =~ "\\s$"')) > 0 ? "[There are trailing spaces!]" : "[GG!]"
endfunction

set statusline+=\ %{AreThereTrailingSpaces()}

" ----------------------------------------------------------------------------
" ToggleQuickFix - toggle quickfix window with F2
" https://stackoverflow.com/questions/11198382/how-to-create-a-key-map-to-open-and-close-the-quickfix-window-in-vim
" plugin variant --> https://github.com/milkypostman/vim-togglelist
" blog explaining quickfix --> https://freshman.tech/vim-quickfix-and-location-list/
" ----------------------------------------------------------------------------

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <F2> :call ToggleQuickFix()<cr>

" ----------------------------------------------------------------------------
" ToggleWrap - Toggle soft wrapping and map correct motion keybinds
" Toggle with F12 - very useful for writing in general esp. markdown files
" https://vimtricks.com/p/word-wrapping/
" ----------------------------------------------------------------------------

let s:wrapenabled = 0

function! ToggleWrap()
  " set wrap nolist
  if s:wrapenabled
    set nowrap
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set wrap nolist
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction

map <F12> :call ToggleWrap()<CR>

" ----------------------------------------------------------------------------
" ToggleHex - call with :Hexmode command
" toggles a file in/out of hex mode with help of external program `xxd`
" https://vim.fandom.com/wiki/Improved_hex_editing
" ----------------------------------------------------------------------------

" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" ----------------------------------------------------------------------------
" :RemoveQFItem - aliases with 'dd', removes item in quickfix list
" When using `dd` in the quickfix list, remove the item from the quickfix list.
" https://stackoverflow.com/a/48817071
" plugin alternative available - https://github.com/TamaMcGlinn/quickfixdd
" ----------------------------------------------------------------------------

" function! RemoveQFItem()
"   let curqfidx = line('.') - 1
"   let qfall = getqflist()
"   call remove(qfall, curqfidx)
"   call setqflist(qfall, 'r')
"   execute curqfidx + 1 . "cfirst"
"   :copen
" endfunction

" :command! RemoveQFItem :call RemoveQFItem()
" " Use map <buffer> to only map dd in the quickfix window. Requires +localmap
" autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

" ============================================================================
" PLUGINS
" ============================================================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MatchParen delay
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:matchparen_insert_timeout=5

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => matchit.vim - is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use % to jump between < & >
set matchpairs+=<:>

" Used without an exclamation mark, `runtime` reads Vim script commands from
" the first path it finds in any of its 'runtimepath' directories.
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"% at the end of :NERDTreeToggle makes it show the current directory only
" nnoremap <leader>n :NERDTreeToggle %<CR>
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw (built-in)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" refer --> https://shapeshed.com/vim-netrw/
" refer --> http://ellengummesson.com/blog/2014/02/22/make-vim-really-behave-like-netrw/
" netrw built-in explorer configured to look like nerdtree
" disable banner
let g:netrw_banner = 0
" tree style listing
let g:netrw_liststyle = 3
" open file in previous window to the right of :Vexplore
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" set width of netrw window
let g:netrw_winsize = 25
" If you’ve set custom wildignores netrw can inherit them by doing this:
let g:netrw_list_hide = &wildignore

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-bufkill
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-bufkill plugin specific
" Turn off default <leader>bb, <leader>bd, etc. mappings (default: 1)
let g:BufKillCreateMappings = 0

" close window - useful if buffer is open in vim split
" use this to hide buffer instead of deleting it (:bd)
cnoreabbrev bc close

" hides buffer instead of deleting it - only works if buffer is in split/vsplit
" map <leader>bc :close<CR>
" create empty buffer
" map <leader>be :enew<CR>
" delete buffer
" map <leader>bd :bd<CR>
" maps :BD (from vim-bufkill) to delete buffer but keep window/split intact
" map <leader>BD :BD<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => bclose.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" turn off default bclose.vim mappings
" let g:bclose_no_plugin_maps = 1
" to make sure buffer is not closed if it is displayed more than once:
" :let bclose_multiple = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-surround mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" surround word under cursor with backticks
nmap <leader>` ysiw`

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Next/prev git change, and disable intrusive GitGutter mappings
let g:gitgutter_map_keys = 0
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

" This is like :GitGutterNextHunk but when it gets to the last hunk in the
" buffer it cycles around to the first.
" Invoke with <leader>gg
function! GitGutterNextHunkCycle()
    let line = line('.')
    silent! GitGutterNextHunk
    if line('.') == line
        1
        GitGutterNextHunk
    endif
endfunction

nmap <silent> <leader>gg :call GitGutterNextHunkCycle()<CR>

" show gitgutter stats - use in statusline
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction

set statusline+=\ %{GitStatus()}

" https://jakobgm.com/posts/vim/git-integration/
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg

" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
" let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" Change the color of the git-gutter to same color as linenumbers
" highlight clear SignColumn
" change colors for gitgutter symbols
" highlight GitGutterAdd ctermfg=green guifg=green
" highlight GitGutterChange ctermfg=yellow guifg=yellow
" highlight GitGutterDelete ctermfg=red guifg=red
" highlight GitGutterChangeDelete ctermfg=yellow guifg=yellow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc.nvim - THIS NEEDS REWORK
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" coc extensions
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-powershell',
  \ 'coc-pyright',
  \ 'coc-json',
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ CheckBackspace() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fc <Plug>(coc-format-selected)
nmap <leader>fc <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
" commenting this out as it conflicts with `,cl`
" nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"     nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"     nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"     inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"     inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"     vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"     vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => cantoinemadec/coc-fzf mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
nnoremap <silent> <space>d       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <space>e       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <space>l       :<C-u>CocFzfList location<CR>
nnoremap <silent> <space>o       :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>p       :<C-u>CocFzfListResume<CR>

" reverse coc-fzf layout so that search bar is on top
" let g:coc_fzf_opts = ['--layout=reverse']

" Q: CocFzf looks different from my other Fzf commands. How to make it the same?
" A: By default, CocFzf tries to mimic CocList. Here is how to change this:
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" add the following inside .vimrc if installed using homebrew
" set rtp+=/usr/local/opt/fzf

" let $FZF_DEFAULT_OPTS .= ' --inline-info'

" All files
" NEEDS `fd` installed - fd > file
" command! -nargs=? -complete=dir AF
"   \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
"   \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
"   \ })))

" https://github.com/junegunn/fzf.vim/issues/358#issuecomment-841665170
" let $FZF_DEFAULT_OPTS .= "--preview-window 'right:57%' --preview 'bat --style=numbers --line-range :300 {}'
"     \ --bind ctrl-y:preview-up,ctrl-e:preview-down,
"     \ctrl-b:preview-page-up,ctrl-f:preview-page-down,
"     \ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,
"     \shift-up:preview-top,shift-down:preview-bottom,
"     \alt-up:half-page-up,alt-down:half-page-down"

let g:fzf_colors =
            \ { 'fg':         ['fg', 'Normal'],
            \ 'bg':         ['bg', 'Normal'],
            \ 'preview-bg': ['bg', 'NormalFloat'],
            \ 'hl':         ['fg', 'Comment'],
            \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':        ['fg', 'Statement'],
            \ 'info':       ['fg', 'PreProc'],
            \ 'border':     ['fg', 'Ignore'],
            \ 'prompt':     ['fg', 'Conditional'],
            \ 'pointer':    ['fg', 'Exception'],
            \ 'marker':     ['fg', 'Keyword'],
            \ 'spinner':    ['fg', 'Label'],
            \ 'header':     ['fg', 'Comment'] }

" make fzf play well when vim is running inside tmux
if exists('$TMUX')
    let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" fzf mappings
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>m :Maps<CR>
nnoremap <silent> <C-f> :Files<CR>
" searching inside files - running :Rg without args will also match filenames
nnoremap <silent> <Leader>ff :Rg<CR>
" nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>fl :BLines<CR>
" nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
" nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :Helptags<CR>
nnoremap <silent> <Leader>hf :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" show mappings and select one of them to apply
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)

" EXPERIMENTAL
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files $KB_DIRECTORY')

" Rg current word - preferably use Rg this way or by passing args --> :Rg derp
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

" make fzf use ripgrep for all its searches
" restarts ripgrep whenever the query string is updated
" this is essentially doing <leader>rg but interactively
function! RipGrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" call above function RipGrepFzf with :RG as oppossed to :Rg
command! -nargs=* -bang RG call RipGrepFzf(<q-args>, <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-agriculture
" https://jesseleite.com/posts/4/project-search-your-feelings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" :RgRaw and pass any args in Normal mode
" disabling this so that in markdown files ,/ works to toggle italics
" nmap <Leader>/ <Plug>RgRawSearch

" :RgRaw current selection in Visual mode
" vmap <Leader>/ <Plug>RgRawVisualSelection
vmap <Leader>* <Plug>RgRawVisualSelection

" :RgRaw current word under cursor in Normal mode
nmap <Leader>* <Plug>RgRawWordUnderCursor

" command! -bang -nargs=+ -complete=dir Ag call fzf#vim#ag_raw(agriculture#smart_quote_input(<q-args>), <bang>0)

if executable("rg")
    " configure vim to use ripgrep instead of grep
    " https://github.com/BurntSushi/ripgrep/issues/425#issuecomment-381446152
    " set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --follow
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    " This will make the location list understand the output format better
    " https://github.com/BurntSushi/ripgrep/issues/425#issuecomment-702244167
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
if has("nvim")
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
else
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SidOfc/mkdx
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" the plugin maps <Tab> to <Plug>(mkdx-indent) and <S-Tab> to
" <Plug>(mkdx-unindent) ... this messes with my own bindings, so we remap
" to ,<Tab> and ,<S-Tab>
nnoremap <leader><Tab> <Plug>(mkdx-indent)
nnoremap <leader><S-Tab> <Plug>(mkdx-unindent)

" doesn't work
" nnoremap <leader>ss <Plug>(mkdx-text-strike-n)
" nnoremap <leader>ss <Plug>(mkdx-text-strike-v)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lervag/wiki.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" root directory of |wiki.vim|
let g:wiki_root = '~/workspace/wiki/'

" List of filetypes for which |wiki.vim| should be enabled
" let g:wiki_filetypes = ['md']
" adding other extensions will show the attachment filenames in :WikiFzfPages
" EXPERIMENTAL
let g:wiki_filetypes = ['md', 'png', 'py', 'java', 'js']

" use markdown style links by default
let g:wiki_link_target_type = 'md'

" Specify the extension that should be applied to wiki links
" temporarily disabling this cuz i don't want .md to be added to internal file
" section header links
" let g:wiki_link_extension = '.md'

" save the current file automatically before navigating (forward/backward)
" between wiki links with ,gf ... any other method of file jumping won't
" work ... for that you may want to look into `set autowrite`
" let g:wiki_write_on_nav = 1

" EXPERIMENTAL
let g:wiki_fzf_pages_opts = '--preview "bat --color=always {1}"'

" open .py & .java files in vim ... by default wiki.vim uses external apps like
" sublime text on osx
" https://stackoverflow.com/a/59173556
" https://github.com/lervag/wiki.vim/issues/70#issuecomment-623006169
let g:wiki_file_handler = 'WikiFileHandler'
function! WikiFileHandler(...) abort dict
    " if self.path =~# 'py$'
    " if self.path =~# '\(py\|java\)$'
    if self.path =~# '\v(py|java|xml|vbs|js)$'
        silent execute ':e' fnameescape(self.path)
        return 1
    endif
    return 0
endfunction

" transform filename before creating a new wiki file by calling
" WikiCreateFunction for files created with :WikiOpen
let g:wiki_map_create_page = 'WikiCreateFunction'
" takes filename as argument eg. :WikiOpen<CR> then enter filename of new
" wiki file
" https://datamanagement.hms.harvard.edu/collect/file-naming-conventions
" https://osf.io/dpu45/download
" https://xkcd.com/1459/
" http://www.vimregex.com/
function WikiCreateFunction(text) abort
    " filename should be lowercase
    let lowered = tolower(a:text)
    " replace whitespace with hyphen
    let no_spaces = substitute(lowered, '\s\+', '-', 'g')
    " remove all special chars i.e. only allow [0-9A-Za-z], hyphens and
    " underscores
    let no_symbols = substitute(no_spaces, "[^[:alnum:]_-]", '', 'g')
    " filename should not end with hyphens or underscores
    let no_trailing_symbols = substitute(no_symbols, '\([_-]\)\+$', '', 'g')
    " filename should not begin with hyphens or underscores
    let no_leading_symbols = substitute(no_trailing_symbols, '^\([_-]\)\+', '', 'g')
    return no_leading_symbols
endfunction

" transform text before creating a new link by calling WikiLinkFunction
" for links created with :WikiLinkFollow and :WikiLinkToggle
let g:wiki_map_link_create = 'WikiLinkFunction'

" Converts "My section header link" to "#my-section-header-link"
" I use this ONLY for internal file section header links
" How to use it: Copy-paste section header from :TOC, re-select the pasted
" text and press <CR>
function! WikiLinkFunction(text) abort
    " return substitute(tolower(a:text), '\s\+', '-', 'g')

    " link name should be lowercase
    let lowered = tolower(a:text)
    " replace whitespace with hyphen
    let no_spaces = substitute(lowered, '\s\+', '-', 'g')
    " add # in the beginning to indicate internal file section header
    let add_hash = substitute(no_spaces, '^', '#', 'g')
    return add_hash
endfunction

" ,fw to call :WikiFzfPages from anywhere to search wiki listing of files
" nnoremap <silent> <leader>fw :WikiFzfPages<CR>
nnoremap <silent> <leader>wf :WikiFzfPages<CR>

" ,gf to call :WikiLinkFollow from anywhere
nnoremap <silent> <leader>gf :WikiLinkFollow<CR>

" ,wt for :WikiFzfToc
nnoremap <leader>wt :WikiFzfToc<CR>

" like :WikiLinkFollow but in vsplit
" DOESN'T WORK
" nnoremap <silent> <leader>vgf :vert WikiLinkFollowSplit<cr>

" https://github.com/lervag/wiki.vim/issues/102
function! WikiRgFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {
  \ 'dir': wiki#get_root(),
  \ 'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]
  \}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang WikiFzfContent call WikiRgFzf(<q-args>, <bang>0)
" nnoremap <leader>ft :WikiFzfContent<CR>
nnoremap <leader>wc :WikiFzfContent<CR>

" ============================================================================
" AUTOCMD
" ============================================================================

" put the autocmds into a group for easy removal later
augroup vimrc
    " remove all vimrc autocommands
    autocmd!
    " Auto-resize splits when Vim gets resized.
    autocmd VimResized * wincmd =

    " Return to last edit position when opening non-empty files - You WANT this!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                        \|   exe "normal! g`\""
                        \|endif
    " Remember info about open buffers on close
    " set viminfo^=%

    " make the command mode case insensitive - You WANT this!
    " You can dynamically toggle smartcase using autocmds
    " so when in a : command line, it is off and when in a / command line it is
    " on ... assumes set ignorecase smartcase
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase

    " Update a buffer's contents on focus if it changed outside of Vim.
    " au FocusGained,BufEnter * :checktime

    " Make sure all types of requirements.txt files get syntax highlighting.
    autocmd BufNewFile,BufRead requirements*.txt set syntax=python

    " Only show the cursor line in the active buffer.
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline

    " Renames the tmux window with name of the file open in vim
    if exists('$TMUX') && !exists('$NORENAME')
        autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
        autocmd VimLeave * call system('tmux set-window automatic-rename on')
    endif

    " make :h always open in new tab
    " https://stackoverflow.com/a/69190346
    autocmd BufEnter *.txt if &filetype == 'help' | wincmd T | endif

    " use q in :help mode to exit
    " cuz :q is a little bit annoying since this is a readonly buffer
    " https://superuser.com/a/1140661
    autocmd FileType help noremap <buffer> q :q<cr>

    " wrap git commit messages in vim to 72
    " That setting should already exist in .../vim73/ftplugin/gitcommit.vim
    " unless you've set your own textwidth
    " https://stackoverflow.com/a/11023282
    " autocmd FileType gitcommit setlocal tw=72

    " auto re-format every time text is inserted/deleted in markdown files
    " refer the following link for more info about auto formatting for asciidoc
    " and markdown:
    " http://germaniumhq.com/2020/04/08/2020-04-08-Vim-Auto-Formatting-for-Asciidoc-and-Markdown/
    " autocmd BufNewFile,BufRead *.md set formatoptions+=a
    autocmd BufNewFile,BufRead *.md set formatoptions=want

    " Highlight all characters past 80 columns (tweak that number as desired)
    " in dark grey (tweak that color as desired).
    " It's a nice visual cue when auto linewrapping isn't turned on
    " augroup vimrc_autocmds
    "   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
    "   autocmd BufEnter * match OverLength /\%80v.*/
    " augroup END

    " Markdown
    " https://gist.github.com/eZanmoto/4143756
    " autocmd BufNewFile,BufRead *.md set colorcolumn=80
    " autocmd BufNewFile,BufRead *.md set filetype=markdown
    " autocmd BufNewFile,BufRead *.md set spell
    " autocmd BufNewFile,BufRead *.md set textwidth=80
    " " wrap the paragraph the cursor is in
    " autocmd BufNewFile,BufRead nmap gb {jpg}
    " " wrap the highlighted text
    " autocmd BufNewFile,BufRead vmap <CR> gq

    " => Make vim play well with Obsidian
    " https://www.thegadhian.com/posts/using-obsidian-with-termux-and-vim/
    " NGL kinda dookie but its what I have right now - FIND BETTER ALTERNATIVE
    " Set the filetype to markdown for md files, which gives us some syntax highlighting
    " autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    " If I'm in any file in the knoweldge base, set my path to include all
    " subdirectories of that folder. This means that when using gf to "go to file
    " under cursor", or using :find to find a file, we can look at all then notes
    " in any of my subdirectories.
    " autocmd BufRead,BufNewFile $KB_DIRECTORY* setlocal path+=$KB_DIRECTORY/**
    " Add .md to the list of "default" suffixes. When using gf to navigate to a
    " file, VIM will try all theses suffixes as it looks for the file in the path.
    " set suffixesadd+=.md
    " remap `gf` to behave differently for markdown files
    " autocmd! Filetype markdown nnoremap gf vi[gf
augroup END

" Base64 decode word under cursor
" nmap <Leader>b :!echo <C-R><C-W> \| base64 -d<CR>

" exactly like normal J but cursor stays in same postion instead of jumping
" nnoremap J mzJ`z

" https://vi.stackexchange.com/a/34717
" :command StartupAnalyze /VIM STARTING/,$ sort! f /  [^ ]*  /

" https://superuser.com/a/41400
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
