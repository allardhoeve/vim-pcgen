" pcgen.vim - Editing PCGen LST files made easy (Vimscript-only version)
" Maintainer:   Henk Slaaf <henk@henkslaaf.nl>
" Version:      0.2 (Vimscript-only)

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
let b:did_conversion = 0


" Automatically rewrite to tabbed format on write if we converted to multi-line
autocmd BufWritePre <buffer> call pcgen#multiLineToTabbed()


function! pcgen#setTabbedOptions()
  setlocal list lcs=eol:¶,tab:»-,trail:·
  setlocal noautoindent
endfunction

function! pcgen#setMultiLineOptions()
  setlocal autoindent
endfunction


function! pcgen#multiLineToTabbed()
  if !b:did_conversion
    return
  endif

  let lines = getline(1, '$')
  let content = join(lines, "\n")

  " Replace all newlines that are followed by a tab with nothing (removing the newline but keeping the tab)
  let content = substitute(content, '\n\t', '\t', 'g')

  " Replace double newlines with single newlines
  let content = substitute(content, '\n\n', '\n', 'g')

  call pcgen#replace_buffer(split(content, '\n'))
  let b:did_conversion = 0
endfunction

function! pcgen#tabbedToMultiLine()
  if b:did_conversion
    return
  endif

  let lines = getline(1, '$')
  let content = join(lines, "\n")

  " Make sure newlines are doubled
  let content = substitute(content, '\n', '\n\n', 'g')

  " Replace tab characters with a newline and a tab
  " Tabs after the first remain on the first line so they get restored
  let content = substitute(content, '\t\(\t*\)', '\1\n\t', 'g')

  call pcgen#replace_buffer(split(content, '\n'))
  let b:did_conversion = 1
endfunction

function! pcgen#replace_buffer(new_lines)
  let lnum = line('$')
  execute '1,' . lnum . 'delete _'
  call append(0, a:new_lines)
endfunction


" Startup setup
syntax on
setlocal list lcs=eol:¶,tab:»-,trail:·
setlocal nowrap
set noexpandtab
call pcgen#setTabbedOptions()

nmap <silent> <buffer> <F2> :call pcgen#tabbedToMultiLine()<CR>:call pcgen#setMultiLineOptions()<CR>
nmap <silent> <buffer> <F3> :call pcgen#multiLineToTabbed()<CR>:call pcgen#setTabbedOptions()<CR>
