{ config, lib, pkgs, inputs, hostName, ... }:
{

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    networking.hostName = hostName; # because obviously

    # Hooperlond
    programs.uwsm.enable = true;
    programs.hyprland = {
        enable = true;
        withUWSM = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    # Make steam work
    hardware.graphics.enable32Bit = true;

    # Fallback
    services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        displayManager.gdm.wayland = true;
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
            fira-code
            fira-code-symbols
            dejavu_fonts
            nerd-fonts.symbols-only
        ];
    };

    # BLoat
    environment.gnome.excludePackages = with pkgs; [
        cheese      # photo booth
        eog         # image viewer
        epiphany    # web browser
        simple-scan # document scanner
        totem       # video player
        yelp        # help vprograms
        evince      # document viewer
        file-roller # archive manager
        geary       # email client
        seahorse    # password manager  
        orca        # screen reader
    ];

    # Justin Case
    services.printing.enable = true;

    # Audio services.
    services.pulseaudio.enable = false;
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
}
