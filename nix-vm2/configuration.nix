{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/bash.nix
    ./modules/apps.nix
  ];

  # UEFI, EFI unter /boot/efi
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # VM-Basics
  boot.initrd.kernelModules = [ "virtio_pci" "virtio_scsi" "virtio_blk" "virtio_net" ];
  networking.hostName = "casual-nix";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";

  # Locale + TTY-Layout
  i18n.defaultLocale = "de_DE.UTF-8";
  console = { keyMap = "de"; font = "Lat2-Terminus16"; };

  # Nix-Settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;     # nach erstem Login auf false!
      KbdInteractiveAuthentication = false;
    };
  };

  # QEMU-Guest (headless)
  services.qemuGuest.enable = true;

  # User
  users.users.marvin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bashInteractive;
    initialPassword = "Temp-1234";
  };

  security.sudo = {
    enable = true;
    extraRules = [{
      users = [ "marvin" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }];
  };

  boot.kernel.sysctl."kernel.sysrq" = 1;

  system.stateVersion = "25.05";
}
