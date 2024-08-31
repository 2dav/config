{ config, lib, pkgs, ... }:

{
  networking.hostName = "tower";
  networking.hostId = "9dbfde88";

  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    initrd = { 
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "zfs" ];
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/root@blank
        zfs rollback -r rpool/home@blank
      '';
    };
    zfs.devNodes = "/dev/disk/by-partlabel/rpool";

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [];
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      forceFullCompositionPipeline = true;
    };
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  services = {
    xserver = {
      videoDrivers = ["nvidia"];
    };
    zfs = {
      autoSnapshot.enable = true;
      autoScrub.enable = true;
	  trim.enable = true;
    };
  };

  fileSystems."/" =
    { device = "rpool/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "rpool/nix";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/persist" =
    { device = "rpool/persist";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/home" =
    { device = "rpool/home";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
      options = [ "defaults" "fmask=0077" "dmask=0077" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3d050ded-6a91-47ee-bc9e-5a07bdb480ac";
      fsType = "ext4";
      neededForBoot = true;
    };

  fileSystems."/etc/nixos" =
    { device = "/persist/etc/nixos";
      fsType = "none";
      options = [ "bind" ];
      depends = [ "/persist" ];
      neededForBoot = true;
    };

  fileSystems."/var/log" =
    { device = "/persist/var/log";
      fsType = "none";
      options = [ "bind" ];
      depends = [ "/persist" ];
      neededForBoot = true;
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4eee80be-0695-4c1e-9466-81c9d2ef1758"; }
    ];
}
