if pgrep -f /opt/google/chrome-unstable/chrome > /dev/null; then
	niri msg action focus-window --id $(niri msg windows|grep -B 2 "App ID: \"google-chrome-unstable\""| grep -Po '(?<=Window ID )\d+')
else
	google-chrome-unstable --ozone-platform=wayland &
fi
