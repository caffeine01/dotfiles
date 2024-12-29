{pkgs, ...}:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    ''; #disable
    plugins = [ { name = "tide"; src = pkgs.fishPlugins.tide.src; } ];
  };
}