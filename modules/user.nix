{ lib, config, inputs, ... }:
with lib;
let 
  cfg = config.userModule;
in
{
  options.userModule = {
    userName = mkOption {
      type = types.str;
      description = "Username";
    };
    description = mkOption {
      type = types.str;
      description = "User description";
    };
    shell = mkOption {
      type = types.package;
      description = "User shell";
    };
    extraGroups = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Additional groups";
    };
    userPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "User packages";
    };
    enableHomeManager = mkOption {
      type = types.bool;
      default = false;
      description = "Enable home-manager";
    };
    homeManagerConfig = mkOption {
      type = types.attrs;
      default = {};
      description = "Home-manager configuration";
    };
    additionalConfig = mkOption {
      type = types.attrs;
      default = {};
      description = "Additional configuration";
    };
  };

  config = mkMerge [
    {
      users.users."${cfg.userName}" = mkMerge [
        {
          inherit (cfg) description shell extraGroups;
          isNormalUser = true;
          home = "/home/${cfg.userName}";
          packages = cfg.userPackages;
        }
        cfg.additionalConfig
      ];
    }
    (mkIf cfg.enableHomeManager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.users."${cfg.userName}" = mkMerge [
        {
        home.stateVersion = "24.11";
        }
        cfg.homeManagerConfig
      ];
    }
    )
  ];
}
