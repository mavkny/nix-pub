{ config, pkgs, ... }:

{
  # OpenVPN minimal
  services.openvpn.servers.nordvpn = {
    autoStart = true;
    config = ''
      config /etc/openvpn/nordvpn.ovpn
      auth-user-pass /etc/openvpn/nordvpn-auth.txt
      persist-key
      persist-tun
    '';
  };

  # DNS schlicht global auf Nord setzen (systemd-resolved)
  services.resolved.enable = true;
  services.resolved.extraConfig = ''
    DNS=103.86.96.100 103.86.99.100
    Domains=~.
  '';
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
}

