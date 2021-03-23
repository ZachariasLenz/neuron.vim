# neuron.vim

Manage your [Zettelkasten](https://neuron.zettel.page/2011401.html) with the
help of [neuron](https://github.com/srid/neuron) in {n}vim. This is a fork of
that supports Neuron's V2 format.

![usage-photo](screenshot.png)

## Requirements

- [neuron](https://github.com/srid/neuron)
- [fzf](https://github.com/junegunn/fzf.vim)
- [ag](https://github.com/mizuno-as/silversearcher-ag) or
  [rg](https://github.com/BurntSushi/ripgrep) if you intend to use the content
  search command.

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'junegunn/fzf.vim'
Plug 'ZachariasLenz/neuron.vim'
```

## Usage

Open a zettel with `vim` or `nvim`. In `nvim` it will:

- show a virtual floating text on the first line indicating how many backlinks
  the current zettel has;
- show a virtual title for each linked zettel in the body.

The following `<Plug>` mappings are available:

```
<Plug>NeuronAddTagNew                   Tag the current zettel with a newly
                                        created tag.

<Plug>NeuronAddTagSearch                Search for an already existing tag and
                                        tag the current zettel with it.

<Plug>NeuronEditZettelPrevious          Open the previously visited zettel in
                                        a new buffer.

<Plug>NeuronEditZettelUnderCursor       Open the zettel under the cursor in a
                                        new buffer.

<Plug>NeuronHistoryNext                 Open the next zettel in the visit
                                        history.

<Plug>NeuronHistoryPrevious             Open the previous zettel in the visit
                                        history.

<Plug>NeuronInsertFolgezettelSearch     Search for a zettel by title and
                                        insert a folgezettel link to it in the
                                        current one.

<Plug>NeuronInsertFolgezettelPrevious   Insert a folgezettel link to the
                                        previously visited zettel in the
                                        current one.

<Plug>NeuronInsertLinkSearch            Search for a zettel by title and
                                        insert a link to it in the current one.

<Plug>NeuronInsertLinkPrevious          Insert a link to the previously
                                        visited zettel in the current one.

<Plug>NeuronNewFolgezettel              Create a new zettel and insert it as
                                        a folgezettel in the current one.

<Plug>NeuronNewFolgezettelFromCword     Create a new zettel and insert it as
                                        a folgezettel in the current one,
                                        using the word under the cursor as
                                        its title.

<Plug>NeuronNewFolgezettelFromVisual    Create a new zettel and insert it as a
                                        folgezettel in the current one, using
                                        the visual selection as its title.

<Plug>NeuronNewZettel                   Create a new zettel.

<Plug>NeuronPreviewZettel               Open the compiled HTML of the current
                                        zettel. This requires that neuron
                                        daemon (i.e. the command
                                        'neuron gen -S') is running.

<Plug>NeuronRefreshCache                Refresh neuron's cache.

<Plug>NeuronSearchBacklinks             Search for zettels by title which link
                                        to the current one.

<Plug>NeuronSearchByTag                 Search for zettels by title with a
                                        given tag.

<Plug>NeuronSearchContent               Search through the content of all
                                        zettels.

<Plug>NeuronSearchContentUnderCursor    Search through the content of all
                                        zettel for the word under the cursor.

<Plug>NeuronSearchTitles                Search for zettels by title.

<Plug>NeuronToggleBacklinks             Toggle the display of the number of
                                        backlines.
```

The following default mappings are set if `g:neuron_no_mappings` is 0:

```vim
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
```

## Customization

- `neuron.vim` uses a custom function to generate IDs for new zettels that it
  creates, bypassing `neuron new` completely. By default it generates a random
  hex string of 8 characters. You can hook into the process by defining a
  function `g:CustomNeuronIDGenerator` in your `.vimrc` that takes an optional
  `title` argument. For example:

  To make it use the title as kebab-cased ID:

```
func! g:CustomNeuronIDGenerator(title) return substitute(a:title, " ", "-", "g") endf
```

If `g:CustomNeuronIDGenerator` is not defined in your `.vimrc` or returns an
empty string, `neuron.vim` will fall back to generating random IDs.

The following configuration options are available:

```
g:CustomNeuronIDGenerator   Hook function to define your own strategy for
                            generating the IDs of new Zettel notes. Accepts a
                            string 'title' parameter, and should return a
                            string. If left undefined, neuron.vim will
                            generate random IDs for new notes. Default: >
                            undefined

g:neuron_backlinks_size     Size in characters used for backlinks window.
                            Default: >
                            let g:neuron_backlinks_size = 40

g:neuron_backlinks_vsplit   If this is set to 1, backlinks will be shown in a
                            vertical split. Otherwise a horizontal split will
                            be user. Default: >
                            let g:neuron_backlinks_vsplit = 1

g:neuron_backlinks_vsplit_right
                            If this is set to 1, backlinks will be shown in a
                            vertical split on the right, otherwise they will
                            be on the left. Default: >
                            let g:neuron_backlinks_vsplit_right = 1

g:neuron_daemon_cmd         The command to execute in order to start the
                            neuron daemon. Default: >
                            let g:neuron_daemon_cmd = 'neuron gen -wS --pretty-urls'

g:neuron_daemon_run         Whether to automatically launch the neuron daemon.
                            Default: >
                            let g:neuron_daemon_run = 1

g:neuron_dirs_to_check      The list of subdirectories to search for zettels.
                            The first directory from this list that contains
                            files with the *g:neuron_extension* extension will
                            be assumed to be the zettel directory. This
                            setting is useful if you store your zettels in a
                            subdirectory and not the *g:neuron_dir* that
                            contains the neuron.dhall file. Set it to any
                            empty list if you always have your notes in the
                            root directory. Default: >
                            let g:neuron_dirs_to_check = ['notes', 'zettels']

g:neuron_executable         Path to neuron. Default >
                            let g:neuron_executable = system('which neuron | tr -d "\n"')

g:neuron_extension          Zettel file extension. Default: >
                            let g:neuron_extension = '.md'


g:neuron_fullscreen_search  If fzf searches are to occupy the entire screen.
                            Default: >
                            let g:neuron_fullscreen_search = 0

g:neuron_fzf_options        Change the fzf parameters. Note that the default
                            options are required for proper functioning when
                            filtering of zettels. Default: >
                            let g:neuron_fzf_options = ['-d',':','--with-nth','2']

g:neuron_inline_backlinks   If set to 1, then inline backlinks will be shown
                            at the top of the buffer. Default: >
                            let g:neuron_inline_backlinks = 1

g:neuron_no_mappings        If this is set to 1 no mappings will be created.
                            Default: >
                            let g:neuron_no_mappings = 0

g:neuron_search_backend     The search backend to use for content searches.
                            Can be 'ag' for silver-searcher or 'rg' for
                            ripgrep. Default: >
                            let g:neuron_search_backend = 'ag'

g:neuron_tags_name          The key to use for specifying tags. Default: >
                            let g:neuron_tags_name = 'tags'

g:neuron_tags_style         The style of tags used when updating and inserting
                            tags. Can be either 'inline' or 'multiline'.
                            Inline tags look like this: >

                            tags: [vim,programming,advanced]
<
                            Multiline look like this: >

                            tags:
                              - vim
                              - programming
                              - advanced
<
                            Default: >
                            let g:neuron_tags_style = 'multiline'
```
