!#/bin/bash

sudo dnf update -y

printf "Installing packages\n"
sudo dnf install git evolution evolution-ews zsh neovim tmux alacritty make ripgrep curl -y
sudo chsh -s $($which zsh)

printf "Installing oh-my-zsh\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf "Installing tmux tmp\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf "Installing nvm\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh

printf "Installing flatpak\n"
sudo dnf install flatpak -y
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.brave.Browser
flatpak install flathub com.google.Chrome
flatpak install flathub com.spotify.Client
flatpak install flathub com.slack.Slack
flatpak install flathub org.videolan.VLC
flatpak install flathub io.gitlab.librewolf-community
flatpak install flathub com.transmissionbt.Transmission
flatpak install flathub org.gnome.Boxes
flatpak install flathub net.lutris.lutris
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.visualstudio.code

printf "Installing stow\n"
sudo dnf install stow -y
stow .

