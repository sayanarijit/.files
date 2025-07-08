#!/usr/bin/env bash

# "bash" "-c" "curl -s \"https://bing.com$(curl -s 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' | jq -r '.images[0].url')\" -o ~/Pictures/bing-wallpaper-of-the-day.jpeg 2> ~/Pictures/bing-wallpaper-of-the-day.log && swww img ~/Pictures/bing-wallpaper-of-the-day.jpeg"

imgpath="${1:-$HOME/Pictures/bing-wallpaper-of-the-day.jpeg}"

wallpaper_url=$(curl -s 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' | jq -r '.images[0].url')

curl -s "https://bing.com$wallpaper_url" -o "$imgpath" 2>"$imgpath.log"

if [ -f "$imgpath" ]; then
  swww img "$imgpath"
fi
