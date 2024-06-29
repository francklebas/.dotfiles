!#/bin/bash

sudo pacman -Syu -y

printf "Installing yay\n"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

printf "Installing stow\n"
sudo pacman -S btop htop neofetch stow zsh vim neovim ripgrep fd lazygit git curl make wget tmux firefox neovim alacritty i3-wm i3blocks i3status i3lock polybar picom dmenu rofi feh blueman bluez bluez-utils bluez-tools brightnessctl ttf-font-awesome font-manager dunst xorg-xrandr pavucontrol -y

printf "Installing tmux tmp\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf "Installing aur packages\n"
yay docker-desktop
yay google-chrome
yay brave-bin
yay enpass-bin
yay slack-desktop
yay pika-backup
yay timeshift
yay vlc

printf "Installing oh-my-zsh\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
