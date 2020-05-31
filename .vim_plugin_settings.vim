"*****************************************************************************
"" COC
"*****************************************************************************
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-V><Tab>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
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
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <leader>s <Plug>(coc-range-select)
xmap <silent> <leader>s <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Correct comment highlighting on JSON
autocmd FileType json syntax match Comment +\/\/.\+$+
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

"*****************************************************************************
"" CoC Extensions
"*****************************************************************************
let g:coc_global_extensions = [
      "\ bookmark extension
      \ 'coc-bookmark',
      "\ for CloudFormation Linter, cfn-python-lint
      \ 'coc-cfn-lint',
      "\ for C/C++/Objective-C, use clangd
      \ 'coc-clangd',
      "\ for cmake code completion
      \ 'coc-cmake',
      "\ for css, scss and less.
      \ 'coc-css',
      "\ css modules intellisense.
      \ 'coc-cssmodules',
      "\ Eslint extension for coc.nvim
      \ 'coc-eslint',
      "\ for vim-floaterm integration
      \ 'coc-floaterm',
      "\ for go, use gopls
      \ 'coc-go',
      "\ for html, handlebars and razor
      \ 'coc-html',
      "\ for java, use eclipse.jdt.ls
      \ 'coc-java',
      "\ for python, use jedi-language-server
      \ 'coc-jedi',
      "\ for json
      \ 'coc-json',
      "\ provides some basic lists like fzf.vim
      \ 'coc-lists',
      "\ for markdown linting
      \ 'coc-markdownlint',
      "\ for csharp and visualbasic
      \ 'coc-omnisharp',
      "\ for php, use intelephense-docs
      \ 'coc-phpls',
      "\ for PowerShellEditorService integration
      \ 'coc-powershell',
      "\ for r, use R languageserver
      \ 'coc-r-lsp',
      "\ provides snippets solution
      \ 'coc-snippets',
      "\ for ruby, use solargraph
      \ 'coc-solargraph',
      "\ templates extension for file types
      \ 'coc-template',
      "\ for LaTex using TexLab
      \ 'coc-texlab',
      "\ for javascript and typescript
      \ 'coc-tsserver',
      "\ for viml
      \ 'coc-vimlsp',
      "\ for xml, use lsp4xml
      \ 'coc-xml',
      "\ for yaml
      \ 'coc-yaml',
      "\ provides yank highlights & history
      \ 'coc-yank',
      \ ]
      " \ 'coc-actions', " Actions menu for Neovim
      " \ 'coc-angular', " for angular.
      " \ 'coc-browser', " for browser words completion
      " \ 'coc-calc', " expression calculation extension
      " \ 'coc-discord', " discord rich presence for coc.nvim
      " \ 'coc-ecdict', " ECDICT extension
      " \ 'coc-elixir', " for elixir, based on elixir-ls.
      " \ 'coc-ember', " for ember projects.
      " \ 'coc-emmet', " provides emmet suggestions in completion list.
      " \ 'coc-erlang_ls', " for erlang, based on erlang_ls
      " \ 'coc-explorer', " file explorer extension
      " \ 'coc-flow', " for flow
      " \ 'coc-flutter', " for flutter
      " \ 'coc-fsharp', " for fsharp.
      " \ 'coc-git', " provides git integration.
      " \ 'coc-highlight', " provides default document symbol highlighting and color support
      " \ 'coc-lsp-wl', " for wolfram mathematica, fork of vscode-lsp-wl.
      " \ 'coc-metals', " for Scala using Metals
      " \ 'coc-pyright', " Pyright extension
      " \ 'coc-python', " for python, extension forked from vscode-python.
      " \ 'coc-reason', " for reasonml
      " \ 'coc-rls', " for rust, use Rust Language Server
      " \ 'coc-rust-analyzer', " for rust, use rust-analyzer
      " \ 'coc-sourcekit', " for Swift
      " \ 'coc-spell-checker', " A basic spell checker that works well with camelCase code
      " \ 'coc-svelte', " for svelte
      " \ 'coc-svg', " for svg.
      " \ 'coc-tabnine', " for tabnine.
      " \ 'coc-tailwindcss', " for tailwindcss.
      " \ 'coc-tasks', " for asynctasks.vim integration
      " \ 'coc-todolist', " for handy todolist/task management
      " \ 'coc-translator', " language transaction extension
      " \ 'coc-vetur', " for vue, use vetur.

"*****************************************************************************
"" CoC Extensions Settings
"*****************************************************************************
" ======================== coc-bookmark ======================================
nmap <Leader>ba <Plug>(coc-bookmark-annotate)
nmap <Leader>bt <Plug>(coc-bookmark-toggle)
nmap <Leader>bj <Plug>(coc-bookmark-next)
nmap <Leader>bk <Plug>(coc-bookmark-prev)

" ======================== coc-snippets ======================================
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-l> for jump to next placeholder
let g:coc_snippet_next = '<C-l>'
" Use <C-h> for jump to previous placeholder
let g:coc_snippet_prev = '<C-h>'
inoremap <silent><expr> <C-j>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<C-j>" :
      \ coc#refresh()

