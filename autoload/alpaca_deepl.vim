call _alpaca_deepl_init()

function! alpaca_deepl#complete_options(arg_lead, cmd_line, cursor_pos)
  " TODO
  return []

        \ 'source_lang': g:alpaca_deepl#default_source_lang,
        \ 'target_lang': g:alpaca_deepl#default_target_lang
endfunction

function! s:parse_language_options(source, auto_detect_language)
  if a:auto_detect_language && s:detect_language(a:source) == g:alpaca_deepl#default_target_lang
    return {
          \ "source_lang": g:alpaca_deepl#default_target_lang,
          \ 'target_lang': g:alpaca_deepl#default_source_lang
          \ }
  elseif a:auto_detect_language && s:detect_language(a:source) != g:alpaca_deepl#default_source_lang
    return {
          \ "source_lang": "",
          \ 'target_lang': g:alpaca_deepl#default_target_lang
          \ }
  else
    return {
          \ "source_lang": g:alpaca_deepl#default_source_lang,
          \ 'target_lang': g:alpaca_deepl#default_target_lang
          \ }
  endif
endfunction

function! s:parse_options(args, auto_detect_language) "{{{
  let options = {
        \ 'count' : a:args[0],
        \ 'startline' : a:args[1],
        \ 'endline' : a:args[2],
        \ 'is_range' : (a:args[0] != -1),
        \ 'filetype': &filetype
        \ }

  " TODO: Parse optional args
  let all_args = split(get(a:args, 3, ''), '\s\+')

  if options.is_range
    let options.source = join(getline(options.startline, options.endline), "\n")
  else
    let options.source = join(getline(0, '$'), "\n")
  endif

  if empty(options.source)
    let options.source = " "
  endif

  let language_options = s:parse_language_options(options.source, a:auto_detect_language)

  call extend(options, language_options)

  return options
endfunction"}}}

function! alpaca_deepl#translate_raw_text(text, source_lang, target_lang)
  return _alpaca_deepl_translate(a:text, a:source_lang, a:target_lang)
endfunction

function! s:detect_language(text)
  let language = _alpaca_deepl_detect_language(a:text)
  return language
endfunction

function! alpaca_deepl#translate(...)
  let options = s:parse_options(a:000, 1)
  let comment = comment_extractor#extract_comment(options.source, options.filetype)
  let text = alpaca_deepl#translate_raw_text(comment, options["source_lang"], options.target_lang)

  call alpaca_deepl#window#dispatch(text, options)
endfunction
