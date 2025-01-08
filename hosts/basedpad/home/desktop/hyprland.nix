{ inputs, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];
    settings = {
      misc.vfr = true;
      monitor = [
        "LVDS-1,1920x1080@60,0x0,1.25,vrr,1"          
      ];

      decoration = {
        shadow.enabled = lib.mkForce false;
	blur.enabled = lib.mkForce false;
      };

      animations.enabled = lib.mkForce false;
    };
  };
}
