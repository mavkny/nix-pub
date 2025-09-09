{ config, pkgs, ... }:

{
  # OpenVPN-Service für NordVPN
  services.openvpn.servers.nordvpn = {
    # Lies deine heruntergeladene .ovpn Datei ein
    config = builtins.readFile "/etc/openvpn/nordvpn.ovpn";

    autoStart = true;         # startet beim Booten
    updateResolvConf = true;  # setzt DNS automatisch

    extraConfig = ''
      # Hier wird auf deine Credentials-Datei verwiesen
      auth-user-pass /etc/openvpn/nordvpn-auth.txt
      persist-key
      persist-tun
      verb 3
    '';
  };

  # DNS über systemd-resolved
  services.resolved.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  # Firewall kann so bleiben; UDP-Port 1194 ist Standard für NordVPN
  networking.firewall.allowedUDPPorts = [ 1194 ];
}
