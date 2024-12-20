{ pkgs, inputs, ... }:
{
  imports = [
      ./desktop
      ./services
      ./packages
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  wayland.windowManager.hyprland.systemd.variables = ["--all"];

  home.sessionVariables = {
     QT_QPA_PLATFORM = "wayland";
     SDL_VIDEODRIVER = "wayland";
     XDG_SESSION_TYPE = "wayland";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    ''; #disable 
    plugins = [ { name = "tide"; src = pkgs.fishPlugins.tide.src; } ];
  };
}
