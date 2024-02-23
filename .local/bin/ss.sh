#!/bin/sh
# WWW          : https://github.com/wwwsensor/dotfiles
# Author       : @sensor @ss
# Dependencies : paru git
#
# Setup my environment.

n=/dev/null

# Handle errors
senderr(){ echo ss.sh: "$@";exit 1; }

# Handle dependencies
for sw in paru git
do
  which $sw >$n 2>&1 || senderr $sw not found
done

# Select proper elevation method
which doas >$n && alias s=sudo || alias s=doas

# Repo cloning
echo Cloning repos...
for repo in bg nvim
do
  git clone https://github.com/wwwsensor/$repo ~/.config/$repo >$n 2>&1 || echo \~/.config/$repo already exists
done

# SW install
echo Installing packages...
shell="zsh zsh-syntax-highlighting zsh-history-substring-search github-cli lsd man git ddgr pfetch-rs-bin git-credential-oauth cmake cht.sh luarocks yt-dlp npm yazi ueberzugpp"
gui="pipewire-pulse pipewire-media-session swaybg tofi waylock playerctl pamixer qutebrowser grim slurp"
files="bat imagemagick jq ffmpegthumbnailer unar mpv neovim zathura-pdf-poppler swayimg gnome-keyring"
sys="artix-archlinux-support mimi xdg-desktop-portal-wlr python-adblock wl-clipboard noto-fonts-emoji"
apps="discord vencord-installer-cli-bin alacritty"
paru --useask --noconfirm --needed -Sy $shell $gui $files $sys $apps >$n 2>&1

# Final message
echo
echo AMD driver for HW acceleration: libva-mesa-driver
