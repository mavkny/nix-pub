{ pkgs, ... }:
{
  environment.gnome.excludePackages = with pkgs; [
    epiphany          
    geary             
    simple-scan       
    totem             
    seahorse          
    yelp              
    gnome-software    
    gnome-maps
    gnome-music
    gnome-weather
    gnome-clocks
    gnome-contacts
    gnome-calendar
    gnome-tour
  ];

  environment.systemPackages = with pkgs; [
    # Browser & Kommunikation (ohne Thunderbird/OBS)
    firefox
    nextcloud-client
    keepassxc

    # Entwicklung & Tools
    vscode
    bruno
    neovim
    git
    curl
    htop
    tree
    xz
    unzip
    coreutils
    pciutils
    cacert
    openssl
    wget
  ];
}
