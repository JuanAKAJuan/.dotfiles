# Juan's Dotfiles

### Using stow to manage them now
```bash
stow .
```

### Change default shell to zsh
```bash
chsh -s $(which zsh)
```

### Commands to Generate Github SSH Key
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Multimedia (Fedora)
https://rpmfusion.org/Howto/Multimedia

### Applications to install
- stow
- zsh
- zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
- zsh-vi-mode (git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zsh-vi-mode)
- fastfetch / neofetch
- nodejs
- npm
- fd
- ripgrep
- btop
- zoxide
- eza
- tmux
- starship (curl -sS https://starship.rs/install.sh | sh)
- neovim
- wezterm
- discord
- bat
- steam
- ktorrent
- mullvadvpn
- webkit2gtk4.0
- jellyfin
- Jetbrains Nerd Font (https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip)

### Magnifier for i3
https://github.com/tsoding/boomer

#### i3 / awesome Applications
- i3
- i3status
- awesome
- picom
- dunst
- rofi
- nwg-look
- maim
- pasystray
- thunar
- nwg-look
- qt5ct
- qt6ct
- gnome-themes-extra
- adwaita-qt5
- adwaita-qt6
- flameshot (for screenshotting)
