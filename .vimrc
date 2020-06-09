"*****************************************************************************
"" Functions
"*****************************************************************************
" Functions for Numbering and RelativeNumbering
function! ToggleNumbersOn()
  set nu!
  set rnu
endfunction
function! ToggleRelativeOn()
  set rnu!
  set nu
endfunction
function! ToggleNuAndRnuOn()
  set nu!
  set rnu!
endfunction
" Function for toggling mouse capability
function! ToggleMouseCap()
  exe 'set mouse='.(empty(&mouse)?'a':'')
endfunction
" Functions for increasing/decreasing tabstop and shiftwidth
function! IncreaseTab()
  exe 'set tabstop+=1'
  exe 'set shiftwidth+=1'
endfunction
function! DecreaseTab()
  exe 'set tabstop-=1'
  exe 'set shiftwidth-=1'
endfunction

"*****************************************************************************
"" Color setting
"*****************************************************************************
" Set vim term if running inside GNU Screen
if match($TERM, "screen")!=-1
  set term=xterm
endif
if match($TERM, "screen-256color")!=-1
  set term=xterm-256color
endif
if match($TERM, "screen-256color-bce")!=-1
  set term=xterm-256color
endif

"*****************************************************************************
"" Vim Configuration
"*****************************************************************************
filetype plugin on                       " Enable checking for filetype plugin
filetype indent on                       " Enable checking for filetype indent
syntax on                                " Enable syntax color
set ttymouse=xterm2                      " Enable mouse resizing when using GNU Screen
set mouse=a                              " Enable mouse
set nu                                   " Display line numbers
set showcmd                              " Show typed commands
set showmatch                            " Show matching brackets
set smartcase                            " Use case if any caps used in searching pattern
set ignorecase                           " Ignore case when searching pattern
set nowrap                               " No breaking line
set whichwrap+=<,>,h,l,[,]               " Wrapping to next or previous lines when moving
set scrollopt+=hor                       " Set horizontal scrolling on
set sidescroll=1                         " Set horizontal scrolling on
set autoindent                           " Turns autoindent on
set smartindent                          " Does the right thing (mostly) in programs
set hidden                               " Enable hidden buffer
set ruler                                " show the cursor position all the time
set laststatus=2                         " Always display the status line
set autoread                             " Reload files changed outside vim
set numberwidth=5                        " Set number width
set backspace=2                          " make backspace work like most other programs
set cursorline                           " highlight the current line
set wildmenu                             " Wild Menu
set wildmode=list:longest,full           " Wildmode
set hlsearch                             " Highlight all search
set incsearch                            " Incremental searching
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
" set splitbelow                        \" Open new split panes to bottom
set splitright                           " Open new split panes to right
set colorcolumn=+1                       " Show color column
set diffopt+=vertical                    " Always use vertical diffs
set shiftwidth=2                         " Width (number of spaces) for shifting indentation left/right
set tabstop=2                            " Number of spaces for a tab
set expandtab                            " Replace tab with spaces
set rnu                                  " Set relative numbering on

"*****************************************************************************
"" Autocommands
"*****************************************************************************
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !
" Toggle relative numbering, and set to absolute on loss of focus or insert mode
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()
" Update dir to current file
" autocmd BufEnter * silent! cd %:p:h

