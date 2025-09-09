{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.autoPrune.dates = "weekly";
  # cgroup v2 ist Standard; nichts Spezielles nötig für VM.
}
