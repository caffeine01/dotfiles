{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    iio-hyprland.url = "github:JeanSchoeller/iio-hyprland";

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; 
    };

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; 
    };

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs:
  {
    # envy
    nixosConfigurations = {
      nixpkgs.lib.genAttrs ["envy"] (hostName: nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs hostName;
      };
      modules = [
        ./common/system
        ./hosts/${hostName}
        ./modules/isaac.nix
        inputs.home-manager.nixosModules.home-manager
        {
          isaac.enable = true;
          isaac.useHomeManager = true;
        }
      ];
    });

      nixpkgs.lib.genAttrs ["aorus"] (hostName: nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs hostName;
      };
      modules = [
        ./common/system
        ./hosts/${hostName}
        ./modules/isaac.nix
        inputs.home-manager.nixosModules.home-manager
        {
          isaac.enable = true;
          isaac.useHomeManager = true;
        }
      ];
    });

    }
  };

  #soon
}
