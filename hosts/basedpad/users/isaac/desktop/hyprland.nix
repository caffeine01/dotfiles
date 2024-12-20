
{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

{
  config = {
    wayland.windowManager.hyprland = {
      systemd.enable = false;
      plugins = [
          inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
          #"/etc/nixos/hosts/envy/hyprbars.so"
          inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      ];

      settings = {

        #thank u vaxry, very cool
        cursor = {
          warp_back_after_non_mouse_input = true; 
        };

        debug = {
          disable_logs = false;
        };

        env = [
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "XCURSOR_THEME,Adwaita"
          "XCURSOR_SIZE,24"
        ];

        exec-once = [
          "uwsm finalize"
          "dbus-update-activation-environment --systemd --all"
          "dunst"
        ];

        exec = [
          "systemctl --user restart kanshi"
          "systemctl --user restart iio-hyprland"
          "systemctl --user restart hyprpaper"
          "systemctl --user restart waybar"
          "systemctl --user restart wlsunset"
        ];

        monitor = [
          "HDMI-A-1,preferred,1920x0,auto-right,bitdepth,10"
          "eDP-1,1920x1080@60,0x0,1"
        ];

        workspace = [
          "1, persistent:true"
          "2, persistent:true"
          "3, persistent:true"
          "4, persistent:true"
          "5, persistent:true"
          "6, persistent:true"
        ];

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
          };
        };
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

        general = {
          gaps_in = 4;
          gaps_out = 4;
          border_size = 2;
          "col.active_border" = "rgb(3c3836)";
          "col.inactive_border" = "rgb(282828)";
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        decoration = {

          rounding = 8;

          shadow = {
            enabled = true;
            color = "rgba(000000BB)";
            ignore_window = true;
            offset = "0, 0";
            range = 100;
            render_power = 2;
            scale = 0.9;
          };

          blur = {
            enabled = true;
            size = 5;
          };
        };

        animations = {
          enabled = true;
          animation = [
            "border, 1, 2, default"
            "fade, 1, 4, default"
            "windows, 1, 3, default, popin 80%"
            "workspaces, 1, 2, default, slide"
          ];
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_cancel_ratio = 0.01;
          workspace_swipe_fingers = 3;
        };

        xwayland = {
          force_zero_scaling = true;
        };

        misc = {
          disable_hyprland_logo = true;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
        };

        windowrulev2 = [
          "noborder, onworkspace:w[tv1] f[-1], floating:0"
          "plugin:hyprbars:nobar, onworkspace:m[^(?!eDP-1$).*$]"
        ];

        bind = [
          "SUPER,1,workspace,1"
          "SUPER,2,workspace,2"
          "SUPER,3,workspace,3"
          "SUPER,4,workspace,4"
          "SUPER,5,workspace,5"
          "SUPER,6,workspace,6"
          "SUPER SHIFT,1,movetoworkspace,1"
          "SUPER SHIFT,2,movetoworkspace,2"
          "SUPER SHIFT,3,movetoworkspace,3"
          "SUPER SHIFT,4,movetoworkspace,4"
          "SUPER SHIFT,5,movetoworkspace,5"
          "SUPER SHIFT,6,movetoworkspace,6"
          "SUPER,mouse_down,workspace,e+1"
          "SUPER,mouse_up,workspace,e-1"
          "SUPER,Q,killactive,"
          "SUPER SHIFT,Q,exec,uwsm stop"
          "SUPER,F,exec,nautilus"
          "SUPER,T,exec,kitty"
          "SUPER,W,exec,firefox"
          "SUPER SHIFT,S,togglefloating,"
          "SUPER,left,movefocus,l"
          "SUPER,right,movefocus,r"
          "SUPER,up,movefocus,u"
          "SUPER,down,movefocus,d"
          "SUPER SHIFT,F,fullscreen"
          "SUPER,C,centerwindow"
          "SUPER SHIFT,R,exec,hyprctl reload"
          "SUPER,grave,exec,nwg-drawer"
          "SUPER,Y,exec,grimblast copy area"

          "SUPER SHIFT,left,movewindow,l"
          "SUPER SHIFT,right,movewindow,r"
          "SUPER SHIFT,up,movewindow,u"
          "SUPER SHIFT,down,movewindow,d"

          ", XF86AudioRaiseVolume, exec, pamixer -i 5"
          ", XF86AudioLowerVolume, exec, pamixer -d 5"
          ", XF86AudioMicMute, exec, pamixer --default-source -m"
          ", XF86AudioMute, exec, pamixer -t"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        layerrule = [
          "blur, waybar"
          "blur, nwg-drawer"
        ];

        bindm = [
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
        ];

        bindl = [
          ",switch:Lid Switch,exec,lid-switch"
        ];

        plugin = {
          touch_gestures = {
            sensitivity = 10;
            hyprgrass-bind = [
              ", edge:r:l, workspace, +1"
              ", edge:d:u, exec, nwg-drawer"
              #", tap:1, exec, ydotool click 0xC0"
              ", swipe:3:u, overview:open"
              ", tap:3, overview:close"
            ];
            hyprgrass-bindm = [
              ", longpress:2, movewindow"
              ", longpress:3, resizewindow"
            ];
            experimental = {
              send_cancel = 1;
            };
          };

          overview = {
            reverseSwipe = true;
          };

          hyprbars = {
            # example config
            bar_height = 35;
            bar_color = "rgb(282828)";
            "col.text" = "rgb(ebdbb2)";
            bar_padding = 10;
            bar_button_padding = 10;
            bar_title_enabled = true;
            bar_text_align = "left";
            bar_part_of_window = true;
            bar_text_font = "Fira Code";

            # example buttons (R -> L)
            # hyprbars-button = color, size, on-click
            hyprbars-button = [
              "rgb(3c3836), 25, , hyprctl dispatch killactive, rgb(ebdbb2)"
              "rgb(3c3836), 25, , hyprctl dispatch fullscreen, rgb(ebdbb2)"
              "rgb(3c3836), 25, 󰕔, hyprctl dispatch togglefloating, rgb(ebdbb2)"
            ];
          };
        };
      };
    };
  };
}
