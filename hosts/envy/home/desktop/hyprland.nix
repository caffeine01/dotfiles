{ inputs, pkgs, lib, ... }: {
  config.wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
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
          "plugin:hyprbars:nobar, onworkspace:m[^(?!eDP-1$).*$]"
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
