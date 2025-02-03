{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.ryzen-settings;
  isLaptop = config.host.laptop;
  pstate = if isLaptop then "guided" else "active";
in
{
  options.ryzen-settings = {
    enable = mkEnableOption "Enable various ryzen-specific tweaks.";
  };

  config = mkIf cfg.enable {
    hardware.cpu.amd.updateMicrocode = mkDefault true;
    boot.blacklistedKernelModules = mkMerge [ [ "k10temp" ] ];
    boot.extraModulePackages = mkMerge [ [ config.boot.kernelPackages.zenpower ] ];
    boot.kernelModules = mkMerge [ [ "zenpower" ] ];
    boot.kernelParams = mkMerge [ [ "processor.max_cstate=5" "amd_pstate=${pstate}" ] (mkIf isLaptop [ "amdgpu.abmlevel=0" ])  ];
    powerManagement.enable = mkDefault true;
    powerManagement.cpuFreqGovernor = mkDefault "schedutil";
  };
}
