let g:neuron_dir = neuron#get_neuron_dir()
let g:neuron_dir_zettels = neuron#get_zettels_dir()

" If there is no neuron.dhall file in current dir then it is not a
" Zettelkasten and if b:did_ftplugin exists then we already created the
" autocommands and started the neuron daemon.
if !filereadable(g:neuron_dir . "neuron.dhall") || exists('b:did_ftplugin')
    finish
endif

aug neuron
    exec ':au! BufEnter ' . fnameescape(g:neuron_dir) . '*' . fnameescape(g:neuron_extension) . ' call neuron#on_enter()'
    exec ':au! BufLeave ' . fnameescape(g:neuron_dir) . '*' . fnameescape(g:neuron_extension) . ' call neuron#clear_zettel_title_float_win()'
    exec ':au! BufRead ' . fnameescape(g:neuron_dir) . '*' . fnameescape(g:neuron_extension) . ' call neuron#add_virtual_titles()'
    exec ':au! BufWrite ' . fnameescape(g:neuron_dir) . '*' . fnameescape(g:neuron_extension) . ' call neuron#on_write()'
    exec ':au! CursorMoved ' . fnameescape(g:neuron_dir) . '*' . fnameescape(g:neuron_extension) . ' call neuron#on_cursor_move()'
    exec ':au! VimLeave if exists(g:_neuron_daemon_pid) | call jobstop(g:_neuron_daemon_pid) | endif'
aug END

if g:neuron_daemon_run
    let g:_neuron_daemon_pid = jobstart(g:neuron_daemon_cmd)
endif

let b:did_ftplugin = 1
