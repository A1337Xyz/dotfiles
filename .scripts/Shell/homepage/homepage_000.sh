#!/bin/sh
cd ~/Pictures/wallpapers
[ -f homepage.html ] && rm -vf homepage.html
cat << EOF > homepage.html
<!DOCTYPE html>
<html>
<head>
<title>/home</title>
<meta charset="utf-8">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    background-repeat: no-repeat;
    background-position: center;
    background-attachment: fixed;
    background-size: cover;
    background-color: #222;
    font-family: "Perfect DOS VGA 437 Win", monospaced;
    font-size: 12pt;
}
#filename {
    background: #000;
    position: absolute;
    padding: 5px 20px;
    right: 0;
    bottom: 0;
    color: #5e8;
    box-shadow: 2px 2px 4px #000;
}
#favorites {
    margin: auto;
    width: 100%;
    padding: 3em;
    height: 100vh;
    /*display: grid;
    grid-template-columns: auto auto auto auto;*/
    display: flex;
    flex-wrap: wrap;
    flex-direction: column;
    background: #00000000;
}
a {
    color: #5e8;
    text-decoration: none;
    padding: 5px;
    text-shadow: 2px 2px 5px #000;
    border: 1px solid #000; 
    background: #00000070;
}
a:hover {
    background: #000000cc;
    border: 1px solid #5e8;
}
</style>
</head>
<body>
<div id="favorites">
    <a href="https://youtube.com">YouTube</a>
    <a href="https://reddit.com">Reddit</a>
    <a href="https://4chan.org">4chan</a>
    <a href="https://suckless.org">suckless</a>
    <a href="https://archlinux.org">Archlinux</a>
    <a href="https://wiki.archlinux.org">ArchWiki</a>
    <a href="https://i3wm.org/docs">i3wm</a>
    <a href="https://translate.google.com.br">Google translator</a>
    <a href="https://web.whatsapp.com">Whatsapp</a>
    <a href="https://web.telegram.org">Telegram</a>
    <a href="https://yts.lt">yts.lt</a>
    <a href="https://yts.ms">yts.ms</a>
    <a href="https://1337x.to">1337x</a>
    <a href="https://culturacomlegenda.org">CulturaComLegenda</a>
    <a href="https://legendasdivx.pt">Legendasdivx</a>
    <a href="https://opensubtitles.org">OpenSubtitles</a>
    <a href="https://thepiratebay.org">ThePirateBay</a>
    <a href="https://torlock2.com">TorLock2</a>
    <a href="https://limetorrents.info">Limetorrents</a>
    <a href="https://magnetdl.com">Magnetdl</a>
    <a href="https://monova.org">Monova</a>
    <a href="https://zooqle.com">Zoogle</a>
    <a href="https://torrentz2.eu">Torrentz2</a>
    <a href="https://torrents.io">Torrents.io</a>
    <a href="https://temp-mail.org">TempMail</a>
    <a href="https://bludv.tv">Bludv</a>
    <a href="https://p2pguru.com">p2pguru</a>
    <a href="https://sukebei.nyaa.si">Sukebei</a>
    <a href="https://nyaa.si">Nyaa</a>
    <a href="https://rule34.xxx">rule34</a>
    <a href="https://www.w3schools.com">W3schools</a>
    <a href="https://yifysubtitles.com">YifySubtitles</a>
    <a href="https://roadmap.sh">Roadmap.sh</a>
    <a href="https://translatesubtitles.com">TranslateSubtitles</a>
    <a href="https://horriblesubs.info">HorribleSubs</a>
    <a href="https://www.amazon.com.br/">Amazon</a>
    <a href="https://pt.aliexpress.com/">Aliexpress</a>
    <a href="https://realkana.com/study">Realkana</a>
    <a href="http://www.guidetojapanese.org/learn/resources">Japanese Guide</a>
    <a href="http://www.guidetojapanese.org/learn/category/blog">Japanese Guide Blog</a>
    <a href="http://www.guidetojapanese.org/learn/grammar">Japanese Guide Grammer</a>
    <a href="https://www.tofugu.com/reviews/genki-textbook">Genki Textbook</a>
    <a href="https://www.tofugu.com/japanese/learn-katakana/">Learn Katakana</a>
    <a href="http://quickkanji.com/index.html">QuickKanji</a>
    <a href="https://jisho.org">Jisho</a>
    <a href="https://www.wednesdaydowntown.com">Wednesday Downtown</a>
    <a href="https://drmoku.com/japanese-words-and-phrases-with-audio-pronunciation/">Dr. Moku</a>
    <a href="https://www.yomiuri.co.jp/">Yomirui</a>
    <a href="https://www.tofugu.com/learn-japanese/">Tofugu</a>
    <a href="https://www.asagaku.com/">Asagaku</a>
    <a href="https://www3.nhk.or.jp/news/easy/">Nhk</a>
    <a href="http://life.ou.edu/stories/">Japanese stories</a>
    <a href="http://hukumusume.com/douwa/betu/">Hukumusume</a>
    <a href="https://nihongo-e-na.com/eng/">NIHONGO</a>
    <a href="https://live.nicovideo.jp/">Nico</a>
</div>
<script>
let imgs = [$(find -iname '*.jpg' -printf '"%p",')];
img = imgs[Math.floor(Math.random() * imgs.length)];
document.body.style.backgroundImage = "url('" + img + "')";
p = document.createElement("P");
p.setAttribute("id", "filename");
p.innerHTML = img; //img.slice(1, img.length);
document.body.appendChild(p)
</script>
</body>
</html>
EOF
