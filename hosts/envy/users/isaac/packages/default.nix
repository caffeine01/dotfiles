{ inputs, config, pkgs, ...}:
let 
      lid-switch = pkgs.callPackage ./lid-switch.nix {};
in 
{
    home.packages = [
      (lid-switch)
    ];
}
