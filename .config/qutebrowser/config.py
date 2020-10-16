__import__('dracula').main(c)

config.load_autoconfig()

c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    '13': "https://1337x.to/search/{}/1/",
    'ad': "https://anidex.info/?q={}",
    'an': "https://www.anbient.com/search?search_api_views_fulltext={}",
    'aw': "https://wiki.archlinux.org/index.php?search={}",
    'ccl': "https://culturacomlegenda.org/?s={}&submit=Pesquisar",
    'dic': "https://www.dicio.com.br/pesquisa.php?q={}",
    'git': "https://github.com/search?q={}",
    'go': "https://www.google.com/search?q={}",
    'imdb': "https://www.imdb.com/find?q={}",
    'md': "https://magnetdl.eu/search/{}/",
    'mon': "https://monova.org/search?term={}",
    'mx': "https://yts.mx/browse-movies/{}",
    'ny': "https://nyaa.si/?q={}",
    'os': "https://www.opensubtitles.org/en/search/sublanguageid-pob/moviename-{}",
    'pm': "https://yts.pm/browse-movies/{}",
    'rarbg': "https://rargb.to/search/?search={}",
    'su': "https://sukebei.nyaa.si/?q={}",
    'to': "https://search.torrents.io/{}",
    'tpb': "https://thepiratebay.org/search.php?q={}",
    'tz': "https://torrentz2.eu/search?f={}",
    'ud': "https://www.urbandictionary.com/define.php?term={}",
    'wk': "https://pt.wikipedia.org/wiki/{}",
    'ys': "https://www.yifysubtitles.com/search?q={}",
    'yt': "https://www.youtube.com/results?search_query={}",
    'zo': "https://zooqle.com/search?q={}",
}
#c.url.default_page = 'file:///home/anon/Pictures/wallpapers/homepage.html'
#c.url.start_pages = ['file:///home/anon/Pictures/wallpapers/homepage.html']
c.content.notifications = False

config.bind(';x', 'yank -q selection ;; spawn -d xdg-open {clipboard}')
config.bind(';m', 'hint links spawn -d mpv --profile=web {hint-url}')
config.bind(';s', 'hint links spawn -d sxivget.sh {hint-url}')
config.bind(';d', 'hint links spawn -d urxvt -name download -e aria2c {hint-url}')
config.bind(';a', "hint links spawn -d urxvt -name download -e anbient.py {hint-url}")
config.bind('yd', "hint links spawn -d urxvt -name download -e ytdl.sh {hint-url}")
config.bind('yD', "spawn -d urxvt -name download -e ytdl.sh {url}")
config.bind('ax', "spawn -d urxvt -name download -e anbient.py {url}")
config.bind('mp', 'spawn -d mpv --profile=web {url}')
config.bind(';M', 'hint images download')
config.bind('mu', 'spawn -d musix.sh {url}')
config.unbind('m')

c.tabs.show = "always"
c.statusbar.show = "in-mode"
c.tabs.background = False
c.tabs.indicator.width = 0
c.content.autoplay = False
c.scrolling.smooth = False
c.colors.webpage.prefers_color_scheme_dark = True
c.spellcheck.languages = ['pt-BR', 'en-US']
c.completion.scrollbar.padding = 5
c.completion.scrollbar.width = 10
