#__import__('dracula').main(c)
#__import__('base16_gruvbox_dark_soft').main(c)
__import__('base16_gruvbox_dark_medium').main(c)

config.load_autoconfig()

c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    '13': "https://1337x.to/search/{}/1/",
    'ad': "https://anidex.info/?q={}",
    'an': "https://www.anbient.com/search?search_api_views_fulltext={}",
    'at': "https://animestorrent.com/?s={}",
    'aw': "https://wiki.archlinux.org/index.php?search={}",
    'ccl': "https://culturacomlegenda.org/?s={}&submit=Pesquisar",
    'dic': "https://www.dicio.com.br/pesquisa.php?q={}",
    'eh': "https://e-hentai.org/?f_search={}",
    'git': "https://github.com/search?q={}",
    'go': "https://www.google.com/search?q={}",
    'imdb': "https://www.imdb.com/find?q={}",
    'md': "https://magnetdl.eu/search/{}/",
    'mon': "https://monova.org/search?term={}",
    'mx': "https://yts.mx/browse-movies/{}",
    'nh': "https://nhentai.net/search/?q={}",
    'ny': "https://nyaa.si/?q={}",
    'os': "https://www.opensubtitles.org/en/search/sublanguageid-pob/moviename-{}",
    'ph': "https://www.pornhub.com/video/search?search={}",
    'pm': "https://yts.pm/browse-movies/{}",
    'rar': "https://rargb.to/search/?search={}",
    'su': "https://sukebei.nyaa.si/?q={}",
    'to': "https://search.torrents.io/{}",
    'tpb': "https://thepiratebay.org/search.php?q={}",
    'tz': "https://torrentz2.eu/search?f={}",
    'ud': "https://www.urbandictionary.com/define.php?term={}",
    'wk': "https://pt.wikipedia.org/wiki/{}",
    'ys': "https://www.yifysubtitles.com/search?q={}",
    'yt': "https://www.youtube.com/results?search_query={}",
    'xv': "https://www.xvideos.com/?k={}",
    'zo': "https://zooqle.com/search?q={}",
    'wh': 'https://wallhaven.cc/search?q={}',
}
c.url.default_page = 'file:///home/anon/Pictures/wallpapers/homepage.html'
c.url.start_pages = ['file:///home/anon/Pictures/wallpapers/homepage.html']

config.bind(';x', 'yank -q selection ;; spawn -d xdg-open {clipboard}')
config.bind(';m', 'hint links spawn -d mpv --profile=web {hint-url}')
config.bind(';s', 'hint links spawn -d sxivget.sh {hint-url}')
config.bind(';e', 'hint links spawn -d ehentai.py {hint-url}')
config.bind(';d', 'hint links spawn -d alacritty --class download -e aria2c {hint-url}')
config.bind(';a', "hint links spawn -d alacritty --class download -e anbient.py {hint-url}")
config.bind(';4', 'hint links spawn -d alacritty --class download -e 4chan.py {hint-url}')
config.bind('yd', "hint links spawn -d alacritty --class download -e ytdl.sh {hint-url}")
config.bind('yD', "spawn -d alacritty --class download -e ytdl.sh {url}")
config.bind('ax', "spawn -d alacritty --class download -e anbient.py {url}")
config.bind('cx', 'spawn -d alacritty --class download -e 4chan.py {url}')
config.bind('mp', 'spawn -d mpv --profile=web {url}')
config.bind('eh', 'spawn -d ehentai.py {url}')
config.bind('mu', 'spawn -d musix.sh {url}')
config.bind('xr', 'spawn -u reddit')
config.unbind('m')

c.downloads.location.prompt = False
c.content.notifications = False
c.tabs.show = "always"
c.statusbar.show = "always"
c.tabs.background = False
c.tabs.indicator.width = 0
c.content.autoplay = False
c.scrolling.smooth = True
c.colors.webpage.prefers_color_scheme_dark = True
c.spellcheck.languages = ['pt-BR', 'en-US']
c.completion.scrollbar.padding = 5
c.completion.scrollbar.width = 10
c.downloads.remove_finished = 5000 # in miliseconds
c.colors.webpage.darkmode.enabled = False
