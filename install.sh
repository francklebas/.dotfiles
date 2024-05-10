!#/bin/bash

sudo pacman -Syu -y

printf "Installing yay\n"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

printf "Installing stow\n"
sudo pacman -S stow zsh neovim ripgrep fd lazygit git curl make wget tmux firefox neovim docker alacritty i3-wm i3blocks i3status i3lock polybar picom dmenu rofi feh blueman bluez bluez-utils bluez-tools brightnessctl ttf-font-awesome font-manager dunst -y

printf "Installing tmux tmp\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf "Installing docker desktop\n"
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

printf "Installing oh-my-zsh\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
