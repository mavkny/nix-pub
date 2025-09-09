{ config, pkgs, ... }:

{
  services.openvpn.servers.nordvpn = {
    autoStart = true;
    updateResolvConf = true;

    config = ''
      config /etc/openvpn/nordvpn.ovpn
      auth-user-pass /etc/openvpn/nordvpn-auth.txt
      persist-key
      persist-tun
      verb 3
    '';
  };

  services.resolved.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  networking.firewall.allowedUDPPorts = [ 1194 ];
}
