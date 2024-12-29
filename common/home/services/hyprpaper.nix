 { inputs, pkgs, lib, ... }:
 let
   configFile = pkgs.writeText "hyprpaper.conf"
   ''
   preload = /home/isaac/Documents/houseonthesideofalake.jpg
   wallpaper = ,/home/isaac/Documents/houseonthesideofalake.jpg
   '';
   hyprpaper = lib.getExe inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.hyprpaper;
 in 
 {
    systemd.user.services.hyprpaper = {
      Install = { WantedBy = [ "graphical-session.target" ]; };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "hyprpaper";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${hyprpaper} -c ${configFile}";
        Restart = "always";
        RestartSec = "10";
      };
    };
 }
