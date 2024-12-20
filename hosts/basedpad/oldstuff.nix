  systemd.user.services.restart-gnome-extension = {
    description = "Restart GNOME extension";
    serviceConfig = {
      ExecStart = "${pkgs.writeShellScriptBin "restart-gnome-extension" ''
        ${pkgs.gnome-shell}/bin/gnome-extensions disable screen-rotate@shyzus.github.io
        ${pkgs.gnome-shell}/bin/gnome-extensions enable screen-rotate@shyzus.github.io
      ''}/bin/restart-gnome-extension";
      Type = "oneshot";
    };
  };

  systemd.user.services."org.gnome.Shell@wayland" = {
    overrideStrategy = "asDropin";
    path = lib.mkForce [];
    serviceConfig = {
      Environment = [
        ""
        "MUTTER_DEBUG_SESSION_MANAGEMENT_PROTOCOL=1"
      ];
      ExecStart = [
        ""
        "${pkgs.gnome-shell}/bin/gnome-shell --debug-control"
      ];
    };
  };
