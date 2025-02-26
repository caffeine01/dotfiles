{ lib, ... }:
let
  blurrule = "opacity 0.9 override 0.9 override 1.0 override";
in
with lib;
{
  config = mkMerge [
    {
      wayland.windowManager.hyprland = {
        systemd.enable = false;
        settings = {

          experimental.xx_color_management_v4 = true;

          #thank u vaxry, very cool
          cursor = {
            warp_back_after_non_mouse_input = true;
          };

          env = [
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "XCURSOR_THEME,Adwaita"
            "XCURSOR_SIZE,24"
          ];

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

          input = {
            kb_layout = "us";
            follow_mouse = 1;
            touchpad = {
              natural_scroll = true;
            };
          };

          gestures = {
            workspace_swipe = true;
            workspace_swipe_cancel_ratio = 0.01;
            workspace_swipe_fingers = 3;
          };

          workspace = [
            "1, persistent:true"
            "2, persistent:true"
            "3, persistent:true"
            "4, persistent:true"
            "5, persistent:true"
            "6, persistent:true"
          ];

          general = {
            gaps_in = 4;
            gaps_out = 4;
            border_size = 2;
            "col.active_border" = "rgb(d65d0e) rgb(fe8019) rgb(ebdbb2) rgb(83a598) rgb(458588) 45deg";
            "col.inactive_border" = "rgb(3c3836)";
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          decoration = {

            rounding = 8;

            shadow = {
              enabled = true;
              color = "rgba(32,32,32,1)";
              ignore_window = false;
              offset = "0, 0";
              range = 8;
              render_power = 2;
              scale = 1;
            };

            blur = {
              enabled = true;
              size = 4;
              passes = 3;
            };
          };

          animations = {
            enabled = true;
            bezier = [
              "ease, 0.25, 0.1, 0.25, 1"
              "easeCirc, 0.85, 0, 0.15, 1"
              "easeIn, 0.42, 0, 1, 1"
              "easeOut, 0, 0, 0.58, 1"
            ];
            animation = [
              "border, 1, 1.5, ease"
              "borderangle, 1, 30, easeCirc, once"
              "fade, 1, 2, ease"
              "windows, 1, 2, ease, popin 80%"
              "windowsMove, 1, 2, easeOut"
              "workspaces, 1, 2, easeOut, slide"
            ];
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
            "${blurrule}, class:kitty"
            "${blurrule}, class:org.gnome.Nautilus"
            "${blurrule}, class:org.gnome.Calendar"
            "${blurrule}, class:obsidian"
            "noborder, floating:0, onworkspace:w[tv1]"
            "norounding, floating:0, onworkspace:w[tv1]"
            "plugin:hyprbars:nobar, onworkspace:m[negative:eDP-1]"
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

            "SUPER SHIFT,R,exec,hyprctl reload"
            "SUPER SHIFT,N,exec,reset-network"
            "SUPER SHIFT,Q,exec,uwsm stop"

            "SUPER,F,exec,nautilus"
            "SUPER,T,exec,kitty"
            "SUPER,W,exec,firefox"
            "SUPER,grave,exec,nwg-drawer --nofs"
            "SUPER,Y,exec,grimblast copy area"

            "SUPER,Q,killactive,"
            "SUPER SHIFT,F,fullscreen"
            "SUPER SHIFT,S,togglefloating,"
            "SUPER,C,centerwindow"

            "SUPER,left,movefocus,l"
            "SUPER,right,movefocus,r"
            "SUPER,up,movefocus,u"
            "SUPER,down,movefocus,d"
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
            "ignorealpha 0.9, waybar"
            "blur, nwg-drawer"
          ];

          bindm = [
            "SUPER,mouse:272,movewindow"
            "SUPER,mouse:273,resizewindow"
          ];

          plugin = {
            touch_gestures = {
              sensitivity = 10;
              hyprgrass-bind = [
                ", edge:r:u, exec, light -A 5"
                ", edge:r:d, exec, light -U 5"
                ", edge:d:u, exec, uwsm app -- nwg-drawer -closebtn -closebtnleft"
                ", swipe:3:u, overview:open"
                ", tap:3, overview:close"
              ];
              hyprgrass-bindm = [
                ", longpress:2, movewindow"
                ", longpress:3, resizewindow"
              ];
            };

            overview = {
              reverseSwipe = true;
            };

            hyprbars = {
              bar_height = 35;
              bar_color = "rgb(282828)";
              "col.text" = "rgb(ebdbb2)";
              bar_padding = 10;
              bar_button_padding = 10;
              bar_title_enabled = true;
              bar_text_align = "left";
              bar_part_of_window = true;
              bar_text_font = "Fira Code";
              hyprbars-button = [
                "rgb(282828), 25, , hyprctl dispatch killactive, rgb(ebdbb2)"
                "rgb(282828), 25, , hyprctl dispatch fullscreen, rgb(ebdbb2)"
                "rgb(282828), 25, 󰕔, hyprctl dispatch togglefloating, rgb(ebdbb2)"
              ];
            };

            #idk 2bwm seemed pretty cool
            borders-plus-plus = {
              "col.border_1" = "rgb(282828)";
              border_size_1 = 4;
              natural_rounding = 0;
            };
          };
        };
      };
    }
  ];
}
