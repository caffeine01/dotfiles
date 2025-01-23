{ pkgs, lib, config, hostName, ... }:
with lib;
let
  cfg = config.ryzen-settings;
in
{
  options.ryzen-settings = {
    enable = mkEnableOption "Enable ryzen power fixes.";
  };

  config = mkIf cfg.enable {
    hardware.cpu.amd.updateMicrocode = true;
    boot.blacklistedKernelModules = [ "k10temp" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.zenpower ];
    boot.kernelModules = mkMerge [ [ "zenpower" ] ];
    boot.kernelParams = mkMerge [ [ "processor.max_cstate=5" "amd_pstate=active" ] ];
    powerManagement.enable = true;
    powerManagement.cpuFreqGovernor = "schedutil";
  };
}
