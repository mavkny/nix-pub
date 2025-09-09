{ config, pkgs, ... }:

{
  networking.wg-quick.interfaces.nvpn = {
    configFile = "/etc/wireguard/nordlynx.conf";
    autostart = true;
  };

  services.resolved.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  networking.firewall.allowedUDPPorts = [ 51820 ];
}
