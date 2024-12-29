{  pkgs, commonHomeManagerConfig ? {}, machineHomeManagerConfig ? {}, enableHomeManager ? false, ... }:

{

  imports = [ ./user.nix {
      inherit pkgs commonHomeManagerConfig machineHomeManagerConfig enableHomeManager;
      userName = "isaac";
      description = "ickle pickle sickle cell";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "adb" "libvirtd" "video" ];
            systemPackages = with pkgs; [ 
                    firefox
      obsidian
      jetbrains.rust-rover
      android-studio
      gnome-tweaks
      xournalpp
      jdk
      gh
      osu-lazer-bin
      jetbrains.pycharm-community-bin
      gnome-pomodoro
      gnomeExtensions.pop-shell
      easyeffects
      cargo
      rustc
      rustup
      openssl
      tidal-hifi
      wineWowPackages.full
      winetricks
      lutris
      libreoffice
      remmina
      gnome-network-displays
      opentabletdriver
      virglrenderer
      libGL
      kitty
      obs-studio
      nodejs_23
      grimblast
      slurp
      grim
      wl-clipboard
      pamixer
      playerctl
      ydotool
      tofi
      nwg-drawer
      waybar
      anyrun
      kanshi
      gnome-control-center
      gnome-calendar
      wlogout
      clangf
      clang-tools
            ];
          }
          ];
  programs.fish.enable = true;
}