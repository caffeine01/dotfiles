{ inputs, pkgs, ... }:
{
    wayland.windowManager.hyprland = {
        plugins = [
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
        ];
        settings = {
        monitor = [
          "DP-1,preferred,auto,auto,bitdepth,10"
        ];
      };
    };
}
