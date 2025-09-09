{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/apps.nix
    ./modules/docker.nix
    ./modules/rust.nix
    ./modules/bash.nix
    ./modules/nvpn.nix
  ];

  # Bootloader (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Netzwerk & Locale
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "de";

  # Proprietäre Pakete erlauben (für z.B. VSCode)
  nixpkgs.config.allowUnfree = true;

  # X11 + GNOME (ohne NVIDIA & ohne Wayland-Zwang)
  services.xserver.enable = true;
  services.xserver.xkb.layout = "de";
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;

  # Sinnvoll für VMs
  services.qemuGuest.enable = true;
  services.openssh.enable = true;  # Remote-Access, wenn du willst (lassen wir an)

  # User
  users.users.marvin = {
    isNormalUser = true;
    home = "/home/marvin";
    createHome = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    initialHashedPassword = ""; #ABÄNDERN
  };

  security.sudo = {
    enable = true;
    extraRules = [{
      users = [ "marvin" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }];
  };

  # Zertifikat-Umgebungsvariablen
  environment.variables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
    NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
    GIT_SSL_CAINFO = "/etc/ssl/certs/ca-bundle.crt";
  };

  # Praktisch (nix-command/flakes, ohne Overlays)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Nicht anfassen: Systemzustand
  system.stateVersion = "24.05";
}
