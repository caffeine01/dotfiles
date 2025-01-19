{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    iio-hyprland.url = "github:caffeine01/hyprrot";

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
    };

    hyprland-plugins = {
      url = "github:caffeine01/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; 
    };

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; 
    };

    nwg-drawer = {
      url = "github:caffeine01/nwg-drawer?ref=nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.url = "github:nix-systems/default-linux";
    };

  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  {
    nixosCommonSystem = hostName: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs hostName; };
      modules = [
        ./common/system
        ./hosts/${hostName}
        ./modules/isaac.nix
        home-manager.nixosModules.home-manager
        {
          isaac.enable = true;
          isaac.useHomeManager = true;
        }
      ];
    };

    nixosConfigurations = {
      envy = self.nixosCommonSystem "envy";
      aorus = self.nixosCommonSystem "aorus";
      basedpad = self.nixosCommonSystem "basedpad";
    };
  };
}
