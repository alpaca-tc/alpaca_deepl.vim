let s:lib_root = fnamemodify(expand("<sfile>"), ":p:h:h")

function! s:get_definitions()
  if !exists("s:definitions")
    echo s:lib_root . "/comment_definition.json"
    let json = join(readfile(s:lib_root . "/comment_definition.json"), "\n")
    let s:definitions = webapi#json#decode(json)
  endif

  return s:definitions
endfunction

function! s:get_definition(filetype)
  return get(s:get_definitions(), a:filetype, {})
endfunction

function! comment_extractor#extract_comment(text, filetype)
  let text = "# hello"
  let filetype = "ruby"

  let definition = s:get_definition(filetype)
endfunction

function! comment_extractor#extract_comment(text, filetype)
  " TODO: extract comment from text
  return a:text
endfunction
