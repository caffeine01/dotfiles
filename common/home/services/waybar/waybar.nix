{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  config = ./config/config.jsonc;
  style = ./config/style.css;
  uwsm = lib.getExe pkgs.uwsm;
  waybar = lib.getExe pkgs.waybar;
in
{
  systemd.user.services.waybar = {
    Unit = {
      After = [ "graphical-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Description = "waybar";
    };

    Service = {
      ExecStart = "${uwsm} app -- ${waybar} -c ${config} -s ${style}";
      Slice = "app-graphical.slice";
      Restart = "always";
      RestartSec = 10;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
