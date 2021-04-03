function! rpc#open_preview_page(preview_current_zettel)
    " Check if neuron gen is currently running.
    let l:neuron_gen_command = system('ps -e -o command | grep "[n]euron gen -w\?S"')
    if empty(l:neuron_gen_command)
        echo "Please run 'neuron gen -wS' in order to preview zettels."
        return
    endif

    if has('macunix')
        let l:opener = 'open'
    elseif has('unix')
        let l:opener = 'xdg-open'
    else
        return
    endif

    let l:current_zettel = util#current_zettel()
    let l:extension = l:neuron_gen_command =~ '--pretty-urls' ? '' : '.html'

    if a:preview_current_zettel
        let l:url = 'http://127.0.0.1:8080/' . l:current_zettel . l:extension
    else
        let l:url = 'http://127.0.0.1:8080/impulse' . l:extension
    end
    silent exec ":!" . l:opener . " '" . l:url . "'"
endfunction
