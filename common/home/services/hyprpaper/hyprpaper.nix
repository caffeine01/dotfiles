 { inputs, pkgs, lib, ... }:
 let
   wallpaper = ./wall.png;
   configFile = pkgs.writeText "hyprpaper.conf"
   ''
   preload = ${wallpaper}
   wallpaper = ,${wallpaper}
   '';
   hyprpaper = lib.getExe inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.hyprpaper;
 in 
 {
    systemd.user.services.hyprpaper = {
      Install = { WantedBy = [ "graphical-session.target" ]; };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "hyprpaper";
      };

      Service = {
        ExecStart = "${hyprpaper} -c ${configFile}";
        Restart = "always";
        RestartSec = "10";
      };
    };
 }
