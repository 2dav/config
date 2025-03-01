{ inputs, config, lib, pkgs, ... }:
{
  environment.persistence."/persist" = {
      directories = [
        "/etc/nixos"
		"/etc/xray"
        "/etc/NetworkManager/system-connections"
        "/var/lib/chrony"
      ];

      users.zood = {
        directories = [
          "org"
          "notes"
          "papers"
          "dev"
          
          ".ssh"
          ".config/hypr"
          ".config/yambar"
          ".config/fish"
          ".config/tmux"
          ".config/base16"
          ".config/alacritty"
          ".config/nvim"
          ".config/emacs"
          ".config/doom"

          ".wine"
          ".local/share/applications/wine"
          
          ".rustup"
          ".cargo"
          
          ".local/share/fish"
          ".local/share/kicad"
          ".thunderbird"
        ];  
        files = [
          ".gitconfig"
        ];
      };
  };

  environment.etc."machine-id".source = "/persist/etc/machine-id";
}