" ======================== CocList ===========================================
" Show all diagnostics.
nnoremap <silent> ,a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> ,e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> ,c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> ,o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> ,s  :<C-u>CocList -I symbols<cr>
" LIst all bookmarks.
nnoremap <silent> ,b  :<C-u>CocList bookmark<CR>
" LIst floating terminals.
nnoremap <silent> ,t  :<C-u>CocList floaterm<CR>
" LIst marks.
nnoremap <silent> ,m  :<C-u>CocList marks<CR>
" List Yank history.
nnoremap <silent> ,y  :<C-u>CocList -A --normal yank<cr>
" List snippets.
nnoremap <silent> ,sn :<C-u>CocList snippets<cr>
" List templates.
nnoremap <silent> ,tmp :<C-u>CocList templates<cr>
" Resume latest coc list.
nnoremap <silent> ,p  :<C-u>CocListResume<CR>
" Do default action for next item.
nnoremap <silent> ,j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> ,k  :<C-u>CocPrev<CR>

"*****************************************************************************
"" NERDTree
"*****************************************************************************
autocmd StdinReadPre * let s:std_in=1
" Automatically open NERDTree when open 'vim'
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTreeToggle
:nmap <M-F8> :NERDTreeToggle<CR>
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

"*****************************************************************************
"" Vim Airline
"*****************************************************************************
" Show Smarter Tab Line => Automatically display all buffers when there is
" only one tab open
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

"*****************************************************************************
"" Vim Airline Themes
"*****************************************************************************
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

"*****************************************************************************
"" Vim Colors Solarized
"*****************************************************************************
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

"*****************************************************************************
"" Vim Signify
"*****************************************************************************
:hi CursorLineNr cterm=none
:hi CursorLineNr ctermbg=235
:hi SignColumn ctermbg=235

"*****************************************************************************
"" Vim Devicons
"*****************************************************************************
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

"*****************************************************************************
"" Ack
"*****************************************************************************
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

"*****************************************************************************
"" Vim Easytags
"*****************************************************************************
let g:easytags_async = 1
let g:easytags_autorecurse = 0
function SwitchEasyTagsAutorecurse()
	let g:easytags_autorecurse += 1
	let g:easytags_autorecurse = g:easytags_autorecurse % 2
endfunction
:nmap <Leader>ctr :call SwitchEasyTagsAutorecurse()<Enter>
:nmap <Leader>ctu :UpdateTags<Enter>

"*****************************************************************************
"" Tagbar
"*****************************************************************************
:nmap <F8> :TagbarToggle<CR>

"*****************************************************************************
"" TComment
"*****************************************************************************
:map <C-_> :TComment<CR>

"*****************************************************************************
"" Vim BBye
"*****************************************************************************
" Go to next and previous buffer
:noremap <F3> :bn<Enter>
:noremap <F2> :bp<Enter>
:noremap <F4> :ls<Enter>
" Close buffer
:noremap <S-F7> :Bdelete<Enter>

"*****************************************************************************
"" Tabular
"*****************************************************************************
:map <Leader>^ :Tab/

"*****************************************************************************
"" Scratch
"*****************************************************************************
:map <Tab>q :Scratch<CR>i

"*****************************************************************************
"" Screen
"*****************************************************************************
let g:ScreenImpl='GnuScreen'

"*****************************************************************************
"" Vim Floaterm
"*****************************************************************************
" To Scrol window in terminal, press <C-w>N to switch to normal terminal mode
let g:floaterm_keymap_new    =  '<leader><F1>'
let g:floaterm_keymap_prev   =  '<leader><F2>'
let g:floaterm_keymap_next   =  '<leader><F3>'
let g:floaterm_keymap_toggle =  '<leader><F4>'
let g:floaterm_keymap_kill   =  '<leader><F7>'
:map <Leader>ts :FloatermSend<CR>
:vmap <Leader>ts :FloatermSend<CR>

"*****************************************************************************
"" Nvim R
"*****************************************************************************
let g:R_assign=0

" "*****************************************************************************
" "" YouCompleteMe
" "*****************************************************************************
" let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
" "
" " " Make YCM compatible with UltiSnips (using supertab)
" " let g:SuperTabDefaultCompletionType = '<C-Space>'
" " let g:ycm_key_list_accept_completion = ['<Enter>']
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'
" " " Additional YouCompleteMe config.
" let g:ycm_complete_in_comments = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_seed_identifiers_with_syntax = 1

" "*****************************************************************************
" "" UltiSnips
" "*****************************************************************************
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" let g:UltiSnipsEditSplit="vertical"

" "*****************************************************************************
" "" Python Mode
" "*****************************************************************************
" let g:pymode_folding = 0
" let g:pymode_rope_lookup_project = 0
" let g:pymode_rope_complete_on_dot = 0

" "*****************************************************************************
" "" Vim Javascript
" "*****************************************************************************
" let g:javascript_plugin_jsdoc = 1
" let g:javascript_plugin_ngdoc = 1
" let g:javascript_plugin_flow = 1

"*****************************************************************************
"" Vim Github Colorscheme
"*****************************************************************************
"colorscheme github
