
" Vim Javascript plugin 
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" NERDTree plugin
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Automatically open NERDTree when open 'vim'
" Close vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
:noremap <CR> :bn<Enter>
:noremap <Leader><CR> :bp<Enter>
" Close buffer
:noremap <Space> :Bdelete<Enter>

" YouCompleteMe
let g:ycm_server_python_interpreter = '/usr/bin/python'
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

