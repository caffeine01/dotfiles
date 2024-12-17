{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./home.nix
  ];

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
