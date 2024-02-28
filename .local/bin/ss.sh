#!/bin/sh
# WWW          : https://github.com/wwwsensor/dotfiles
# Author       : @sensor @ss
# Dependencies : paru git
#
# Setup my environment.

N=/dev/null

# Handle errors
senderr(){ echo ss.sh: "$@";exit 1; }

# Handle dependencies
for SW in paru git
do
  which $SW >$N 2>&1 || senderr $SW not found
done

# Select proper elevation method
which doas >$N && alias s=sudo || alias s=doas

# Repo cloning
echo Cloning repos...
{
git clone https://github.com/wwwsensor/pm ~/.local/bin/passm && ln -s ~/.local/bin/passm/pm ~/.local/bin/pm
for repo in bg nvim
do
  git clone https://github.com/wwwsensor/$repo ~/.config/$repo || echo \~/.config/$repo already exists
done
} >$N 2>&1

# SW install
echo Installing packages...
SW="
zsh zsh-syntax-highlighting zsh-history-substring-search lsd man tealdeer git ddgr pfetch-rs-bin
git-credential-oauth cmake cht.sh luarocks yt-dlp npm yazi ueberzugpp pipewire-pulse wireplumber
swaybg tofi waylock playerctl pamixer qutebrowser grim slurp xwaylandvideobridge bat imagemagick
jq ffmpegthumbnailer unar mpv neovim zathura-pdf-poppler swayimg gnome-keyring noto-fonts-emoji
artix-archlinux-support mimi xdg-desktop-portal-hyprland xdg-desktop-portal-gtk python-adblock
vencord-installer-cli-bin alacritty wl-clipboard discord
"
paru --noconfirm --needed -Sy $SW >$N 2>&1

# Final message
echo
echo AMD driver for HW acceleration: libva-mesa-driver
