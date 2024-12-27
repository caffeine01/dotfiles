{ pkgs, inputs, ... }:
{
  imports = [
    ./programs
    ./desktop
    ./services
    ../../common/home
  ];
}
