{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    git
    neovim
    unzip
    xz
    coreutils
    wget
    pciutils
    tree
    htop
    zsh
    gnutar
  ];
}
