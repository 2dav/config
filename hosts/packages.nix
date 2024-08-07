{pkgs, ...}: with pkgs; [
  busybox
  neovim nano tmux
  emacs 
  emacs-all-the-icons-fonts
  nix-index
  uutils-coreutils wget rsync
  telegram-desktop
  discord
  openssh
  git git-extras git-lfs
  zsh oh-my-zsh
  firefox
  ungoogled-chromium
  alacritty kitty
  htop
  unrar unzip
  ripgrep
  fd
  xdg-user-dirs
  grim

  rustup
  valgrind
  ghidra
  
  dunst
  libnotify
  libinput
  libwacom
  pavucontrol
  pulseaudio
  wl-clipboard
  copyq
  fish
  eza
  clang
  clang-tools
  zig
  fzf
  wine64
  pandoc

  (aspellWithDicts
          (dicts: with dicts; [ en en-computers en-science es ru ]))
  shellcheck

  (rofi-wayland.override {
    plugins = [ pkgs.rofi-calc ];
  })
  yambar
  hyprpaper
  waylock

  (callPackage ./pkgs/yambar-hyprland-wses-alpha.nix {})
  #yambar-hyprland-wses

  (import ./pkgs/backup-config.nix { inherit pkgs; })
]
