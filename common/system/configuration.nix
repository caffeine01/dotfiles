{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.commonSystem;
in
{
  options.commonSystem = {
    enable = mkEnableOption "Enables the common system configuration.";
  };

  config = mkIf cfg.enable {

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    hardware.enableRedistributableFirmware = true; # why would you not want this enabled lmao

    # Hooperlond
    programs.uwsm.enable = true;
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    nix.settings = {
      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    
    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      SDL_VIDEODRIVER = "wayland";

      _JAVA_AWT_WM_NONEREPARENTING = "1";

      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";

      QT_QPA_PLATFORM = "wayland";
    };

    # Make steam work
    hardware.graphics.enable32Bit = true;

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      # Fallback
      desktopManager.gnome.enable = true;
    };

    # network manager
    networking.networkmanager.enable = true;

    # BRI ISH
    time.timeZone = "Europe/London";

    # Typefaces :drool:
    fonts = {
      fontDir.enable = true;
      fontconfig.enable = true;
      packages = with pkgs; [
        jetbrains-mono
        fira-code
        fira-code-symbols
        dejavu_fonts
        nerd-fonts.symbols-only
      ];
    };

    # BLoat
    environment.gnome.excludePackages = with pkgs; [
      cheese # photo booth
      eog # image viewer
      epiphany # web browser
      simple-scan # document scanner
      totem # video player
      yelp # help vprograms
      evince # document viewer
      file-roller # archive manager
      geary # email client
      seahorse # password manager
      orca # screen reader
    ];

    # Justin Case
    services.printing.enable = true;

    # Audio services.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      #extraConfig.pipewire."92-low-latency" = {
      #  "context.properties" = {
      #    "default.clock.rate" = 44100;
      #    "default.clock.quantum" = 512;
      #    "default.clock.min-quantum" = 512;
      #    "default.clock.max-quantum" = 512;
      #  };
      #};
    };

    environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      neovim
      libinput
      python3
      gcc
      git # DO NOT REMOVE!!!!!!!
      pkg-config
      home-manager
      jq
    ];

    nixpkgs.config.allowUnfree = true;
  };
}
