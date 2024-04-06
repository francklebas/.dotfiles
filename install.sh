!#/bin/bash

sudo pacman -Syu -y

printf "Installing stow\n"
sudo pacman -S stow -y
stow .

printf "Installing JetBrains toolbox\n"
curl -L https://data.services.jetbrains.com/products/download?platform=linux&code=TBA | tar -xzvf - -C ~/Downloads
chmod +x ~/Downloads/jetbrains-toolbox-1.20.8804/jetbrains-toolbox

printf "Installing packages\n"
sudo pacman -S git zsh neovim tmux alacritty make ripgrep -y

printf "Installing oh-my-zsh\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf "Installing tmux tmp\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf "Installing nvm\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh
source ~/.zshrc


printf "Installing yay\n"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

printf "Installing flatpak\n"
sudo pacman -S flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.brave.Browser
flatpak install flathub com.google.Chrome
flatpak install flathub net.blix.BlueMail
flatpak install flathub com.spotify.Client
flatpak install flathub com.slack.Slack
flatpak install flathub org.videolan.VLC
flatpak install flathub io.gitlab.librewolf-community
flatpak install flathub com.transmissionbt.Transmission
flatpak install flathub org.gnome.Boxes
flatpak install flathub net.lutris.lutris
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.visualstudio.code

printf "Installing yay packages\n"
yay -S ttf-jetbrains-mono-nerd -y
yay -S enpass-bin -y

printf "Installing docker desktop\n"
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
