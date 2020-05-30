" Vim python mode
let g:pymode_folding = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0

" Vim Javascript plugin
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" NERDTree plugin
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Automatically open NERDTree when open 'vim'
" Close vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTreeToggle
:nmap <M-F8> :NERDTreeToggle<CR>
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" Colors Solarized
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

" Github Colorscheme
"colorscheme github

" Vim Airline
" Show Smarter Tab Line => Automatically display all buffers when there is
" only one tab open
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

" Vim Airline Themes
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" Tagbar
:nmap <F8> :TagbarToggle<CR>

" TComment
:map <C-_> :TComment<CR>

" Scratch
:map <Tab>q :Scratch<CR>i

" Go to next and previous buffer
:noremap <F3> :bn<Enter>
:noremap <F2> :bp<Enter>
:noremap <F4> :ls<Enter>
" Close buffer
:noremap <S-F7> :Bdelete<Enter>

" YouCompleteMe
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
"
" " Make YCM compatible with UltiSnips (using supertab)
" let g:SuperTabDefaultCompletionType = '<C-Space>'
" let g:ycm_key_list_accept_completion = ['<Enter>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" " Additional YouCompleteMe config.
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"

" Tabular
:map <Leader>^ :Tab/

" Vim Screen
let g:ScreenImpl='GnuScreen'

" Vim R
let g:R_assign=0

" Vim ack
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

" Easy tags
let g:easytags_async = 1
let g:easytags_autorecurse = 0
function SwitchEasyTagsAutorecurse()
	let g:easytags_autorecurse += 1
	let g:easytags_autorecurse = g:easytags_autorecurse % 2
endfunction
:nmap <Leader>ctr :call SwitchEasyTagsAutorecurse()<Enter>
:nmap <Leader>ctu :UpdateTags<Enter>

" Vim Signify
:hi CursorLineNr cterm=none
:hi CursorLineNr ctermbg=235
:hi SignColumn ctermbg=235

" Vim-devicon settings
set encoding=UTF-8
" Create a dictionary of the colors for later use
let g:sol = {
    \"gui": {
        \"base03": "#002b36",
        \"base02": "#073642",
        \"base01": "#586e75",
        \"base00": "#657b83",
        \"base0": "#839496",
        \"base1": "#93a1a1",
        \"base2": "#eee8d5",
        \"base3": "#fdf6e3",
        \"yellow": "#b58900",
        \"orange": "#cb4b16",
        \"red": "#dc322f",
        \"magenta": "#d33682",
        \"violet": "#6c71c4",
        \"blue": "#268bd2",
        \"cyan": "#2aa198",
        \"green": "#719e07"
    \},
    \"cterm": {
        \"base03": 8,
        \"base02": 0,
        \"base01": 10,
        \"base00": 11,
        \"base0": 12,
        \"base1": 14,
        \"base2": 7,
        \"base3": 15,
        \"yellow": 3,
        \"orange": 9,
        \"red": 1,
        \"magenta": 5,
        \"violet": 13,
        \"blue": 4,
        \"cyan": 6,
        \"green": 2
    \}
\}
function! DeviconsColors(config)
    let colors = keys(a:config)
    augroup devicons_colors
        autocmd!
        for color in colors
            if color == 'normal'
                exec 'autocmd FileType nerdtree,startify if &background == ''dark'' | '.
                    \ 'highlight devicons_'.color.' guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
                    \ 'else | '.
                    \ 'highlight devicons_'.color.' guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
                    \ 'endif'
            elseif color == 'emphasize'
                exec 'autocmd FileType nerdtree,startify if &background == ''dark'' | '.
                    \ 'highlight devicons_'.color.' guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
                    \ 'else | '.
                    \ 'highlight devicons_'.color.' guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
                    \ 'endif'
            else
                exec 'autocmd FileType nerdtree,startify highlight devicons_'.color.' guifg='.g:sol.gui[color].' ctermfg='.g:sol.cterm[color]
            endif
            exec 'autocmd FileType nerdtree,startify syntax match devicons_'.color.' /\v'.join(a:config[color], '|').'/ containedin=ALL'
        endfor
    augroup END
endfunction
let g:devicons_colors = {
    \'normal': ['', '', '', '', ''],
    \'emphasize': ['', '', '', '', '', '', '', '', '', '', ''],
    \'yellow': ['', '', ''],
    \'orange': ['', '', '', 'λ', '', ''],
    \'red': ['', '', '', '', '', '', '', '', ''],
    \'magenta': [''],
    \'violet': ['', '', '', ''],
    \'blue': ['', '', '', '', '', '', '', '', '', '', '', '', ''],
    \'cyan': ['', '', '', ''],
    \'green': ['', '', '', '']
\}
call DeviconsColors(g:devicons_colors)
