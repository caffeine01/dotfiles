# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ./services
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
	      General = {
		      Experimental = true;
        };
      };
    };

    sensor.iio.enable = true;

    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

  
  #services.greetd = let 
  #  session = {
  #     command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
  #     user = "isaac";
  #   };
  #in {
  #  enable = true;
  #  settings = {
  #    terminal.vt = 1;
  #    default_session = session;
  #    initial_session = session;
  #  };
  #};

  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.fwupd.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = true;

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  #virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_full;

  #qemu patch
  #nixpkgs.overlays = with pkgs; [
  #  (self: super: {
  #    qemu_full = super.qemu_full.overrideAttrs (oldAttrs: {
  #      postPatch = oldAttrs.postPatch + ''
  #        sed -i 's/GUI_REFRESH_INTERVAL_DEFAULT 30/GUI_REFRESH_INTERVAL_DEFAULT 16/g' include/ui/console.h
  #      '';
  #    });
  #  })
  #];

  # Make steam work
  hardware.graphics.enable32Bit = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
  };

  # Use the grub boot loader.
  boot = {
    loader.systemd-boot.enable = false;
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      efiSupport = true;
      devices=[ "nodev" ];
    };
    initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
  };

  # Networking shit
  networking.hostName = "envy";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Time zone.
  time.timeZone = "Europe/London";
  
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
  
  environment.gnome.excludePackages = with pkgs; [
    baobab      # disk usage analyzer
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
    orca
  ];

  services.printing.enable = true;

  services.udev.extraHwdb = ''
    sensor:modalias:platform:HID-SENSOR-200011:dmi:*svn*HP*:*
      PROXIMITY_NEAR_LEVEL=100
    sensor:modalias:platform:lis3lv02d:dmi:*svn*HP*:*
      ACCEL_LOCATION=base
  '';

  # Audio services.
  hardware.pulseaudio.enable = false;
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
  
  #adb
  programs.adb.enable = true;

  programs.fish.enable = true;
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

  home-manager = {
    extraSpecialArgs = { 
      inherit inputs;
    };
    users = {
      "isaac" = import ./users/isaac;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "dotnet-runtime-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

