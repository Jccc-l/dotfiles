# Archlinux

## partition

```shell
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @boot
btrfs subvolume create @swapfile
mount /dev/sdb5 -o compress=zstd:3,noatime,ssd,discard=async,autodefrag,subvol=@ /mnt/Arch --mkdir
mount /dev/sdb5 -o compress=zstd:3,noatime,ssd,discard=async,autodefrag,subvol=@home /mnt/Arch/home --mkdir
mount /dev/sdb5 -o compress=zstd:3,noatime,ssd,discard=async,autodefrag,subvol=@boot /mnt/Arch/boot --mkdir
mount /dev/sdb5 -o compress=zstd:3,noatime,ssd,discard=async,autodefrag,subvol=@swapfile /mnt/Arch/swapfile --mkdir
mount /dev/sdb4 /mnt/Arch/boot/efi
```

## Install Basic Packages

```shell
pacstrap -K /mnt/Arch base linux-zen linux-zen-headers linux-firmware networkmanager zsh neovim grub os-prober efibootmgr git base-devel intel-ucode man btrfs-progs sudo ntfs-3g
```

mount information

```shell
genfstab -U /mnt/Arch >> /mnt/Arch/etc/fstab
```

```shell
arch-chroot /mnt/Arch
```

Location

```
en_US.UTF-8 UTF-8
```

```conf locale.conf
LANG=en_US.UTF-8
```

```shell
locale-gen
```

Network:hostname

```/etc/hostname
jccc-desktop
```

```
sudo systemctl enable NetworkManager --now
```

```shell
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
```

```shell
mkinitcpio -P
```

```
passwd
```

Create a normal user with home directory

```shell
useradd -m jccc
passwd jccc
```

visudo

```
# %wheel ALL=(ALL:ALL) ALL
jccc ALL=(ALL:ALL) ALL
```

grub-install --target=x86_64-efi --efi-directory=/boot/efi --removable

## 软件仓库

```conf pacman.conf
[options]
Color
ILoveCandy
ParallelDownloads = 12

[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

导入GPG key

```shell
pacman -Syyu archlinuxcn-keyring
```

安装`yay`

```shell
sudo pacman -S yay
```

## Desktop Environment

```shell
sudo pacman -S niri
```

sudo pacman -S ghostty fuzzel

AUR: google-chrome-dev

sudo pacman -S libinput-tools

sudo pacman -S unzip

sudo pacman -S wget

sudo pacman -S lsd

sudo pacman -S nodejs npm

## Input Method

```
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki fcitx5-nord
```

set environment

## 壁纸

```shell
sudo pacman -S awww
```

```shell
yay -S waypaper
```

awww作为壁纸后端渲染引擎，waypaper作为前端

## Github 加速

[Github520](https://github.com/521xueweihan/GitHub520)

## 音频设置

在使用部分窗口管理器时，安装了`pipewire`包，目标是取代PulseAudio，但是大量应用程序只连接到PulseAudio库，需要安装`pipewire-pulse`来接收应用的PulseAudio请求，并将音频流交给PipeWire处理

```
sudo pacman -S pipewire-pulse wireplumber
```

然后启用PipeWire相关的服务

```
jccc-desktop% systemctl enable --now --user pipewire pipewire-pulse wireplumber
```

```
Created symlink '/home/jccc/.config/systemd/user/default.target.wants/pipewire.service' → '/usr/lib/systemd/user/pipewire.service'.
Created symlink '/home/jccc/.config/systemd/user/sockets.target.wants/pipewire.socket' → '/usr/lib/systemd/user/pipewire.socket'.
Created symlink '/home/jccc/.config/systemd/user/default.target.wants/pipewire-pulse.service' → '/usr/lib/systemd/user/pipewire-pulse.service'.
Created symlink '/home/jccc/.config/systemd/user/sockets.target.wants/pipewire-pulse.socket' → '/usr/lib/systemd/user/pipewire-pulse.socket'.
Created symlink '/home/jccc/.config/systemd/user/pipewire-session-manager.service' → '/usr/lib/systemd/user/wireplumber.service'.
Created symlink '/home/jccc/.config/systemd/user/pipewire.service.wants/wireplumber.service' → '/usr/lib/systemd/user/wireplumber.service'.
```

## Bluetooth

sudo pacman -S bluez bluetui

sudo systemctl enable bluetooth --now

## Utils

sudo pacman -S ripgrep fzf chafa

chafa负责提供终端显示图片

```shell
sudo pacman -S polkit-kde-agent
```

polkit 授予非特权应用程序访问特权操作的权限
