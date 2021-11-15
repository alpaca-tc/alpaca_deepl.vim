if exists('g:alpaca_deepl_loaded')
  finish
endif
let g:alpaca_deepl_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

" API key. https://www.deepl.com/pro-account/summary
let g:alpaca_deepl#api_key = get(g:, 'alpaca_deepl#api_key', '')

" API plan. Allowed value is 'free' or 'pro'
let g:alpaca_deepl#plan = get(g:, 'alpaca_deepl#plan', 'free')

let g:alpaca_deepl#default_source_lang = get(g:, 'alpaca_deepl#default_source_lang', 'JA')
let g:alpaca_deepl#default_target_lang = get(g:, 'alpaca_deepl#default_target_lang', 'EN-US')
let g:alpaca_deepl#default_command = get(g:, 'alpaca_deepl#default_command', 'vnew')

command! -complete=customlist,alpaca_deepl#complete_options -nargs=? -range=% Deepl :call alpaca_deepl#translate(<count>, <line1>, <line2>, <q-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
