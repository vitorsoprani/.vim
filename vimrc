setlocal formatoptions+=r
setlocal formatoptions+=o

set noexpandtab		" Default
set tabstop=8
set shiftwidth=8	" Use value of tabstop
set softtabstop=8	" Default
set smarttab		" Optional
set smartindent

set number
set relativenumber
set colorcolumn=80
set cursorline

"https://vim.fandom.com/wiki/Highlight_unwanted_spaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set mouse=a
set scrolloff=16
set splitright
set splitbelow

let python_highlight_all=1
syntax on
colorscheme retrobox

" Atalho para disparar o autocomplete do LSP manualmente com Ctrl+Espaço
inoremap <expr> <C-Space> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"
inoremap <expr> <C-@> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"

let g:lsp_format_sync_timeout=1000
let g:lsp_semantic_enabled=1
let g:lsp_semantic_delay=100

" Mapeamento de Tokens Semânticos do LSP para grupos de sintaxe do Vim
highlight default link LspSemanticClass Type
highlight default link LspSemanticMethod Function
highlight default link LspSemanticFunction Function
highlight default link LspSemanticVariable Identifier
highlight default link LspSemanticParameter Identifier
highlight default link LspSemanticProperty Identifier
highlight default link LspSemanticDecorator PreProc
highlight default link LspSemanticKeyword Keyword
highlight default link LspSemanticString String
highlight default link LspSemanticNumber Number
highlight default link LspSemanticComment Comment

" npm install -g basedpyright
if executable('basedpyright-langserver')
	augroup lsp_basedpyright
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'basedpyright',
			\ 'cmd': {server_info->['basedpyright-langserver', '--stdio']},
			\ 'allowlist': ['python'],
			\ 'workspace_config': {
			\   'python': {
			\	 'analysis': {
			\	   'typeCheckingMode': 'basic'
			\	 }
			\   }
			\ },
			\ })
		autocmd FileType python setlocal omnifunc=lsp#complete
	augroup end
endif

if executable('clangd')
	augroup lsp_clangd
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
				\ 'name': 'clangd',
				\ 'cmd': {server_info->['clangd']},
				\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
				\ })
		autocmd FileType c setlocal omnifunc=lsp#complete
		autocmd FileType cpp setlocal omnifunc=lsp#complete
		autocmd FileType objc setlocal omnifunc=lsp#complete
		autocmd FileType objcpp setlocal omnifunc=lsp#complete
	augroup end
endif

function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gs <plug>(lsp-document-symbol-search)
	nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> gi <plug>(lsp-implementation)
	nmap <buffer> gt <plug>(lsp-type-definition)
	nmap <buffer> <leader>rn <plug>(lsp-rename)
	nmap <buffer> [g <plug>(lsp-previous-diagnostic)
	nmap <buffer> ]g <plug>(lsp-next-diagnostic)
	nmap <buffer> K <plug>(lsp-hover)
	nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
	nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

	autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
	" refer to doc to add more commands
endfunction

augroup lsp_install
	au!
	" call s:on_lsp_buffer_enabled only for languages that has the server registered.
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

