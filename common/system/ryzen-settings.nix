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
    boot.kernelParams = [ "processor.max_cstate=5" "amd_pstate=guided" ]; # lmao
    powerManagement.enable = true;
    powerManagement.cpuFreqGovernor = "schedutil";
  };
}
