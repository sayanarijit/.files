#!/usr/bin/env bash

# Copied from https://gitlab.com/xPMo/dotfiles.cli/-/blob/dots/.local/lib/waybar/playerctl.sh

exec 2>"$XDG_RUNTIME_DIR/waybar-playerctl.log"
IFS=$'\n\t'

cleanup() {
  read -r pid <"$XDG_RUNTIME_DIR/waybar-playerctl.pid"
  [[ -d "/proc/$pid" ]] || return
  read -rd '' cmd <"/proc/$pid/cmdline"
  : "$cmd"
  case $cmd in
  -playerctl | playerctl | */playerctl)
    echo >&2 "Killing playerctl [$pid]"
    kill "$pid"
    ;;
  esac
}

# in case waybar didn't die cleanly
cleanup

trap cleanup EXIT INT

while true; do

  while read -r playing position length name artist title arturl hpos hlen; do
    # remove leaders
    playing=${playing:1} position=${position:1} length=${length:1} name=${name:1}
    artist=${artist:1} title=${title:1} arturl=${arturl:1} hpos=${hpos:1} hlen=${hlen:1}

    # build line
    line="${artist:+$artist ${title:+- }}${title:+$title }${hpos:+$hpos${hlen:+|}}$hlen"

    # json escaping
    line="${line//\"/\\\"}"
    ((percentage = length ? (100 * (position % length)) / length : 0))
    case $playing in
    ⏸️ | Paused) text="$line" ;;
    ▶️ | Playing) text="$line" ;;
    *) text='' ;;
    esac

    # integrations for other services (nwg-wrapper)
    if [[ $title != "$ptitle" || $artist != "$partist" || $parturl != "$arturl" ]]; then
      typeset -p playing length name artist title arturl >"$XDG_RUNTIME_DIR/waybar-playerctl.info"
      pkill -8 nwg-wrapper
      ptitle=$title partist=$artist parturl=$arturl
    fi

    # exit if print fails
    printf '{"text":"%s","tooltip":"%s","class":"%s","percentage":%s}\n' \
      "$text" "$playing $name | $line" "$percentage" "$percentage" || break 2

  done < <(
    # requires playerctl>=2.0
    # Add non-space character ":" before each parameter to prevent 'read' from skipping over them
    playerctl --follow metadata --player playerctld --format \
      $':{{emoji(status)}}\t:{{position}}\t:{{mpris:length}}\t:{{playerName}}\t:{{markup_escape(artist)}}\t:{{markup_escape(title)}}\t:{{mpris:artUrl}}\t:{{duration(position)}}\t:{{duration(mpris:length)}}' &
    echo $! >"$XDG_RUNTIME_DIR/waybar-playerctl.pid"
  )

  # no current players
  cleanup
  # exit if print fails
  echo '' || break
  sleep 15

done
