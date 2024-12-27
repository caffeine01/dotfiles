{ config, pkgs, lib, inputs, ... }:
{

    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    programs.home-manager.enable = true;

        home-manager = {
        extraSpecialArgs = {
            inherit inputs;
        };
        users = {
            "isaac" = import ./home.nix;
        };
        useGlobalPkgs = true;
        useUserPackages = true;
    };


  users.users.isaac = {
    isNormalUser = true;
    description = "isaac";
    extraGroups = [ "wheel" "adb" "libvirtd" "video" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
      obsidian
      jetbrains.idea-community
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
}
