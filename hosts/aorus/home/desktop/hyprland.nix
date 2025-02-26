{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
    ];
    settings = {
      monitor = [
        "DP-1,preferred,auto,auto,bitdepth,10"
      ];
      experimental = {
        xx_color_management_v4 = true;
        wide_color_gamut = true;
      };
    };
  };
}
