__import__('dracula_theme').main(c)
#__import__('base16_gruvbox_dark_hard').main(c)

c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'go': "https://www.google.com/search?q={}",
    'aw': "https://wiki.archlinux.org/index.php?search={}",
    'ud': "https://www.urbandictionary.com/define.php?term={}",
    'imdb': "https://www.imdb.com/find?q={}",
    'tpb': "https://thepiratebay.org/search.php?q={}",
    'mon': "https://monova.org/search?term={}",
    'zo': "https://zooqle.com/search?q={}",
    'to': "https://search.torrents.io/{}",
    'tz': "https://torrentz2.eu/search?f={}",
    '13': "https://1337x.to/search/{}/1/",
    'rarbg': "https://rargb.to/search/?search={}",
    'ny': "https://nyaa.si/?q={}",
    'su': "https://sukebei.nyaa.si/?q={}",
}
# c.url.default_page = 'file:///home/anon/Pictures/wallpapers/homepage.html'
# c.url.start_pages = ['file:///home/anon/Pictures/wallpapers/homepage.html']
c.content.notifications = False

config.bind('M', 'hint images download')
config.bind(';m', 'hint links spawn mpv --profile=web {hint-url}')
config.bind(';s', 'hint links spawn sxivget.sh {hint-url}')
config.bind('m', 'spawn mpv --profile=web {url}')
config.bind(';x', 'yank -q selection ;; spawn xdg-open {clipboard}')
config.bind('yv', "hint links spawn urxvt -geometry 75x10 -title ytdl -e ytdl.sh video {hint-url}")
config.bind('ya', "hint links spawn urxvt -geometry 75x10 -title ytdl -e ytdl.sh audio {hint-url}")
config.bind('yd', "hint links spawn urxvt -geometry 75x10 -title ytdl -e ytdl.sh {hint-url}")

c.tabs.show = "always"
c.tabs.background = False
c.tabs.indicator.width = 0
c.statusbar.hide = False
c.content.autoplay = False
c.scrolling.smooth = False
c.colors.webpage.prefers_color_scheme_dark = True
c.spellcheck.languages = ['pt-BR', 'en-US']
c.completion.scrollbar.padding = 5
c.completion.scrollbar.width = 10
