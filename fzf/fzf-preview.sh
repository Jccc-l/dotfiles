#!/usr/bin/env bash
#
# The purpose of this script is to demonstrate how to preview a file or an
# image in the preview window of fzf.
#
# Dependencies:
# - https://github.com/sharkdp/bat
# - https://github.com/hpjansson/chafa
# - https://iterm2.com/utilities/imgcat

if [[ $# -ne 1 ]]; then
  >&2 echo "usage: $0 FILENAME[:LINENO][:IGNORED]"
  exit 1
fi

file=${1/#\~\//$HOME/}

center=0
if [[ ! -r $file ]]; then
  if [[ $file =~ ^(.+):([0-9]+)\ *$ ]] && [[ -r ${BASH_REMATCH[1]} ]]; then
    file=${BASH_REMATCH[1]}
    center=${BASH_REMATCH[2]}
  elif [[ $file =~ ^(.+):([0-9]+):[0-9]+\ *$ ]] && [[ -r ${BASH_REMATCH[1]} ]]; then
    file=${BASH_REMATCH[1]}
    center=${BASH_REMATCH[2]}
  fi
fi

type=$(file --brief --dereference --mime -- "$file")

mime_raw=$(file --brief --mime-type --dereference -- "$file")

archive_tree() {


  list=""

  # -------------------------
  # 7z (best support)
  # -------------------------
  if [[ $file == *.7z || $mime_raw == application/x-7z-compressed ]]; then
  echo "📦 Archive Tree: $file"
  echo "--------------------------------"
    if command -v 7z > /dev/null; then
      list=$(7z l "$file" | awk 'NR>20 {print $NF}')
    fi

  # -------------------------
  # zip
  # -------------------------
  elif [[ $file == *.zip || $mime_raw == application/zip ]]; then
  echo "📦 Archive Tree: $file"
  echo "--------------------------------"
    if command -v unzip > /dev/null; then
      list=$(unzip -Z1 "$file")
    elif command -v 7z > /dev/null; then
      list=$(7z l "$file" | awk 'NR>20 {print $NF}')
    fi

  # -------------------------
  # tar / tar.gz / xz / bz2
  # -------------------------
  elif [[ $file == *.tar || \
          $file == *.tgz || $file == *.tar.gz || \
          $file == *.tbz2 || $file == *.tar.bz2 || \
          $file == *.txz || $file == *.tar.xz || \
          $mime_raw == application/x-tar ]]; then
  echo "📦 Archive Tree: $file"
  echo "--------------------------------"

    if command -v tar > /dev/null; then
      list=$(tar -tf "$file")
    elif command -v 7z > /dev/null; then
      list=$(7z l "$file" | awk 'NR>20 {print $NF}')
    fi

  # -------------------------
  # rar
  # -------------------------
  elif [[ $file == *.rar || $mime_raw == application/vnd.rar ]]; then
  echo "📦 Archive Tree: $file"
  echo "--------------------------------"
    if command -v unrar > /dev/null; then
      list=$(unrar l "$file" | awk 'NR>10 {print $NF}')
    elif command -v 7z > /dev/null; then
      list=$(7z l "$file" | awk 'NR>20 {print $NF}')
    fi
  fi

  # -------------------------
  # fallback
  # -------------------------
  if [[ -z "$list" ]]; then
    return 1
  fi

  # -------------------------
  # tree rendering
  # -------------------------
  echo "$list" | awk '
  {
    n = split($0, a, "/")
    indent = ""
    for (i = 1; i < n; i++) indent = indent "│  "
    print indent "├── " a[n]
  }' | head -200
}

if archive_tree; then
  exit
fi

if [[ $mime_raw == application/pdf ]]; then
  if command -v pdftotext > /dev/null; then
    pdftotext -layout "$file" - | ${batname:-cat} | head -200
  elif command -v mutool > /dev/null; then
    mutool draw -F txt "$file" | head -200
  else
    file "$file"
  fi
  exit
fi

if [[ ! $type =~ image/ ]]; then
  if [[ $type =~ =binary ]]; then
    file "$1"
    exit
  fi

  # Sometimes bat is installed as batcat.
  if command -v batcat > /dev/null; then
    batname="batcat"
  elif command -v bat > /dev/null; then
    batname="bat"
  else
    cat "$1"
    exit
  fi

  ${batname} --style="${BAT_STYLE:-numbers}" --color=always --pager=never --highlight-line="${center:-0}" -- "$file"
  exit
fi

dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}
if [[ $dim == x ]]; then
  dim=$(stty size < /dev/tty | awk '{print $2 "x" $1}')
elif ! [[ $KITTY_WINDOW_ID ]] && ((FZF_PREVIEW_TOP + FZF_PREVIEW_LINES == $(stty size < /dev/tty | awk '{print $1}'))); then
  # Avoid scrolling issue when the Sixel image touches the bottom of the screen
  # * https://github.com/junegunn/fzf/issues/2544
  dim=${FZF_PREVIEW_COLUMNS}x$((FZF_PREVIEW_LINES - 1))
fi

# 1. Use icat (from Kitty) if kitten is installed
if [[ $KITTY_WINDOW_ID ]] || [[ $GHOSTTY_RESOURCES_DIR ]] && command -v kitten > /dev/null; then
  # 1. 'memory' is the fastest option but if you want the image to be scrollable,
  #    you have to use 'stream'.
  #
  # 2. The last line of the output is the ANSI reset code without newline.
  #    This confuses fzf and makes it render scroll offset indicator.
  #    So we remove the last line and append the reset code to its previous line.
  kitten icat --clear --transfer-mode=memory --stdin=no --unicode-placeholder --align right --place="$((FZF_PREVIEW_COLUMNS * 80 / 100))x$((FZF_PREVIEW_LINES * 90 / 100))@0x0" "$file" | sed '$d' | sed $'$s/$/\e[m/'

# 2. Use chafa with Sixel output
elif command -v chafa > /dev/null; then
  chafa -s "$dim" --scale 1 --format symbols "$file"
  # Add a new line character so that fzf can display multiple images in the preview window
  echo

# 3. If chafa is not found but imgcat is available, use it on iTerm2
elif command -v imgcat > /dev/null; then
  # NOTE: We should use https://iterm2.com/utilities/it2check to check if the
  # user is running iTerm2. But for the sake of simplicity, we just assume
  # that's the case here.
  imgcat -W "${dim%%x*}" -H "${dim##*x}" "$file"

# 4. Cannot find any suitable method to preview the image
else
  file "$file"
fi
