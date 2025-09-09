{ pkgs, ... }:
{
  # Stabil & wartungsarm: nixpkgs-Toolchain statt rustup
  environment.systemPackages = with pkgs; [
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    pkg-config
    openssl   # inkl. -dev Headers in NixOS
  ];

}
