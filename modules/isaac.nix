{ pkgs, lib, config, ... }:
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
          ../common/home
          ../hosts/envy/home
        ];
      }
    ];
    userName = "isaac";
    description = "ickle pickle sickle cell";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "adb" "libvirtd" "video" ];
    userPackages = with pkgs; [ 
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
      clang
      clang-tools
    ];
    };
  };
}