{ inputs, outputs, config, pkgs, lib, ... }: {

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--max-freed 1G --delete-older-than-7d";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "x86_64-linux";
    overlays = [(final: prev: {
      # workaround for rofi-wayland not picking up plugins from .override.plugins
      rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
    })];
  };

  system = {
    stateVersion = "24.05";
    autoUpgrade = {
      enable = true;
      flake = "/persist/etc/nixos/flake.nix";
      flags = [ "--update-input" "nixpkgs" ];
      allowReboot = false;
    };
  };

  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    supportedFilesystems = [ "vfat" "ntfs" "zfs" ];
    kernel.sysctl."kernel.perf_event_paranoid" = 1;
    loader = {
      timeout = 1;
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  zramSwap.enable=true;

  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    firewall.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
	xray = {
		enable = true;
		settingsFile = "/etc/xray/config.json";
	};
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
    };
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "zood";
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };
    chrony.enable = true;
    journald.extraConfig = ''
      SystemMaxUse=256M
      SystemKeepFree=256M
    '';
    emacs = {
      enable = true;
    };
  };

  systemd.services = {
	greetd = {
		serviceConfig = {
          Type = "idle";
          TTYReset = true;
          TTYVHangup = true;
          TTYVTDisallocate = true;
		};
	};
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  security = {
    sudo.wheelNeedsPassword = true;
    rtkit.enable = true;
	polkit.enable = true;
  };

  users = {
    mutableUsers = false;

    users = {
      root = {
        hashedPassword = "!"; 
      };
      zood = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "audio" ];
        hashedPasswordFile = "/persist/home/zood/password_hash";
        home = "/home/zood";
        createHome = false; 
      };
    };
  };

  time.timeZone = "Europe/Moscow";

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      iosevka
      roboto-mono
      roboto
      jetbrains-mono
      libre-baskerville
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
  };

  environment = {
    systemPackages = (import ./packages.nix) pkgs;
    etc."xdg/user-dirs.defaults".text = ''
      DOWNLOAD=downloads
      TEMPLATES=tmp
      PUBLICSHARE=/var/empty
      DOCUMENTS=tmp
      MUSIC=tmp
      PICTURES=downloads
      VIDEOS=tmp
      DESKTOP=/var/empty
    '';
  };
}
