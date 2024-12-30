{ inputs, pkgs, ... }:
{
    wayland.windowManager.hyprland = {
        plugins = [
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
        ];
        settings = {
          misc = {
            vfr = true;
          };
          monitor = [
            "LVDS-1,1920x1080@60,0x0,1"          
          ];

          decoration = {
            shadow.enabled = false;
            blur.enabled = false;
            animations.enabled = false;
          }
      };
    };
}
