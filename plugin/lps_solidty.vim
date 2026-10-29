if executable('solidity-language-server')
	augroup lsp_solidity
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
				\ 'name': 'solidity-language-server',
				\ 'cmd': {server_info->['solidity-language-server']},
				\ 'whitelist': ['sol'],
				\ })
		autocmd FileType sol setlocal omnifunc=lsp#complete
	augroup end
endif
