{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Gruvbox-Dark-Medium";
      package = pkgs.gruvbox-gtk-theme;
    };

    iconTheme = {
      name = "Gruvbox Plus Dark";
      package = pkgs.gruvbox-plus-icons;
    };

    font = {
     name = "JetBrains Mono Regular";
     size = 10;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark"; 
    };
  };
}
