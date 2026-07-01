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
			\     'analysis': {
			\       'typeCheckingMode': 'basic',
			\       'diagnosticMode': 'openFilesOnly'
			\     }
			\   }
			\ },
			\ })
		autocmd FileType python setlocal omnifunc=lsp#complete
	augroup end
endif
