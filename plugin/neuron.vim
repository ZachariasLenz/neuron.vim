if exists("g:_neuron_loaded")
    finish
endif
let g:_neuron_loaded = 1

let g:neuron_backlinks_size = get(g:, 'neuron_backlinks_size', 40)
let g:neuron_backlinks_vsplit = get(g:, 'neuron_backlinks_vsplit', 1)
let g:neuron_backlinks_vsplit_right = get(g:, 'neuron_backlinks_vsplit_right', 1)
let g:neuron_daemon_cmd = get(g:, 'neuron_daemon_cmd', 'neuron gen -wS --pretty-urls')
let g:neuron_daemon_run = get(g:, 'neuron_daemon_run', 1)
let g:neuron_debug_enable = get(g:, 'neuron_debug_enable', 0)
let g:neuron_dirs_to_check = get(g:, 'neuron_dirs_to_check', ['notes', 'zettels'])
let g:neuron_executable = get(g:, 'neuron_executable', system('which neuron | tr -d "\n"'))
let g:neuron_extension = get(g:, 'neuron_extension', '.md')
let g:neuron_fullscreen_search = get(g:, 'neuron_fullscreen_search', 0)
let g:neuron_fzf_options = get(g:, 'neuron_fzf_options', ['-d',':','--with-nth','2'])
let g:neuron_inline_backlinks = get(g:, 'neuron_inline_backlinks', 1)
let g:neuron_no_mappings = get(g:, 'neuron_no_mappings', 0)
let g:neuron_search_backend = get(g:, 'neuron_search_backend', 'ag')
let g:neuron_tags_name = get(g:, 'neuron_tags_name', 'tags')
let g:neuron_tags_style = get(g:, 'neuron_tags_style', 'multiline')
let g:neuron_tmp_filename = get(g:, 'neuron_tmp_filename', '/tmp/neuronzettelsbuffer')

" Make sure we have a valid search backend.
if index(['ag', 'rg'], g:neuron_search_backend) < 0
    echo "Invalid search backend '" . g:neuron_search_backend . "' specified, defaulting to 'ag'."
    let g:neuron_search_backend = 'ag'
endif

" Set the neuron directories.
let g:neuron_dir = neuron#get_neuron_dir()
let g:neuron_dir_zettels = neuron#get_zettels_dir()

nmap <silent> <Plug>NeuronAddTagNew :<C-U>call neuron#tags_add_new()<CR>
nmap <silent> <Plug>NeuronAddTagSearch :<C-U>call neuron#tags_add_select()<CR>
nmap <silent> <Plug>NeuronEditZettelPrevious :<C-U>call neuron#edit_zettel_last()<CR>
nmap <silent> <Plug>NeuronEditZettelUnderCursor :<C-U>call neuron#edit_zettel_under_cursor()<CR>
nmap <silent> <Plug>NeuronHistoryNext :<C-U>call neuron#move_history(-1)<cr>
nmap <silent> <Plug>NeuronHistoryPrevious :<C-U>call neuron#move_history(1)<cr>
nmap <silent> <Plug>NeuronInsertFolgezettelSearch :<C-U>call neuron#insert_zettel_select(1)<cr>
nmap <silent> <Plug>NeuronInsertFolgezettelPrevious :<C-U>call neuron#insert_zettel_last(1)<cr>
nmap <silent> <Plug>NeuronInsertLinkSearch :<C-U>call neuron#insert_zettel_select(0)<CR>
nmap <silent> <Plug>NeuronInsertLinkPrevious :<C-U>call neuron#insert_zettel_last(0)<CR>
nmap <silent> <Plug>NeuronNewFolgezettel :<C-U>call neuron#edit_zettel_new('', 1)<CR>
nmap <silent> <Plug>NeuronNewFolgezettelFromCword :<C-U>call neuron#edit_zettel_new_from_cword()<CR>
nmap <silent> <Plug>NeuronNewFolgezettelFromVisual :<C-U>call neuron#edit_zettel_new_from_visual()<CR>
nmap <silent> <Plug>NeuronNewZettel :<C-U>call neuron#edit_zettel_new('', 0)<CR>
nmap <silent> <Plug>NeuronPreviewZettel :<C-U>call rpc#open_preview_page(1)<CR>
nmap <silent> <Plug>NeuronRefreshCache :<C-U>call neuron#refresh_cache(1)<CR>
nmap <silent> <Plug>NeuronSearchBacklinks :<C-U>call neuron#edit_zettel_backlink()<CR>
nmap <silent> <Plug>NeuronSearchByTag :<C-U>call neuron#tags_search()<CR>
nmap <silent> <Plug>NeuronSearchContent :<C-U>call neuron#search_content(0)<CR>
nmap <silent> <Plug>NeuronSearchContentUnderCursor :<C-U>call neuron#search_content(1)<CR>
nmap <silent> <Plug>NeuronSearchTitles :<C-U>call neuron#edit_zettel_select()<CR>
nmap <silent> <Plug>NeuronToggleBacklinks :<C-U>call neuron#toggle_backlinks()<CR>


if !exists("g:neuron_no_mappings") || ! g:neuron_no_mappings
    nmap <leader>zT <Plug>NeuronAddTagNew
    nmap <leader>zt <Plug>NeuronAddTagSearch
    nmap <leader>zE <Plug>NeuronEditZettelPrevious
    nmap <leader>ze <Plug>NeuronEditZettelUnderCursor
    nmap <leader>z] <Plug>NeuronHistoryNext
    nmap <leader>z[ <Plug>NeuronHistoryPrevious
    nmap <leader>zi <Plug>NeuronInsertFolgezettelSearch
    nmap <leader>zI <Plug>NeuronInsertFolgezettelPrevious
    nmap <leader>zl <Plug>NeuronInsertLinkSearch
    nmap <leader>zL <Plug>NeuronInsertLinkPrevious
    nmap <leader>zf <Plug>NeuronNewFolgezettel
    vmap <leader>zf <ESC><Plug>NeuronNewFolgezettelFromVisual
    nmap <leader>zz <Plug>NeuronNewZettel
    nmap <leader>zp <Plug>NeuronPreviewZettel
    nmap <leader>zr <Plug>NeuronRefreshCache
    nmap <leader>zb <Plug>NeuronSearchBacklinks
    nmap <leader>zS <Plug>NeuronSearchByTag
    nmap <leader>zc <Plug>NeuronSearchContent
    nmap <leader>zC <Plug>NeuronSearchContentUnderCursor
    nmap <leader>zs <Plug>NeuronSearchTitles
    nmap <leader>zB <Plug>NeuronToggleBacklinks
    inoremap <expr> <c-x><c-u> neuron#insert_zettel_complete(0)
    inoremap <expr> <c-x><c-y> neuron#insert_zettel_complete(1)
end

" : vim: set fdm=marker :
