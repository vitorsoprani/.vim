filetype plugin indent on

syntax on
colorscheme retrobox

set number
set relativenumber
set colorcolumn=80
set cursorline

set mouse=a
set scrolloff=16
set splitright
set splitbelow

set formatoptions+=ro
setlocal autoindent

let python_highlight_all=1

"https://vim.fandom.com/wiki/Highlight_unwanted_spaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
