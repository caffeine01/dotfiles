{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  hyprland-plugins = inputs.hyprland-plugins.packages.${pkgs.system};
in
{
  config.wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
      hyprland-plugins.hyprbars
      hyprland-plugins.borders-plus-plus
    ];
    settings = lib.mkMerge [
      {
        exec = [
          "systemctl --user restart kanshi"
          "systemctl --user restart iio-hyprland"
        ];
        monitor = [
          "HDMI-A-1,preferred,1920x0,auto-right,bitdepth,10"
          "eDP-1,1920x1080@60,0x0,1"
        ];
        windowrulev2 = [
          "plugin:hyprbars:nobar, onworkspace:m[HDMI-A-1]"
        ];
        device = [
          {
            name = "elan2513:00-04f3:4178";
            output = "eDP-1";
          }
          {
            name = "elan2513:00-04f3:4178-stylus";
            output = "eDP-1";
          }
        ];
        bindl = [
          ",switch:Lid Switch,exec,lid-switch"
        ];
      }
    ];
  };
}
