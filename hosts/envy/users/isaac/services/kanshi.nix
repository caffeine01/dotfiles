{ pkgs, inputs, ... }:
let
  laptopworkspaces = "${pkgs.writeShellScriptBin "laptopworkspaces" ''
  hyprctl --batch "dispatch moveworkspacetomonitor 1 eDP-1; dispatch moveworkspacetomonitor 2 eDP-1; dispatch moveworkspacetomonitor 3 eDP-1; dispatch moveworkspacetomonitor 4 eDP-1; dispatch moveworkspacetomonitor 5 eDP-1; dispatch moveworkspacetomonitor 6 eDP-1;"
  ''}/bin/laptopworkspaces";
  dualdisplayworkspaces = "${pkgs.writeShellScriptBin "dualdisplayworkspaces" ''
  hyprctl --batch "dispatch moveworkspacetomonitor 1 HDMI-A-1; dispatch moveworkspacetomonitor 2 HDMI-A-1; dispatch moveworkspacetomonitor 3 HDMI-A-1; dispatch moveworkspacetomonitor 4 HDMI-A-1; dispatch moveworkspacetomonitor 5 HDMI-A-1; dispatch moveworkspacetomonitor 6 HDMI-A-1; "
  ''}/bin/dualdisplayworkspaces";
  externalworkspaces = "${pkgs.writeShellScriptBin "externalworkspaces" ''
  hyprctl --batch "dispatch moveworkspacetomonitor 1 HDMI-A-1; dispatch moveworkspacetomonitor 2 HDMI-A-1; dispatch moveworkspacetomonitor 3 HDMI-A-1; dispatch moveworkspacetomonitor 4 HDMI-A-1; dispatch moveworkspacetomonitor 5 HDMI-A-1; dispatch moveworkspacetomonitor 6 HDMI-A-1; "
  ''}/bin/externalworkspaces";
  dual-display = "${pkgs.writeShellScriptBin "dual-display" ''
          #!/usr/bin/env bash

        lid_state=$(cat /proc/acpi/button/lid/LID/state)
        if [[ "$lid_state" == *"closed"* ]]; then
          kanshictl switch external-only
        else 
          exec "${dualdisplayworkspaces}"
        fi
  ''}/bin/dual-display";
in
{
  systemd.user.services.kanshi = {
    Service = {
        ExecStart = ''${pkgs.kanshi}/bin/kanshi'';
    };
  };

    services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
      settings = [
      {
        profile = {
          name = "laptop-only";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              mode = "1920x1080@60Hz";
            }
          ];
          exec = (laptopworkspaces);
        };
      }

     {
        profile = {
          name = "dual-display";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              mode = "1920x1080@60Hz";
            }
            {
              criteria = "HDMI-A-1";
              status = "enable";
            }
          ];
          exec = (dual-display);
        };
      }

      {
        profile = {
          name = "external-only";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
              mode = "1920x1080@60Hz";
            }
            {
              criteria = "HDMI-A-1";
              status = "enable";
            }
          ];
          exec = (externalworkspaces);
        };
      }
    ];
  };
}
