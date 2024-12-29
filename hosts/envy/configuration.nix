# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./services
    ];

  environment.systemPackages = with pkgs; [
    firefox
  ];    
  
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
  #virtualisation.libvirtd.qemu.package = pkgs.qemu_full;

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

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
  };

      boot = {
        loader.systemd-boot.enable = false;
        loader.efi.canTouchEfiVariables = true;
        loader.grub = {
            enable = true;
            efiSupport = true;
            devices=[ "nodev" ];
        };
        kernelPackages = pkgs.linuxPackages_latest;
            initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
    };

  services.udev.extraHwdb = ''
    sensor:modalias:platform:HID-SENSOR-200011:dmi:*svn*HP*:*
      PROXIMITY_NEAR_LEVEL=100
    sensor:modalias:platform:lis3lv02d:dmi:*svn*HP*:*
      ACCEL_LOCATION=base
  '';

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
  # out of date, out of support, or vulnerable.ls
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

