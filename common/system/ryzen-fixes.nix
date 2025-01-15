{ pkgs, lib, config, hostName, ... }:
with lib;
let
  cfg = config.ryzen-fixes;
in
{
  options.ryzen-fixes = {
    enable = mkEnableOption "Enable ryzen power fixes.";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [ "processor.max_cstate=5" "amd_pstate=guided" ]; # lmao
    powerManagement.enable = true;
    powerManagement.cpuFreqGovernor = "schedutil";
  };
}
