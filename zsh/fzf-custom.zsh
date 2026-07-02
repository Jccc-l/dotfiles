#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ 
#

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --exclude .git -H'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Command Preview options
FZF_PREVIEW_STYLE='--preview-window=right:60%:wrap:border-horizontal'

export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border
  --ansi
  --preview='~/.config/fzf/fzf-preview.sh {}'
  --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
  $FZF_PREVIEW_STYLE
"

# CTRL-T: Paste file path
export FZF_CTRL_T_OPTS=""

# TAB Completion
export FZF_COMPLETION_OPTS=""

# ALT-C: Cd into directory
export FZF_ALT_C_OPTS="
  --no-preview
"

# CTRL-R: Search for History Command
export FZF_CTRL_R_OPTS="
  --no-preview
"

# CTRL-F: 
export FZF_ALT_C_OPTS="
  --no-preview
"

# Install packages using yay (change to pacman/AUR helper of your choice)
function in() {
    pacman -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}
# Remove installed packages (change to pacman/AUR helper of your choice)
function re() {
    pacman -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
}

# Helper function to integrate yay and fzf
yzf() {
  pos=$1
  shift
  sed "s/ /\t/g" |
    fzf --nth=$pos --multi --history="${FZF_HISTDIR:-$XDG_STATE_HOME/fzf}/history-yzf$pos" \
      --preview-window=60%,border-left \
      --bind="double-click:execute(xdg-open 'https://archlinux.org/packages/{$pos}'),alt-enter:execute(xdg-open 'https://aur.archlinux.org/packages?K={$pos}&SB=p&SO=d&PP=100')" \
       "$@" | cut -f$pos | xargs
}

# Dev note: print -s adds a shell history entry

# List installable packages into fzf and install selection
yas() {
  cache_dir="/tmp/yas-$USER"
  test "$1" = "-y" && rm -rf "$cache_dir" && shift
  mkdir -p "$cache_dir"
  preview_cache="$cache_dir/preview_{2}"
  list_cache="$cache_dir/list"
  { test "$(cat "$list_cache$@" | wc -l)" -lt 50000 && rm "$list_cache$@"; } 2>/dev/null
  pkg=$( (cat "$list_cache$@" 2>/dev/null || { pacman --color=always -Sl "$@"; yay --color=always -Sl aur "$@" } | sed 's/ [^ ]*unknown-version[^ ]*//' | tee "$list_cache$@") |
    yzf 2 --tiebreak=index --preview="cat $preview_cache 2>/dev/null | grep -v 'Querying' | grep . || yay --color always -Si {2} | tee $preview_cache")
  if test -n "$pkg"
    then echo "Installing $pkg..."
      cmd="yay -S $pkg"
      print -s "$cmd"
      eval "$cmd"
      rehash
  fi
}
# List installed packages into fzf and remove selection
# Tip: use -e to list only explicitly installed packages
yar() {
  pkg=$(yay --color=always -Q "$@" | yzf 1 --tiebreak=length --preview="yay --color always -Qli {1}")
  if test -n "$pkg"
    then echo "Removing $pkg..."
      cmd="yay -R --cascade --recursive $pkg"
      print -s "$cmd"
      eval "$cmd"
  fi
}
