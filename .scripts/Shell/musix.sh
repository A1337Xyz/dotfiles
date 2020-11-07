#!/usr/bin/env bash

[ -z "$1" ] && { printf 'Usage: %s [musixmatch_url]\n' $0; exit 1; }
echo "$1" | grep -q musixmatch.com || { printf 'Invalid url\n'; exit 1; }
tmpfile=$(mktemp).html
notify-send "Running musix.sh" "Please wait..."

cat << EOF > "$tmpfile"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="style.css">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    background: #222222;
    color: #ffffff;
    font-family: Noto Sans CJK JP, Sans;
    font-size: 18pt;
}
#main {
    width: 80%;
    margin: 50px auto;
}
</style>
</head>
<body>
<div id="main">
$(
musix.py "$1" | sed 's/^/<p>/; s/$/<\/p>/' | head -n -3
)
</div>
</body>
</html>
EOF

qutebrowser "$tmpfile" &>/dev/null &
