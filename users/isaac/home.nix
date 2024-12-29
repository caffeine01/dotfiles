{ pkgs, inputs, ... }:
{
  imports = [
    ./programs
    ./desktop
    ./services
    ../../common/home
  ];
  home.stateVersion = "24.11";
}
