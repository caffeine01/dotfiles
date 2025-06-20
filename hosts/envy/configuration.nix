# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
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
      {
        keys = [ 224 ];
        events = [ "key" ];
        command = "/run/current-system/sw/bin/light -U 10";
      }
      {
        keys = [ 225 ];
        events = [ "key" ];
        command = "/run/current-system/sw/bin/light -A 10";
      }
    ];
  };

  services.fwupd.enable = true;
  services.thermald.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = true;
  services.flatpak.enable = true;
  programs.adb.enable = true;
  programs.kdeconnect.enable = true;

  services.flatpak.packages = [
    "org.vinegarhq.Sober"
  ];

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  #virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  boot = {
    loader.systemd-boot.enable = false;
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
    kernelParams = [ ''acpi_osi="!Windows 2020"'' ];
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
  };

  #services.udev.extraHwdb = ''
  #sensor:modalias:platform:lis3lv02d:dmi:*svn*HP*:*
  #  ACCEL_LOCATION=base
  #'';

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
