{ pkgs, ...}:
let 
      lid-switch = pkgs.callPackage ./packages/lid-switch.nix {};
in 
{   

    imports = [
      ./desktop
      ./programs
      ./services
    ];

    home.packages = [
      (lid-switch)
    ];
}
