{ pkgs, inputs, config, lib, ...}:
let
  cfg = config.commonHome;
  lid-switch = pkgs.callPackage ./packages/lid-switch.nix {};
in 
with lib;
{
  imports = [
    ./desktop
    ./programs
    ./services
  ];

  options.commonHome = {
    enable = mkEnableOption "Enables the common home-manager configuration.";
  };

  config = mkMerge [(mkIf cfg.enable {
      wayland.windowManager.hyprland.enable = true;
      wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      wayland.windowManager.hyprland.systemd.variables = ["--all"];

      home.sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland";
        XDG_SESSION_TYPE = "wayland";
      };

      home.packages = [
        inputs.nwg-drawer.packages.${pkgs.system}.default
        (lid-switch)
      ];
    }
  )];
}
