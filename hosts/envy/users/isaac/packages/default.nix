{ inputs, config, pkgs, ...}:
let 
      set-wallpapers = pkgs.callPackage ./set-wallpapers.nix {};
      lid-switch = pkgs.callPackage ./lid-switch.nix {};
in 
{
    home.packages = [
      (set-wallpapers)
      (lid-switch)
    ];
}
