 { lib, pkgs, ... }:
 let
   uwsm = lib.getExe pkgs.uwsm;
   wlsunset = lib.getExe pkgs.wlsunset;
 in 
 {
    systemd.user.services.wlsunset = {
      Unit = {
        After=[ "graphical-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "wlsunset";
      };

      Service = {
        ExecStart = "${uwsm} app -- ${wlsunset} -S 09:00 -s 20:00";
        Slice = "background-graphical.slice";
        Restart = "always";
        RestartSec = 10;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
 }
