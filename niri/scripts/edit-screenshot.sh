#!/usr/bin/env bash

# 声明一个变量，值根据wl-paste输出的当前剪贴板的数据计算出哈希值
CLIPNOW=$(wl-paste|sha1sum)

# 启动niri截图
niri msg action screenshot

# 循环，不断打印当前剪贴板数据计算哈希值，与之前声明的变量里的数据进行比较，当剪贴板哈希值发生变化，则停止循环
while [[ "$(wl-paste|sha1sum)" = "$CLIPNOW" ]]; do
    sleep .05
done

# 将新的剪贴板内容的数据传入satty打开
wl-paste |satty -f -
