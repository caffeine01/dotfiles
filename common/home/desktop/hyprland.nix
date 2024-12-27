{
  config = {
    wayland.windowManager.hyprland = {
      settings = {
        #thank u vaxry, very cool
        cursor = {
          warp_back_after_non_mouse_input = true;
        };
                exec-once = [
                  "uwsm finalize"
                  "dbus-update-activation-environment --systemd --all"
                ];

                exec = [
                  "systemctl --user restart hyprpaper"
                  "systemctl --user restart waybar"
                  "systemctl --user restart wlsunset"
                ];

                monitor = [
                  ", preferred, auto, 1"
                ];
      };
    };
  };
}