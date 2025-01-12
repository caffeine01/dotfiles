let
  kittyConfig = ./kitty.conf;
  kittyTheme = ./gruvbox-kitty.conf;
in
with builtins;
{
  home.file = {
    ".config/kitty/kitty.conf" = {
      text = readFile kittyConfig;
    };
    ".config/kitty/gruvbox-kitty.conf" = {
      text = readFile kittyTheme;
    };
  };
}
