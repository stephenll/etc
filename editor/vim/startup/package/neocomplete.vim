" NOTE: This should be called in a context when Vundle is ready to accept new
" plugins.

NeoBundle 'Shougo/neocomplete.vim.git'

" For the life of me, I cannot get neosnippet to play nicely with endwise
" or autopair. Unfortunately, I like thoes plugins much more than I like
" snippets.

" Set up a basic configuration for 'Neocomplete'.
" Copied + modified from 'https://github.com/Shougo/neocomplete.vim'.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_close_preview = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_cursor_hold_i = 1
let g:neocomplete#cursor_hold_i_time = 300

let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries =
    \ {
    \     'default' : '',
    \     'vimshell' : $HOME.'/.vimshell_hist',
    \     'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable omni completion in various filetypes.
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

autocmd VimEnter call neocomplete#initialize()
