{ config, lib, ... }:
let
  cfg = config.host;
in
with lib;
{
  imports = [
    ../common/system 
  ];

  options.host = {
    hostName = mkOption {
      type = types.str;
      default = "nixos";
      description = "Network Hostname";
    };
    hostConfig = mkOption {
      type = types.path;
      default = ../hosts/${config.host.hostName};
      description = "Path to the host specific configuration.";
    };
    hostHome = mkOption {
      type = types.path;
      default = ../hosts/${config.host.hostName}/home;
      description = "Path to the host specific homemanager config.";
    };
    common = mkOption {
      type = types.bool;
      default = false;
      description = "Should the host use the common system configuration?";
    };
    laptop = mkOption {
      type = types.bool;
      default = false;
      description = "Is the host a laptop?";
    };
    ryzen = mkOption {
      type = types.bool;
      default = false;
      description = "Does the host have a ryzen CPU?";
    };
  };

  config = mkMerge [
    {
      networking.hostName = cfg.hostName;
      ryzen-settings.enable = cfg.ryzen;
      commonSystem.enable = cfg.common;
    }
  ];
}
