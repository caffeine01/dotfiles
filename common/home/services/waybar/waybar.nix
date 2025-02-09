 { inputs, pkgs, lib, ... }:
 let
   config = ./config/config.jsonc;
   style = ./config/style.css;
   waybar = lib.getExe pkgs.waybar;
 in 
 {
    systemd.user.services.waybar = {
      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "waybar";
      };

      Service = {
        ExecStart = "${waybar} -c ${config} -s ${style}";
        Restart = "always";
        RestartSec = "10";
      };
    };
 }
