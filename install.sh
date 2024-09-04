!#/bin/bash

sudo pacman -Syu

printf "Installing yay\n"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..

printf "Installing aur packages\n"
yay -S --needed git btop htop neofetch stow pass zsh vim neovim ripgrep fd lazygit git curl make wget tmux firefox neovim alacritty i3-wm i3blocks i3status i3lock polybar picom dmenu rofi feh blueman bluez bluez-utils bluez-tools brightnessctl ttf-font-awesome font-manager dunst xorg-xrandr pavucontrol power-profiles-daemon docker docker-desktop google-chrome brave-bin enpass-bin slack-desktop pika-backup timeshift vlc starship nvm powertop wl-clipboard pre-commit grim slurp lazyvim-git nvm lazygit-git kaychain wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader xclip fzf arp nmap feh mkcert ttf-ms-win10-auto mesa lib32-mesa vulkan-radeon amdvlk lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau tldr vkd3d lib32-vkd3d faudio lib32-faudio protonup-qt lutris steam gamemode lib32-gamemode -y

printf "Installing tmux tmp\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf "Installing oh-my-zsh\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf "Copy configs\n"
rm ~/.zshrc && stow .

printf "Done! Don't forget to create backups!!!"
printf "https://youtu.be/V1wxgWU0j0E"
