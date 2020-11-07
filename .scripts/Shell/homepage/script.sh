#!/bin/sh
cd ~/Pictures/wallpapers # wallpapers folder
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
    font: 11pt Hack;
}
#filename {
    position: absolute;
    padding: 5px 20px;
    right: 0;
    bottom: 0;
    color: #5e8;
    box-shadow: 2px 2px 4px #000;
}
#favorites {
    width: 100%;
    height: 100vh;
    /*display: grid;
    grid-template-columns: auto auto auto auto;*/
    display: flex;
    flex-wrap: wrap;
    flex-direction: column;
    background: #00000088;
}
a {
    color: #5e8;
    text-decoration: none;
    padding: 3px 5px;
    text-shadow: 2px 2px 5px #000;
}
a:hover {
    background: #00000090;
}
</style>
</head>
<body>
<div id="favorites">
    <a href="https://youtube.com">YouTube</a>
    <a href="https://reddit.com">Reddit</a>
    <a href="https://suckless.org">suckless</a>
    <a href="https://archlinux.org">Archlinux</a>
    <a href="https://wiki.archlinux.org">ArchWiki</a>
    <a href="https://i3wm.org/docs">i3wm</a>
    <a href="https://translate.google.com.br">Google translator</a>
    <a href="https://web.whatsapp.com">Whatsapp</a>
    <a href="https://web.telegram.org">Telegram</a>
    <a href="https://1337x.to">1337x</a>
    <a href="https://thepiratebay.org">ThePirateBay</a>
    <a href="https://torlock2.com">TorLock2</a>
    <a href="https://limetorrents.info">Limetorrents</a>
    <a href="https://magnetdl.com">Magnetdl</a>
    <a href="https://monova.org">Monova</a>
    <a href="https://zooqle.com">Zoogle</a>
    <a href="https://torrentz2.eu">Torrentz2</a>
    <a href="https://torrents.io">Torrents.io</a>
    <a href="https://temp-mail.org">TempMail</a>
    <a href="https://nyaa.si">Nyaa</a>
    <a href="https://www.w3schools.com">W3schools</a>
    <a href="https://roadmap.sh">Roadmap.sh</a>
</div>
<script>
let imgs = [$(
find . -iname '*.jpg' | while read -r l;do
    printf '"%s",' "$l"
done)];
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
