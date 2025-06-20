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
    ./services
  ];

  ryzen-settings.enable = true; # enable the pstate fixes n whatnot

  hardware = {
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };

  services.fwupd.enable = true;
  services.udisks2.enable = true;

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

  # Use the grub boot loader.
  boot = {
    loader.systemd-boot.enable = false;
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
    initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  programs.coolercontrol.enable = true; # nzxt kraken

  #adb
  programs.adb.enable = true;

  environment.systemPackages = [ pkgs.gparted ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?
}
