if pgrep -x ghostty > /dev/null; then
	niri msg action focus-window --id $(niri msg windows|grep -B 2 "App ID: \"com.mitchellh.ghostty\""| grep -Po '(?<=Window ID )\d+')
else
	ghostty &
fi
