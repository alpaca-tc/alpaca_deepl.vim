function! alpaca_deepl#window#dispatch(text, options) "{{{
  if empty(get(a:options, 'window', ''))
    call s:execute_buffer_command(g:alpaca_deepl#default_command, a:text, a:options.filetype)
  elseif exists('alpaca_deepl#window#dispatch_' . a:options['window'])
    " TODO
    echomsg a:text
  else
    call s:execute_buffer_command(a:options['window'], a:text, a:options.filetype)
  endif
endfunction"}}}

function! s:execute_buffer_command(command, text, filetype)
  silent! execute a:command
  execute 'setl filetype='. a:filetype
  silent! 0put =a:text

  " Delete tail line
  $delete
endfunction
