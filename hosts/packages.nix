{pkgs, ...}: with pkgs; [
  busybox
  nix-index
  uutils-coreutils wget rsync
  openssh
  git git-extras git-lfs
  unrar unzip

  libnotify
  libinput
  libwacom
  zlib
  inotify-tools

  eza
  fzf
  wine64
  pandoc
  ripgrep
  fd
  htop
  bat
  poppler_utils
  xray
  lxqt.lxqt-policykit
  awscli2

  grim
  dunst
  pavucontrol
  pulseaudio
  copyq
  zsh oh-my-zsh
  fish
  alacritty kitty
  slurp

  kicad
  qucs-s
  valgrind
  ghidra

  clang
  clang-tools
  rustup
  zig
  nodejs_22 yarn
  pyright

  telegram-desktop
  discord
  firefox
  ungoogled-chromium
  thunderbird

  neovim nano tmux
  emacs 
  emacs-all-the-icons-fonts

  xdg-user-dirs
  (aspellWithDicts
          (dicts: with dicts; [ en en-computers en-science es ru ]))
  shellcheck
  (rofi-wayland.override {
    plugins = [ pkgs.rofi-calc ];
  })
  yambar
  hyprpaper
  waylock
  wl-clipboard
  (callPackage ./pkgs/yambar-hyprland-wses-alpha.nix {})
  #yambar-hyprland-wses

  (import ./pkgs/backup-config.nix { inherit pkgs; })
]
