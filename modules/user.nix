{ lib, userName, description, shell, extraGroups, systemPackages ? [], enableHomeManager ? false, commonHomeManagerConfig ? {}, machineHomeManagerConfig ? {}, additionalConfig ? {}, ... }:
{
  config = lib.mkMerge [
    # System user configuration
    {
      users.users."${userName}" = lib.mkMerge [
        {
          isNormalUser = true;
          description = description;
          shell = shell;
          home = "/home/${userName}";
          extraGroups = extraGroups;
          packages = systemPackages;
        }
        additionalConfig
      ];
    }

    # Optional Home Manager configuration
    (lib.mkIf enableHomeManager {
      home-manager.users."${userName}" = lib.mkMerge [
        {
          home.stateVersion = "24.11";
        }
        import commonHomeManagerConfig
        import machineHomeManagerConfig
      ];
    })
  ];
}