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
      url = "github:hyprwm/hyprland-plugins";
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

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-flatpak,
      ...
    }@inputs:
    {
      nixosCommonSystem =
        host:
        let
          hostConfig =
            if host ? hostConfig then
              host.hostConfig
            else if host ? hostName then
              ./hosts/${host.hostName}
            else
              null;
        in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            home-manager.nixosModules.home-manager
            ./modules/isaac.nix
            ./modules/host.nix
            ./modules/libadwaita-without-adwaita.nix
            nix-flatpak.nixosModules.nix-flatpak
            {
              inherit host;
              imports = [ hostConfig ];
              isaac.enable = true;
              isaac.useHomeManager = true;
              libadwaita-without-adwaita.enable = false;
            }
          ];
        };

      nixosConfigurations = {
        envy = self.nixosCommonSystem {
          hostName = "envy";
          common = true;
          laptop = true;
          ryzen = true;
        };
        aorus = self.nixosCommonSystem {
          hostName = "aorus";
          common = true;
          laptop = false;
          ryzen = true;
        };
        basedpad = self.nixosCommonSystem {
          hostName = "basedpad";
          common = true;
          laptop = true;
          ryzen = false;
        };
      };
    };
}
