{ pkgs, inputs, ... }:
{
  imports = [
      ./desktop
      ./services
      ./packages
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.variables = ["--all"];

  home.sessionVariables = {
     QT_QPA_PLATFORM = "wayland";
     SDL_VIDEODRIVER = "wayland";
     XDG_SESSION_TYPE = "wayland";
  };    # EDITOR = "emacs";
  
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    ''; #disable 
    plugins = [ { name = "tide"; src = pkgs.fishPlugins.tide.src; } ];
  };
}
