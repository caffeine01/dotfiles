{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.isaac;
in
{
  options.isaac = {
    enable = mkEnableOption "enable the preconfigured 'isaac' user.";
    useHomeManager = mkOption {
      type = types.bool;
      default = false;
    };
  };

  imports = [ ./user.nix ];

  config = mkIf cfg.enable {
    programs.fish.enable = true;
    userModule = {
      enableHomeManager = cfg.useHomeManager;
      homeManagerConfig = mkMerge [
        {
          imports = [
            (if config.host.common then ../common/home else null)
            (config.host.hostHome)
          ];
          commonHome.enable = config.host.common;
        }
      ];
      userName = "isaac";
      description = "ickle pickle sickle cell";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "adb"
        "libvirtd"
        "video"
        "adbusers"
      ];
      userPackages = with pkgs; [
        #nwg-drawer
        android-studio
        anyrun
        cargo
        clang
        clang-tools
        easyeffects
        evolution
        firefox
        foot
        fuzzel
        gh
        gnome-calendar
        gnome-control-center
        gnome-network-displays
        gnome-pomodoro
        gnome-tweaks
        gnomeExtensions.pop-shell
        grim
        grimblast
        jdk
        jetbrains.idea-community
        jetbrains.pycharm-community-bin
        jetbrains.rust-rover
        kanshi
        kitty
        libGL
        libreoffice
        lutris
        nodejs_23
        obs-studio
        obsidian
        openssl
        opentabletdriver
        osu-lazer-bin
        pamixer
        playerctl
        pwvucontrol
        remmina
        rustc
        rustup
        slurp
        tidal-hifi
        virglrenderer
        wineWowPackages.full
        winetricks
        wl-clipboard
        wlogout
        xournalpp
        ydotool
      ];
    };
  };
}
