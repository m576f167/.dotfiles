" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"*****************************************************************************
"" Active Plugins
"*****************************************************************************
" Make sure you use single quotes
" Code Completion
Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}

" Snippets
Plug 'https://github.com/honza/vim-snippets.git'

" Debugger
Plug 'https://github.com/puremourning/vimspector.git'

" Directory Structure
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'

" Visual
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/mhinz/vim-signify.git'
Plug 'https://github.com/ryanoasis/vim-devicons.git'

" Searching
Plug 'https://github.com/junegunn/fzf.git', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim.git'

" Syntax
Plug 'https://github.com/sheerun/vim-polyglot.git'

" Tag
Plug 'https://github.com/xolox/vim-easytags.git'
Plug 'https://github.com/xolox/vim-misc.git'
Plug 'https://github.com/majutsushi/tagbar.git'

" Git
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'

" Test runner
Plug 'vim-test/vim-test'

" Miscellanious
Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tomtom/tcomment_vim.git'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/moll/vim-bbye.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/mtth/scratch.vim.git'
Plug 'https://github.com/ervandew/screen.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'https://github.com/voldikss/vim-floaterm.git'
Plug 'https://github.com/szw/vim-maximizer.git'

" Language Specific
Plug 'https://github.com/jalvesaq/Nvim-R.git'
Plug 'https://github.com/daeyun/vim-matlab.git'
Plug 'https://github.com/xuhdev/vim-latex-live-preview.git', {'for' : 'tex'}
Plug 'https://github.com/szymonmaszke/vimpyter.git'
Plug 'https://github.com/chrisbra/csv.vim.git'

"*****************************************************************************
"" Old Unused Plugins
"*****************************************************************************
" Plug 'https://github.com/Valloric/YouCompleteMe.git', { 'do' : './install.py --all' }
" Plug 'https://github.com/SirVer/ultisnips.git'
" Plug 'https://github.com/ervandew/supertab.git'
" Plug 'https://github.com/python-mode/python-mode.git'
" Plug 'https://github.com/pangloss/vim-javascript.git'
" Plug 'https://github.com/endel/vim-github-colorscheme.git'
" Plug 'https://github.com/arialdomartini/oh-my-git.git'
" Plug 'https://github.com/vim-syntastic/syntastic.git'
" Plug 'https://github.com/mileszs/ack.vim.git'
" Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
" Plug 'https://github.com/ConradIrwin/vim-bracketed-paste.git'

" Initialize plugin system
call plug#end()
