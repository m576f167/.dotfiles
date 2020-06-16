"*****************************************************************************
"" COC
"*****************************************************************************
"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------
" Function to check if backspace is pressed
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Function to show documentation using either vim help or CocAction doHover
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" " Use C to open coc config
" function! SetupCommandAbbrs(from, to)
"   exec 'cnoreabbrev <expr> '.a:from
"         \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
"         \ .'? ("'.a:to.'") : ("'.a:from.'"))'
" endfunction
"-----------------------------------------------------------------------------
" Vim configurations
"-----------------------------------------------------------------------------
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif
"-----------------------------------------------------------------------------
" Autocommands
"-----------------------------------------------------------------------------
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Correct comment highlighting on JSON
autocmd FileType json syntax match Comment +\/\/.\+$+
"-----------------------------------------------------------------------------
" Commands
"-----------------------------------------------------------------------------
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" " Use C to open coc config
" call SetupCommandAbbrs('C', 'CocConfig')
"-----------------------------------------------------------------------------
" CoC Normal Mappings
"-----------------------------------------------------------------------------
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [gg <Plug>(coc-diagnostic-prev)
nmap <silent> ]gg <Plug>(coc-diagnostic-next)
nmap <silent> [ge <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]ge <Plug>(coc-diagnostic-next-error)
" Remap keys for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> ]r <Plug>(coc-range-select)
nmap <silent> [r <Plug>(coc-range-select-backward)
" GoTo code navigation.
nmap <silent> ga <Plug>(coc-diagnostic-info)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ge <Plug>(coc-declaration)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Formatting selected code.
nmap <leader>p  <Plug>(coc-format-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Code Refactor.
nmap <leader>re <Plug>(coc-refactor)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
nmap <leader>as  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>af  <Plug>(coc-codeaction)
" Remap keys for applying codeAction to the current line.
nmap <leader>al  <Plug>(coc-codeaction-line)
" Remap keys for applying codelens of current line.
nmap <leader>ac  <Plug>(coc-codelens-action)
"-----------------------------------------------------------------------------
" CoC Insert Mappings
"-----------------------------------------------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
"-----------------------------------------------------------------------------
" CoC X Mappings
"-----------------------------------------------------------------------------
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
" Remap keys for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
xmap <silent> ]r <Plug>(coc-range-select)
xmap <silent> [r <Plug>(coc-range-select-backward)
" Formatting selected code.
xmap <leader>p  <Plug>(coc-format-selected)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>as  <Plug>(coc-codeaction-selected)
"-----------------------------------------------------------------------------
" CoC O Mappings
"-----------------------------------------------------------------------------
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
omap ic <Plug>(coc-classobj-i)
omap ac <Plug>(coc-classobj-a)

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
      "\ for Docker
      \ 'coc-docker',
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
      "\ for marketplace
      \ 'coc-marketplace',
      "\ for csharp and visualbasic
      \ 'coc-omnisharp',
      "\ for php, use intelephense-docs
      \ 'coc-phpls',
      "\ for managing project
      \ 'coc-project',
      "\ for r, use R languageserver
      \ 'coc-r-lsp',
      "\ for bash
      \ 'coc-sh',
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
      " \ 'coc-powershell', " for PowerShellEditorService integration
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
" Use <C-l> for both expand and jump (make expand higher priority.)
imap <C-l> <Plug>(coc-snippets-expand-jump)
" Use <C-l> for select text for visual placeholder of snippet.
vmap <C-l> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder
let g:coc_snippet_next = '<C-j>'
" Use <C-k> for jump to previous placeholder
let g:coc_snippet_prev = '<C-k>'
inoremap <silent><expr> <C-l>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<C-l>" :
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
" List all bookmarks.
nnoremap <silent> ,b  :<C-u>CocList bookmark<CR>
" List floating terminals.
nnoremap <silent> ,t  :<C-u>CocList floaterm<CR>
" List marks.
nnoremap <silent> ,m  :<C-u>CocList marks<CR>
" List marketplace.
nnoremap <silent> ,mp  :<C-u>CocList marketplace<CR>
" List command history.
nnoremap <silent> ,h  :<C-u>CocList cmdhistory<CR>
" List Yank history.
nnoremap <silent> ,y  :<C-u>CocList -A --normal yank<cr>
" List projects.
nnoremap <silent> ,p  :<C-u>CocList project<CR>
" List snippets.
nnoremap <silent> ,sn :<C-u>CocList snippets<cr>
" List templates.
nnoremap <silent> ,tmp :<C-u>CocList templates<cr>
" Resume latest coc list.
nnoremap <silent> ,.  :<C-u>CocListResume<CR>
" Do default action for next item.
nnoremap <silent> ,j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> ,k  :<C-u>CocPrev<CR>

"*****************************************************************************
"" NERDTree
"*****************************************************************************
" enable line numbers
let NERDTreeShowLineNumbers=1
" Close vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
" NERDTreeToggle
:nmap <M-F8> :NERDTreeToggle<CR>
" Use <Leader>cd to change cwd to current file being edited
:nnoremap <Leader>cd :cd %:p:h<CR>:NERDTreeCWD<CR>
" " Automatically open NERDTree when open 'vim'
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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
"" Vim Startify
"*****************************************************************************
" Session related keymaps
:nnoremap <Leader>ss :SSave<CR>
:nnoremap <Leader>sl :SLoad<CR>
:nnoremap <Leader>sd :SDelete<CR>
:nnoremap <Leader>sc :SClose<CR>
" Custom Header
let g:ascii_header = [
      \ '   .m.    @@@  @@@@@@ @@@ @@@ @@@@@@@   @@@@@@   @@@@@@   @@@     .m.    ',
      \ '   (;)    @@! !@@     @@! !@@ @@!  @@@ @@!  @@@ @@!  @@@  @@!     (;)    ',
      \ '   (;)    !!@  !@@!!   !@!@!  @!@!!@!  @!@  !@! @!@  !@!  !!@     (;)    ',
      \ '   (;)    !!:     !:!   !!:   !!: :!!  !!:  !!! !!:!!:!:  !!:     (;)    ',
      \ '.  (;)  . :   ::.: :    .:     :   : :  : :. :   : :. ::: :    .  (;)  . ',
      \ '|\_(;)_/|                                                      |\_(;)_/| ',
      \ '          @@@@@@@@  @@@@@@  @@@@@@@ @@@  @@@  @@@@@@  @@@  @@@           ',
      \ '|/ )|( \| @@!      @@!  @@@   @@!   @@!  @@@ @@!  @@@ @@!@!@@@ |/ )|( \| ',
      \ '  ( o )   @!!!:!   @!@!@!@!   @!!   @!@!@!@! @!@!@!@! @!@@!!@!   ( o )   ',
      \ '   )8(    !!:      !!:  !!!   !!:   !!:  !!! !!:  !!! !!:  !!!    )8(    ',
      \ '  ( o )   :        :   : :    :     :   : :  :   : : ::    :     ( o )   ',
      \ '   )8(                     ...                                    )8(    ',
      \ '  ;|S|;                   ;::::;                                 ;|S|;   ',
      \ '  ||S||                 ;::::; :;                                ||S||   ',
      \ "  ||S||               ;:::::'   :;                               ||S||   ",
      \ '  ||S|<              ;:::::;     ;.                              ||S|<   ',
      \ "  ||S||             ,:::::'       ;           OOO\                ||S||   ",
      \ '  ||S||             ::::::;       ;          OOOOO\              ||S||   ',
      \ '  ||S||             ;:::::;       ;         OOOOOOOO             ||S||   ',
      \ "  ||S||            ,;::::::;     ;'         / OOOOOOO            ||S||   ",
      \ '  >|S||          ;:::::::::`. ,,,;.        /  / DOOOOOO          >|S||   ',
      \ "  ||S||        .';:::::::::::::::::;,     /  /     DOOOO         ||S||   ",
      \ '  ||S||       ,::::::;::::::;;;;::::;,   /  /        DOOO        ||S||   ',
      \ "  ||S||      ;`::::::`'::::::;;;::::: ,#/  /          DOOO       ||S||   ",
      \ '  ||S|<      :`:::::::`;::::::;;::: ;::#  /            DOOO      ||S|<   ',
      \ '  ||S||      ::`:::::::`;:::::::: ;::::# /              DOO      ||S||   ',
      \ '  ||S||      `:`:::::::`;:::::: ;::::::#/               DOO      ||S||   ',
      \ '  >|S||       :::`:::::::`;; ;:::::::::##                OO      >|S||   ',
      \ '  ||S||       ::::`:::::::`;::::::::;:::#                OO      ||S||   ',
      \ "  \\\\ //       `:::::`::::::::::::;'`:;::#                O       \\\\ //   ",
      \ "   \\\V/         `:::::`::::::::;' /  / `:#                         \\\V/    ",
      \ "    V           ::::::`:::::;'  /  /   `#                          V     ",
      \ ]
let g:startify_custom_header =
      \ 'startify#center(g:ascii_header + startify#fortune#boxed())'
let g:ascii_footer = [
      \ "#########=====___========___============================================================___========___====#########",
      \ "#########  __(   )    __(   )      __________       __________        __________     __(   )    __(   )   #########",
      \ "##':v:`## (_______)  (_______)   ,'   Vim    |     |    Is    |      | Awesome  `.  (_______)  (_______)  ##':v:`##",
      \ "##(o:0)##     ___        ___     `.__________|     |__________|      |__________,'      ___        ___    ##(o:0)##",
      \ "###(:)###  __(   )    __(   )   -------||-----     -----||-----      -----||-------  __(   )    __(   )   ###(:)###",
      \ '######### (_______)  (_______)         n        #                 #                 (_______)  (_______)  #########',
      \ '##/\:/\##     \/         /\       ____/_\____   #=ooO=========Ooo=#     \-^-/           \/         /\     ##/\:/\##',
      \ '#/(o:o)\# v             /  \/\       (z z)      #  \\  (o o)  //  #     (o o)       v             /  \/\  #/(o:o)\#',
      \ '###(:)###    v       /`/   /  \  ooO--(_)--Ooo- --------(_)-------- ooO--(_)--Ooo-     v       /`/   /  \ ###(:)###',
      \ '#########=================================================================================================#########',
      \ ]
let g:startify_custom_footer = 'startify#center(g:ascii_footer)'

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
"" Vim Fzf
"*****************************************************************************
" FZF Color setting to match the color scheme
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction
augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END
" Add AG, which restarts Ag everytime
function! AgFzf(query, fullscreen)
  let command_fmt = 'ag --column --numbers --color --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang AG call AgFzf(<q-args>, <bang>0)
" Add RG, which restarts ripgrep everytime
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" ag search result (ALT-A to select all, ALT-D to deselect all)
:map <Leader>fa :AG<CR>
" ag search result (ALT-A to select all, ALT-D to deselect all)
:map <Leader>fA :Ag<CR>
" rg search result (ALT-A to select all, ALT-D to deselect all)
:map <Leader>fr :RG<CR>
" rg search result (ALT-A to select all, ALT-D to deselect all)
:map <Leader>fR :Rg<CR>
" Open buffers
:map <Leader>fb :Buffers<CR>
" locate command output
:map <Leader>fo :Locate<CR>
" Snippets (UltiSnips)
:map <Leader>fs :Snippets<CR>
" Windows
:map <Leader>fw :Windows<CR>
" Files (runs $FZF_DEFAULT_COMMAND if defined)
:map <Leader>ffn :Files<CR>
" File types
:map <Leader>fft :Filetypes<CR>
" Lines in loaded buffers
:map <Leader>fll :Lines<CR>
" Lines in the current buffer
:map <Leader>flb :BLines<CR>
" v:oldfiles and open buffers
:map <Leader>fhh :History<CR>
" Command history
:map <Leader>fhc :History:<CR>
" Search history
:map <Leader>fhs :History/<CR>
" Git files (git ls-files)
:map <Leader>fgf :GFiles<CR>
" Git files (git status)
:map <Leader>fgs :GFiles?<CR>
" Git commits (requires fugitive.vim)
:map <Leader>fgc :Commits<CR>
" Git commits for the current buffer
:map <Leader>fgb :BCommits<CR>
" Tags in the project (ctags -R)
:map <Leader>ftp :Tags<CR>
" Tags in the current buffer
:map <Leader>ftb :BTags<CR>
" Help tags 1
:map <Leader>fth :Helptags<CR>
" Commands
:map <Leader>fcm :Commands<CR>
" Color schemes
:map <Leader>fcs :Colors<CR>
" Marks
:map <Leader>fmk :Marks<CR>
" Normal mode mappings
:map <Leader>fmp :Maps<CR>

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
:map <Leader>=<Tab> :Tab/

"*****************************************************************************
"" Scratch
"*****************************************************************************
" :map <Tab>q :Scratch<CR>i

"*****************************************************************************
"" Screen
"*****************************************************************************
let g:ScreenImpl='GnuScreen'

"*****************************************************************************
"" Vim Wiki
"*****************************************************************************
:nmap <Leader>wk <Plug>VimwikiPrevLink
:nmap <Leader>wj <Plug>VimwikiNextLink

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
"
"*****************************************************************************
"" Ack
"*****************************************************************************
" if executable('ag')
" 	let g:ackprg = 'ag --vimgrep'
" endif
