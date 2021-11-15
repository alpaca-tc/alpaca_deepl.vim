function! s:check_python() abort
  if exists('g:python3_host_prog') && executable('g:python3_host_prog')
    let host = g:python3_host_prog
  elseif executable('python3')
    let host = 'python3'
  elseif executable('python')
    let host = 'python'
  else
    call health#report_error('Python is required but not executable: ' . host)
    return
  endif

  call health#report_ok('Using '.host)
endfunction

function! health#alpaca_deepl#check()
  call s:check_python()
endfunction
