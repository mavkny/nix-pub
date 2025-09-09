{ config, pkgs, ... }:

{
  services.openvpn.servers.nordvpn = {
    autoStart = true;

    config = ''
      config /etc/openvpn/nordvpn.ovpn
      auth-user-pass /etc/openvpn/nordvpn-auth.txt
      persist-key
      persist-tun
      verb 3

      # Wichtig: DNS explizit setzen
      script-security 2
      up /etc/openvpn/update-systemd-resolved
      down /etc/openvpn/update-systemd-resolved
      down-pre
    '';
  };

  # DNS über systemd-resolved
  services.resolved.enable = true;

  # sicherstellen, dass systemd-resolved für alles genutzt wird
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  # Firewall
  networking.firewall.allowedUDPPorts = [ 1194 ];
}
