config.load_autoconfig(False)

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

config.set('content.cookies.accept', 'all', 'devtools://*')

config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

config.set('content.images', True, 'chrome-devtools://*')

config.set('content.images', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome-devtools://*')

config.set('content.javascript.enabled', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome://*/*')

config.set('content.javascript.enabled', True, 'qute://*/*')

# -----------------------------------------------------------------------------

# Default editor
c.editor.command = ['alacritty', '-e', 'nvim', '{}']

# Theme
c.colors.webpage.darkmode.enabled = True

# Aliases
c.aliases = { 
             'bkl': 'bookmark-list', 
             'bko': 'boodmark-load', 
             'bkd': 'boodmark-del', 
             'bka': 'boodmark-add', 
             'qkl': 'quickmark-list', 
             'qko': 'quickmark-load', 
             'qkd': 'quickmark-del', 
             'qka': 'quickmark-add', 
             }

# Downloads
c.downloads.location.directory = '~/Descargas'

# Tabs
c.tabs.show = 'always'

# Default and start page
c.url.default_page = 'https://duckduckgo.com/'
c.url.start_pages = 'https://duckduckgo.com/'

# Search Engines
# TODO searchx
c.url.searchengines = {
        'DEFAULT': 'https://duckduckgo.com/?q={}', 
        'gog': 'https://www.google.com/search?q={}', 
        'wre': 'https://www.wordreference.com/es/translation.asp?tranword={}', 
        'wiki': 'https://en.wikipedia.org/wiki/{}', 
        'yt': 'https://www.youtube.com/results?search_query={}'
}

# Default Font 
c.fonts.default_family = '"UbuntuMono Nerd Font Mono"'

# Default font size to use. Whenever "default_size" is used in a font
# setting, it's replaced with the size listed here. Valid values are
# either a float value with a "pt" suffix, or an integer value with a
c.fonts.default_size = '10pt'

# Font used in the completion widget.
c.fonts.completion.entry = '10pt "UbuntuMono Nerd Font Mono"'

# Font used for the debugging console.
c.fonts.debug_console = '10pt "UbuntuMono Nerd Font Mono"'

# Font used for prompts.
c.fonts.prompts = 'default_size sans-serif'

# Font used in the statusbar.
c.fonts.statusbar = '11pt "UbuntuMono Nerd Font Mono"'

# Bindings for normal mode
config.bind('t', 'set-cmd-text -s :open -t')
config.bind('<Space>yt', ':open https://youtube.com')
