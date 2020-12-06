function search(opt, query_term) {
    let engine = {
        default: "https://duckduckgo.com/?q=" + query_term,
        go: "https://www.google.com/search?q=" + query_term,
        ad: "https://anidex.info/?q=" + query_term,
        13: "https://1337x.to/search/" + query_term + "/1/",
        an: "https://www.anbient.com/search?search_api_views_fulltext=" + query_term,
        at: "https://animestorrent.com/?s=" + query_term,
        aw: "https://wiki.archlinux.org/index.php?search=" + query_term,
        dic: "https://www.dicio.com.br/pesquisa.php?q=" + query_term,
        git: "https://github.com/search?q=" + query_term,
        imdb: "https://www.imdb.com/find?q=" + query_term,
        md: "https://magnetdl.eu/search/" + search + "/",
        mon: "https://monova.org/search?term=" + query_term,
        mx: "https://yts.mx/browse-movies/" + query_term,
        nh: "https://nhentai.net/search/?q=" + query_term,
        ny: "https://nyaa.si/?q=" + query_term,
        os: "https://www.opensubtitles.org/en/search/sublanguageid-pob/moviename-" + query_term,
        ph: "https://www.pornhub.com/video/search?search=" + query_term,
        pm: "https://yts.pm/browse-movies/" + query_term,
        rar: "https://rargb.to/search/?search=" + query_term,
        su: "https://sukebei.nyaa.si/?q=" + query_term,
        to: "https://search.torrents.io/" + query_term,
        tpb: "https://thepiratebay.org/search.php?q=" + query_term,
        tz: "https://torrentz2.eu/search?f=" + query_term,
        ud: "https://www.urbandictionary.com/define.php?term=" + query_term,
        wk: "https://pt.wikipedia.org/wiki/" + query_term,
        ys: "https://www.yifysubtitles.com/search?q=" + query_term,
        yt: "https://www.youtube.com/results?search_query=" + query_term,
        xv: "https://www.xvideos.com/?k=" + query_term,
        zo: "https://zooqle.com/search?q=" + query_term,
        wh: "https://wallhaven.cc/search?q=" + query_term,
    }
    if (Object.keys(engine).includes(opt)) {
        if (query_term.length == 0) {
            url = "https://" + engine[opt].split("/")[2];
        } else {
            url = engine[opt]
        }
    } else { 
        url = engine.default;
    }
    window.location = url;
}

let search_box = document.querySelector("input");
search_box.addEventListener("keydown", function(e) {
    if (e.keyCode == 13) {
        let query_term = search_box.value;
        let parsed = query_term.split(" ");
        let opt = parsed[0].slice(1, parsed[0].length);
        if (parsed[0][0] == ";")
            query_term = parsed.slice(1, parsed.length).join(" ");
        search(opt, query_term)
    }
});

let clock = document.querySelector("#clock");
function update_clock() {
    let date = new Date(); 
    let hour = date.getHours();
    let min = date.getMinutes();
    let sec = date.getSeconds();
    if (min < 10) min = "0" + min;
    if (sec < 10) sec = "0" + sec;
    if (hour < 10) hour = "0" + hour;
    clock.innerHTML = hour + ":" + min + ":" + sec;
}
update_clock();
setInterval(update_clock, 1000);