"*****************************************************************************
"" Normal Mappings
"*****************************************************************************
" Map leader key to space
let mapleader = " "
:nnoremap <Space> <nop>
" Map Leader tab j and k to decrease or increase tabstop and shiftwidth
:map <Leader><Tab>j :call DecreaseTab()<Enter>
:map <Leader><Tab>k :call IncreaseTab()<Enter>
" Set fix indentation key
:map <Leader>== gg=G
" Map leader fc to clear search result
:nmap <Leader>fcl :noh<Enter>
" Map to toggle numbering and relative numbering
:map <Leader>`! :call ToggleNuAndRnuOn()<Enter>
" Toggle mouse capability
:map <Leader>`` :call ToggleMouseCap()<Enter>
" Select all
:map <Leader>va ggVG
" Save file
:map <C-s> :w <Enter>
" Move to the upper window
:noremap <C-k> <C-w>k
" Move to the below window
:noremap <C-j> <C-w>j
" Move to the right window
:noremap <C-l> <C-w>l
" Move to the left window
:noremap <C-h> <C-w>h
" Go to next tab
:noremap <F5> :tabn<CR>
" Go to previous tab
:noremap <S-F5> :tabp<CR>
" Show tab list
:noremap <M-F5> :tabs<CR>
" Close tab
:map <F7> :tabclose <Enter>
" Go to previous tag in tag stack
:noremap <S-F6> :tp<Enter>
" Go to next tag in tag stack
:noremap <F6> :tn<Enter>
" Show tag list
:noremap <M-F6> :ts<Enter>
" Safely close (warn for unsaved changes)
:map <F9> :q <Enter>
" Forced close (no warning for unsaved changes)
:map <F10> :q! <Enter>
" Map up, down, left, right for GNU screen
:map ^[[1;5A <S-Up>
:map ^[[1;5B <S-Down>
:map ^[[1;5D <S-Left>
:map ^[[1;5C <S-Right>
" Horizontal scrolling for each mode
:map <C-ScrollWheelUp> 10zh
:map <C-ScrollWheelDown> 10zl
" Map backspace
:nmap <Bs> i<Bs><Esc>l
" Map zZ to simulate horizontal centering
:map zh zezL
:map zH zszH
" Map Home
:map <Home><Home> ^
" Map Shift End and Home to select
:map <S-End> v$
:map <S-Home> v0
:map <S-Home><S-Home> v^
" " Use tab to jump between blocks, because it's easier
" :nnoremap <Tab> %
" " Open file
" :map <C-o> :e . <Enter>
" " Horizontal split
" :map <C-g><C-g> :split <Enter>
" " Vertical split
" :map <C-g><C-v> :vsplit <Enter>
" " Move to the next window 
" :map <C-w> <C-w>w
" " Move to the next tab
" :map mn :tabn <Enter>
" " Indent line(s)
" :map <C-i> >>
" " Normal mode up, down, left, right highlight
" :nmap <S-Up> vk
" :nmap <S-Down> vj
" :nmap <S-Left> vh
" :nmap <S-Right> vl
" " Normal mode up, down, left, right highlight (using i, j, k, l)
" :nmap <S-k> vk
" :nmap <S-j> vj
" :nmap <S-h> vh
" :nmap <S-l> vl
" " Create new file
" :map <C-n> :tabnew <Enter> :enew <Enter>
" " Copy
" :map <C-c> y
" " Paste
" :map <C-v> p
" " Cut
" :map <C-x> d
" " Undo
" :map <C-z> u
" " Search pattern
" :map <C-f> /
" " Search pattern accross files in the current directory
" :noremap <C-f><C-f> :vim  **/* <Bar> cw <left><left><left><left><left><left><left><left><left><left><left>
" " Find and replace
" :map <C-F><C-R> :%s/

"*****************************************************************************
"" Insert Mappings
"*****************************************************************************
" Map Shift tab to insert literal Tab
:inoremap <S-tab> <C-V><Tab>
" Save file
:imap <C-s> <Esc>:w <Enter>i
" Map Home
:imap <Home><Home> ^
" Map Shift End and Home to select
:imap <S-End> <Esc>v$
:imap <S-Home> <Esc>v0
:imap <S-Home><S-Home> v^
" " Open file
" :imap <C-o> <Esc>:e . <Enter>
" " Insert mode up, down, left, right higlight
" :imap <S-Up> <Esc>vk
" :imap <S-Down> <Esc>vj
" :imap <S-Left> <Esc>vh
" :imap <S-Right> <Esc>vl
" " Insert mode up, down, left, right highlight
" :imap <S-I> <Esc>vk
" :imap <S-K> <Esc>vj
" :imap <S-J> <Esc>vh
" :imap <S-L> <Esc>vl
" " Select all
" :imap <C-a> <Esc>GVgg
" " Create new file
" :imap <C-n> <Esc>:tabnew <Enter> :enew <Enter>
" " Copy
" :imap <C-c> <Esc>yi
" " Paste
" :imap <C-v> <Esc>pi
" " Cut
" :imap <C-x> <Esc>di
" " Undo
" :imap <C-z> <Esc>ui
" " Redo
" :imap <C-r> <Esc><C-r>i
" " Search pattern
" :imap <C-f> <Esc>/
" " Search pattern accross files in the current directory
" :imap <C-f><C-f> <Esc>:vim  **/* <Bar> cw <left><left><left><left><left><left><left><left><left><left><left>
" " Map backspace
" :imap <Bs> <Bs>

"*****************************************************************************
"" Visual Mappings
"*****************************************************************************
" Map Shift End and Home to select
:vmap <S-End> $
:vmap <S-Home> 0
:vmap <S-Home><S-Home> ^
" Horizontal scrolling for each mode
:vmap <C-ScrollWheelUp> 10zh
:vmap <C-ScrollWheelDown> 10zl
" " Use tab to jump between blocks, because it's easier
" :vnoremap <tab> %
" " Visual mode up, down, left, right highlight
" :vmap <S-Up> k
" :vmap <S-Down> j
" :vmap <S-Left> h
" :vmap <S-Right> l
" " Visual mode up, down, left, right highlight (using i, j, k, l)
" :vmap <S-k> k
" :vmap <S-j> j
" :vmap <S-h> h
" :vmap <S-l> l
" " Undo
" :vmap <C-z> <Esc>uv
" " Map backspace
" :vmap <Bs> <Del>

"*****************************************************************************
"" Select Mappings
"*****************************************************************************
" Horizontal scrolling for each mode
:smap <C-ScrollWheelUp> 10zh
:smap <C-ScrollWheelDown> 10zl
" " Select mode up, down, left, right highlight
" :smap <S-Up> k
" :smap <S-Down> j
" :smap <S-Left> h
" :smap <S-Right> l
" " Select mode up, down, left, right highlight (using i, j, k, l)
" :smap <S-k> k
" :smap <S-j> j
" :smap <S-h> h
" :smap <S-l> l
" " Map backspace
" :smap <Bs> <Del>

"*****************************************************************************
"" Source vim files
"*****************************************************************************
" Source Vim Plug
so ~/.vim_plug.vim
" Source vim plugin setting
so ~/.vim_plugin_settings.vim
" Source specific machine setting
so ~/.vim_alias.vim
