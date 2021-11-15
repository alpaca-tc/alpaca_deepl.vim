from importlib.util import find_spec
from langdetect import detect

if find_spec('pynvim'):
    import pynvim as vim
else:
    import neovim as vim
import requests

@vim.plugin
class AlpacaDeepl(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @vim.function('_alpaca_deepl_init', sync=True)
    def _alpaca_deepl_init(self, args):
        self.key = self.nvim.eval('g:alpaca_deepl#api_key')
        self.host = "api.deepl.com" if self.nvim.eval('g:alpaca_deepl#plan') == "pro" else "api-free.deepl.com"
        pass

    @vim.function('_alpaca_deepl_translate', sync=True)
    def _translate(self, args) -> str:
        text = args[0]
        source_lang = args[1]
        target_lang = args[2]

        params = {
            "auth_key": self.key,
            "target_lang": target_lang,
            "text": text
        }

        if len(str(source_lang)) < 1:
            params["source_lang"] = source_lang

        url = 'https://{}/v2/translate'.format(self.host)
        request = requests.post(url, data=params)
        json = request.json()
        return json["translations"][0]["text"]

    @vim.function('_alpaca_deepl_detect_language', sync=True)
    def _detect_language(self, args) -> str:
        text = args[0]
        language = detect(text)

        if language == 'ja':
            return "JA"
        elif language == 'en':
            return "EN-US"
        else:
            return ""
