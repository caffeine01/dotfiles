{ pkgs, inputs, ...}:
let 
      lid-switch = pkgs.callPackage ./packages/lid-switch.nix {};
in 
{   
    imports = [
      ./desktop
    ];

    home.packages = [
      (lid-switch)
    ];

      wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  wayland.windowManager.hyprland.systemd.variables = ["--all"];

  home.sessionVariables = {
     QT_QPA_PLATFORM = "wayland";
     SDL_VIDEODRIVER = "wayland";
     XDG_SESSION_TYPE = "wayland";
  };
}
