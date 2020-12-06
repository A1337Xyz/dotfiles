#!/bin/sh
WALLPAPERS=~/Pictures/wallpapers

main() {
    js=~/.scripts/shell/homepage/script.js
    css=~/.scripts/shell/homepage/style.css

    cd "$WALLPAPERS" || return

    [ -f homepage.html ] && rm -vfi homepage.html
    cat << EOF > homepage.html
<!DOCTYPE html>
<html>
    <head>
        <title>/home</title>
        <meta charset="utf-8">
        <style>$(cat "$css")</style>
    </head>
    <body>
        <div id="search"><input autofocus></div> 
        <div id="clock"></div> 
        <script>
            let imgs = [$(find . -iname '*.jpg' -printf '"%p",')];
            img = imgs[Math.floor(Math.random() * imgs.length)];
            document.body.style.backgroundImage = "url('" + img + "')";
            p = document.createElement("P");
            p.setAttribute("id", "filename");
            p.innerHTML = img;
            document.body.appendChild(p)
        </script>
        <script>$(cat "$js")</script>
    </body>
</html>
EOF
}

[ -d "$WALLPAPERS" ] && main
