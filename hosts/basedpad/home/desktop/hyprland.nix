{ inputs, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];
    settings = {
      misc.vfr = true;
      monitor = [
        "LVDS-1,1600x900@60,0x0,1,vrr,1"          
      ];

      decoration = {
        shadow.enabled = lib.mkForce false;
	blur.enabled = lib.mkForce false;
      };

      animations.enabled = lib.mkForce false;
    };
  };
}
