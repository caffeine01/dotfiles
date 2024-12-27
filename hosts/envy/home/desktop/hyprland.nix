{ inputs, pkgs, ... }:
{
  config = {
    wayland.windowManager.hyprland = {
      plugins = [
          inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
          #"/etc/nixos/hosts/envy/hyprbars.so"
          inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      ];

      settings = {
                exec = [
                  "systemctl --user restart kanshi"
                  "systemctl --user restart iio-hyprland"
                ];

                monitor = [
                  "HDMI-A-1,preferred,1920x0,auto-right,bitdepth,10"
                  "eDP-1,1920x1080@60,0x0,1"
                ];

                          # Built in HP touch shit
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
      };
    };
  };
}