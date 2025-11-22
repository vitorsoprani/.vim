set shiftwidth=8
set tabstop=8
set autoindent
set smartindent

set number
set relativenumber
set colorcolumn=80
set cursorline

colorscheme habamax
syntax on

"https://vim.fandom.com/wiki/Highlight_unwanted_spaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+\%#\@<!$/

set scrolloff=15
