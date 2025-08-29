# 判断是否在 GUI 终端模拟器中（支持 256 色）
if [[ -n "$DISPLAY" ]] || [[ "$TERM" == "xterm-256color" ]] || [[ "$COLORTERM" == "truecolor" ]] || [[ "$COLORTERM" == "24bit" ]]; then
    # GUI 终端：使用 256 色浅灰背景
    eval "$(dircolors -b ~/.dircolors-256)"
else
    # TTY 或不支持 256 色：使用 16 色，避免背景色
    eval "$(dircolors -b ~/.dircolors-16)"
fi
