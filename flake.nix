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
      url = "github:caffeine01/hyprland-plugins";
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
  outputs = { self, nixpkgs,... }@inputs:
  {
    nixosConfigurations.envy = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./hosts/envy
        ./users/isaac
        ./common
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
