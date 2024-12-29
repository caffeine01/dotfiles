{ pkgs, inputs, ... }:
{
  imports = [
    ./programs
    ./desktop
    ./services
  ];

  home.stateVersion = "24.11";
}
