 { inputs, pkgs, lib, ... }:
 let
    wallpaper = ./wall.png;
    configFile = pkgs.writeText "hyprpaper.conf"
    ''
    preload = ${wallpaper}
    wallpaper = ,${wallpaper}
    '';
    uwsm = lib.getExe pkgs.uwsm;
    hyprpaper = lib.getExe inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.hyprpaper;
 in 
 {
    systemd.user.services.hyprpaper = {
      Unit = {
        After = [ "graphical-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "hyprpaper";
      };

      Service = {
        ExecStart = "${uwsm} app -- ${hyprpaper} -c ${configFile}";
        Slice = "background-graphical.slice";
        Restart = "always";
        RestartSec = 10;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
 }
